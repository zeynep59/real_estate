from flask import Flask, request, jsonify
import joblib
import pandas as pd
import logging
import numpy as np

app = Flask(__name__)

# Configure logging
logging.basicConfig(level=logging.DEBUG)

# Load your trained model
model_path = 'C:\\Users\\oztur\\Documents\\real_estate\\functions\\model.pkl'
model = joblib.load(model_path)

def preprocess_input(data):
    try:
        # Convert input data to DataFrame
        input_df = pd.DataFrame([data])

        # Check if 'price' exists in the data
        if 'price' in input_df.columns:
            # Remove the 'price' column
            input_df.drop('price', axis=1, inplace=True)

        # Categorical columns to be one-hot encoded
        categorical_columns = ['district', 'item', 'floor', 'heating', 'site']

        # Ensure all required columns are in the input data
        for col in categorical_columns:
            if col not in input_df.columns:
                input_df[col] = None  # or set a default value

        # One-hot encode categorical features
        input_df = pd.get_dummies(input_df, columns=categorical_columns, drop_first=False)

        # Ensure all columns expected by the model are present
        expected_columns = model.feature_names_in_
        for col in expected_columns:
            if col not in input_df.columns:
                input_df[col] = 0

        # Reorder columns to match the model's training
        input_df = input_df[expected_columns]

        logging.debug(f"Preprocessed input data: {input_df}")

        return input_df
    except Exception as e:
        logging.exception("An error occurred during preprocessing")
        raise e

# Define a route for your prediction API
@app.route('/predict', methods=['POST'])
def predict():
    try:
        # Get JSON request data
        data = request.get_json()
        logging.debug(f"Incoming data: {data}")

        # Preprocess the input data
        df = preprocess_input(data)
        logging.debug(f"Preprocessed data: {df}")

        # Make prediction
        prediction = model.predict(df)
        logging.debug(f"Prediction: {prediction[0]}")

        # Return JSON response
        response = {'predictedPrice': float(prediction[0])}
        return jsonify(response)

    except Exception as e:
        logging.exception("An error occurred during prediction")
        return jsonify({'error': str(e)}), 400

if __name__ == '__main__':
    try:
        app.run(debug=True, host='0.0.0.0')
    except Exception as e:
        logging.exception("Failed to start the Flask application")
        raise
