import os
from flask import Flask, request, jsonify
from werkzeug.utils import secure_filename
from flask_sqlalchemy import SQLAlchemy
from chatbot import get_chatbot_response

app = Flask(__name__)

# Configuration for file storage and database
UPLOAD_FOLDER = 'uploads'  # Directory where files will be saved
MAX_STORAGE_LIMIT = 15 * 1024 * 1024 * 1024  # 15 GB storage limit
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///file_storage.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Initialize the database
db = SQLAlchemy(app)

# Define a model to store file metadata
class File(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    filename = db.Column(db.String(150), nullable=False)
    file_size = db.Column(db.Integer, nullable=False)
    upload_time = db.Column(db.DateTime, default=db.func.current_timestamp())

# Create the database tables
with app.app_context():
    db.create_all()

# Helper function to calculate the current storage used
def calculate_storage_used():
    files = File.query.all()
    total_size = sum([f.file_size for f in files])
    return total_size

# Endpoint for chatbot interaction
@app.route('/chat', methods=['POST'])
def chat():
    try:
        data = request.json
        user_prompt = data.get('prompt', '')

        if user_prompt:
            response = get_chatbot_response(user_prompt)
            return jsonify({"response": response}), 200
        else:
            return jsonify({"error": "No prompt provided"}), 400
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# Endpoint to upload a file
@app.route('/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return jsonify({"error": "No file part in the request"}), 400

    file = request.files['file']

    if file.filename == '':
        return jsonify({"error": "No file selected for uploading"}), 400

    if file:
        filename = secure_filename(file.filename)
        file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)

        # Get the size of the uploaded file
        file_size = len(file.read())
        file.seek(0)  # Reset file cursor

        # Check the current storage usage
        current_storage = calculate_storage_used()

        if current_storage + file_size > MAX_STORAGE_LIMIT:
            return jsonify({"error": "Storage limit exceeded"}), 400

        # Save the file
        file.save(file_path)

        # Store file metadata in the database
        new_file = File(filename=filename, file_size=file_size)
        db.session.add(new_file)
        db.session.commit()

        return jsonify({"message": "File uploaded successfully", "file_size": file_size}), 200

# Endpoint to get the storage usage details
@app.route('/storage', methods=['GET'])
def storage_usage():
    total_used = calculate_storage_used()
    return jsonify({"used_storage": total_used, "remaining_storage": MAX_STORAGE_LIMIT - total_used}), 200

if __name__ == '__main__':
    # Ensure the uploads folder exists
    if not os.path.exists(UPLOAD_FOLDER):
        os.makedirs(UPLOAD_FOLDER)
    
    app.run(debug=True, port=5000)
