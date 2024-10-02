from flask import Flask, request, jsonify
from flask_cors import CORS
from chatbot import qa_bot
import logging

app = Flask(__name__)
CORS(app)

# Set up logging
logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)

# Initialize the QA bot
try:
    qa_chain = qa_bot()
    logger.info("QA bot initialized successfully")
except Exception as e:
    logger.error(f"Failed to initialize QA bot: {str(e)}")
    qa_chain = None

@app.route('/ask', methods=['POST'])
def ask_question():
    logger.debug("Received request")
    data = request.json
    logger.debug(f"Request data: {data}")
    question = data.get('question')
    
    if not question:
        logger.warning("No question provided")
        return jsonify({'error': 'No question provided'}), 400

    if qa_chain is None:
        logger.error("QA bot not initialized")
        return jsonify({'error': 'QA bot not initialized'}), 500

    try:
        logger.info(f"Processing question: {question}")
        response = qa_chain({'query': question})
        answer = response['result']
        sources = response['source_documents']

        source_list = [source.metadata.get('source', 'Unknown source') for source in sources]
        
        logger.info(f"Generated answer: {answer}")
        logger.debug(f"Sources: {source_list}")

        return jsonify({
            'answer': answer,
            'sources': source_list
        })
    except Exception as e:
        logger.error(f"Error processing question: {str(e)}")
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)