import sys
import os
from langchain_core.prompts import PromptTemplate
from langchain.chains import RetrievalQA
from langchain_community.embeddings import HuggingFaceBgeEmbeddings
from langchain_community.vectorstores import FAISS
from langchain_community.document_loaders import DirectoryLoader, PyPDFLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_community.llms import CTransformers
from langchain.memory import ConversationBufferMemory

DATA_PATH = "data/"
DB_FAISS_PATH = "vectorstores/db_FAISS"
MODEL_PATH = "model/llama-2-7b-chat.ggmlv3.q8_0.bin" 

def create_vectorDB():
    if not os.path.exists(DATA_PATH):
        print(f"Error: The directory {DATA_PATH} does not exist.")
        print(f"Please create the '{DATA_PATH}' directory and add your PDF documents to it.")
        print("Then run this script again with the --create-db flag.")
        return

    loader = DirectoryLoader(DATA_PATH, glob='*.pdf', loader_cls=PyPDFLoader)
    docs = loader.load()
    if not docs:
        print(f"No PDF documents found in {DATA_PATH}")
        print("Please add your PDF documents to the 'data/' directory and run this script again.")
        return

    textSplitter = RecursiveCharacterTextSplitter(chunk_size=500, chunk_overlap=50)
    text = textSplitter.split_documents(docs)
    embeddings = HuggingFaceBgeEmbeddings(
        model_name='sentence-transformers/all-MiniLM-L6-v2',
        model_kwargs={'device': 'cpu'},
        encode_kwargs={'normalize_embeddings': False}  # Faster, but slightly less accurate
    )

    db = FAISS.from_documents(text, embeddings)
    os.makedirs(os.path.dirname(DB_FAISS_PATH), exist_ok=True)
    db.save_local(DB_FAISS_PATH)
    print(f"Vector database created successfully at {DB_FAISS_PATH}")

custom_prompt_temp = """Use the following pieces of information to answer the user's question. If you don't know the answer, 
please say that you don't know, don't make up an answer.

Context: {context}
Chat History: {chat_history}
Question: {question}
Only return a correct and helpful answer below or nothing else
Helpful answer:"""

def set_custom_prompt():
    prompt = PromptTemplate(template=custom_prompt_temp, input_variables=['context', 'chat_history', 'question'])
    return prompt

def load_llm():
    if not os.path.exists(MODEL_PATH):
        print(f"Error: The model file {MODEL_PATH} does not exist.")
        print("Please download the Llama 2 model and place it in the 'models' directory.")
        print("You can download it from: https://huggingface.co/TheBloke/Llama-2-7B-Chat-GGML")
        sys.exit(1)
    
    llm = CTransformers(
        model=MODEL_PATH,
        model_type='llama',
        max_new_tokens=256,  # Reduced for faster responses
        temperature=0.7,  # Slightly increased for more varied responses
        top_k=50,  # Add top_k sampling for improved speed
        top_p=0.95,  # Add top_p sampling for improved speed
    )
    return llm

def retrieval_qa_chain(llm, prompt, db):
    memory = ConversationBufferMemory(memory_key="chat_history", input_key="question")
    
    qa_chain = RetrievalQA.from_chain_type(
        llm=llm,
        chain_type='stuff',
        retriever=db.as_retriever(search_kwargs={'k': 1}),  # Reduced to 1 for faster retrieval
        return_source_documents=True,
        chain_type_kwargs={'prompt': prompt, 'memory': memory}
    )
    return qa_chain

def qa_bot():
    embeddings = HuggingFaceBgeEmbeddings(
        model_name='sentence-transformers/all-MiniLM-L6-v2',
        model_kwargs={'device': 'cpu'},
        encode_kwargs={'normalize_embeddings': False}  # Faster, but slightly less accurate
    )
    
    if not os.path.exists(DB_FAISS_PATH):
        print(f"Error: The vector database at {DB_FAISS_PATH} does not exist. Please create it first.")
        sys.exit(1)
    
    db = FAISS.load_local(DB_FAISS_PATH, embeddings, allow_dangerous_deserialization=True)
    llm = load_llm()
    qa_prompt = set_custom_prompt()
    qa = retrieval_qa_chain(llm, qa_prompt, db)
    return qa

def main():
    if not os.path.exists(DB_FAISS_PATH):
        print(f"Error: The vector database at {DB_FAISS_PATH} does not exist.")
        print("Please run the script with the --create-db flag first:")
        print("python medical_chatbot.py --create-db")
        return

    if not os.path.exists(MODEL_PATH):
        print(f"Error: The model file {MODEL_PATH} does not exist.")
        print("Please download the Llama 2 model and place it in the 'models' directory.")
        print("You can download it from: https://huggingface.co/TheBloke/Llama-2-7B-Chat-GGML")
        return

    print("Welcome to the Medical Chatbot!")
    print("Type 'quit' to exit the program.")

    qa_chain = qa_bot()

    while True:
        query = input("\nEnter your question: ")
        if query.lower() == 'quit':
            print("Thank you for using the Medical Chatbot. Goodbye!")
            break

        try:
            response = qa_chain({'query': query})
            answer = response['result']
            sources = response['source_documents']

            print("\nAnswer:", answer)
            
            if sources:
                print("\nSources:")
                for i, source in enumerate(sources, 1):
                    print(f"{i}. {source.metadata.get('source', 'Unknown source')}")
            else:
                print("\nNo sources found for this answer.")
        except Exception as e:
            print(f"An error occurred: {str(e)}")
            print("Please try again or type 'quit' to exit.")

if __name__ == '__main__':
    if len(sys.argv) > 1 and sys.argv[1] == '--create-db':
        create_vectorDB()
    else:
        main()