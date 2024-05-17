from flask import Flask, request, jsonify
import joblib
import numpy as np
import pandas as pd

app = Flask(__name__)

# Load the trained model
model = joblib.load('functions/rf_model.pkl')

# Define preprocessing function
def preprocess_input(data):
    # Assuming your data has the same format as your training data
    X_cols = ['GrossSquareMeters', 'NumberOfRooms', 'hall', 'BuildingAge', 'NumberOfBathrooms']
    district_cols = ['district_Avcilar', 'district_Bahcesehir', 'district_Bagcilar', 'district_Bakirkoy', 'district_Besiktas', 'district_Beylikduzu', 'district_Beyoglu', 'district_Esenler', 'district_Esenyurt', 'district_Fatih', 'district_Gaziosmanpasa', 'district_Kadikoy', 'district_Kartal', 'district_Kucukcekmece', 'district_Maltepe', 'district_Pendik', 'district_Sancaktepe', 'district_Sariyer', 'district_Silivri', 'district_Sisli', 'district_Tuzla', 'district_Umraniye', 'district_Uskudar', 'district_Zeytinburnu']
    item_cols = ['ItemStatus_Boş', 'ItemStatus_Dolu']
    floor_cols = ['FloorLocation_Basement', 'FloorLocation_ÇatıKatı', 'FloorLocation_DüzGiriş', 'FloorLocation_High', 'FloorLocation_Low', 'FloorLocation_Low-Mid', 'FloorLocation_Mid', 'FloorLocation_Very High']
    heating_cols = ['Heating_Kalorifer (Doğalgaz)', 'Heating_Kombi', 'Heating_Merkezi Sistem (Isı payı ölçer)', 'Heating_Soba (Elektrikli)', 'Heating_Yok']
    site_cols = ['Site_ Hayır', 'Site_ Var']
    
    # Create a DataFrame from the JSON input
    df = pd.DataFrame(data, index=[0])
    
    # Add dummy columns for categorical variables
    df_district = pd.get_dummies(df['district']).reindex(columns=district_cols, fill_value=0)
    df_item = pd.get_dummies(df['ItemStatus']).reindex(columns=item_cols, fill_value=0)
    df_floor = pd.get_dummies(df['FloorLocation']).reindex(columns=floor_cols, fill_value=0)
    df_heating = pd.get_dummies(df['HeatingType']).reindex(columns=heating_cols, fill_value=0)
    df_site = pd.get_dummies(df['InsideTheSite']).reindex(columns=site_cols, fill_value=0)
    
    # Concatenate all DataFrames
    df_processed = pd.concat([df[X_cols], df_district, df_item, df_floor, df_heating, df_site], axis=1)
    
    return df_processed

# Define prediction function
@app.route('/predict', methods=['POST'])
def predict():
    try:
        # Get JSON request data
        data = request.get_json()
        
        # Preprocess input
        input_data = preprocess_input(data)
        
        # Make prediction
        prediction = model.predict(input_data)
        
        # Return JSON response
        response = {'predictedPrice': prediction[0]}  # Assuming prediction is a single value
        return jsonify(response)
    
    except Exception as e:
        return jsonify({'error': str(e)}), 400

if __name__ == '__main__':
    app.run(debug=True)
