from flask import Flask, request, jsonify
import joblib

app = Flask(__name__)

# Load your trained model
model = joblib.load('path_to_your_trained_model.pkl')

# Define a route for your prediction API
@app.route('/predict', methods=['POST'])
def predict():
    try:
        # Get JSON request data
        data = request.get_json()

        # Extract features from JSON
        squaremeter = data['squaremeter']
        numberOfRooms = data['numberOfRooms']
        numberOfHalls = data['numberOfHalls']
        numberOfBaths = data['numberOfBaths']
        buildingAge = data['buildingAge']
        numberOfFloors = data['numberOfFloors']
        grossArea = data['grossArea']
        terraceArea = data['terraceArea']
        facade = data['facade']
        landscape = data['landscape']
        opportunities = data['opportunities']
        heating = data['heating']

        # Convert opportunities to string
        opportunities = ', '.join(opportunities)

        # Make prediction
        prediction = model.predict([[squaremeter, numberOfRooms, numberOfHalls, numberOfBaths,
                                      buildingAge, numberOfFloors, grossArea, terraceArea, facade, landscape,
                                      opportunities, heating]])

        # Return JSON response
        response = {'predictedPrice': float(prediction[0])}  # Convert prediction to float
        return jsonify(response)

    except Exception as e:
        return jsonify({'error': str(e)}), 400

if __name__ == '__main__':
    app.run(debug=True)



# predict_price("bagcilar", "Boş","ÇatıKatı","Heating_Klimalı","Hayır",50, 3, 0,5,1)
