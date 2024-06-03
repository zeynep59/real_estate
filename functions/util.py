from flask import Flask, request, jsonify
import numpy as np
import pandas as pd
import joblib

# Load the trained model
model = joblib.load("functions/rf_model.pkl")
print(model)
# Define the Flask app
app = Flask(__name__)

# Define the route for prediction
@app.route('/predict', methods=['POST'])
def predict():
    # Get the JSON data from the request
    data = request.get_json()
    
    # Print the incoming JSON data for debugging
    print(f"Incoming data: {data}")

    # Extract and map the correct values
    district = data['address']['district']
    item = data['address']['street']  # Assuming 'item' refers to the street
    floor = data['floorOn']
    heating = data['heating']
    site = 'N/A'  # Set to 'N/A' or another default value if 'site' isn't available
    sqmt = data['squaremeter']
    room = data['numberOfRooms']
    hall = data['numberOfHalls']
    age = data['buildingAge']
    wc = data['numberOfBaths']

    # Make prediction using the predict_price function
    prediction = model.predict(district, item, floor, heating, site, sqmt, room, hall, age, wc)

    # Return the prediction as JSON response
    return jsonify({'predicted_price': prediction})



# Run the Flask app
if __name__ == '__main__':
    app.run(debug=True)
