# Welcome to Cloud Functions for Firebase for Python!
# To get started, simply uncomment the below code or create your own.
# Deploy with `firebase deploy`
from flask import Flask, request, jsonify
from firebase_functions import https_fn
from firebase_admin import initialize_app, credentials, firestore


app = Flask(__name__)

cred = credentials.Certificate()
firebase_admin.initialize_app(crud)
db =  firestore.client()

@app.route('/', methods=['GET', 'POST'])
def home():
    if request.method == 'POST':
        data =  request.get_json()
        return jsonify({'message': 'bablabala'})
#
#
# @https_fn.on_request()
# def on_request_example(req: https_fn.Request) -> https_fn.Response:
#     return https_fn.Response("Hello world!")