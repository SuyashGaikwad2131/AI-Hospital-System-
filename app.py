from flask import Flask, request, jsonify
import joblib
import pandas as pd
import mysql.connector

app = Flask(__name__)

# Load prediction model
model = joblib.load('model/disease_prediction_model.pkl')

# Database connection setup (replace with your database credentials)
def get_db_connection():
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="password",
        database="hospital_db"
    )
    return conn

@app.route('/add_patient', methods=['POST'])
def add_patient():
    data = request.get_json()
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("""
        INSERT INTO patient (name, age, gender, contact_no, address, medical_history)
        VALUES (%s, %s, %s, %s, %s, %s)
    """, (data['name'], data['age'], data['gender'], data['contact_no'], data['address'], data['medical_history']))
    conn.commit()
    cursor.close()
    conn.close()
    return jsonify({"message": "Patient added successfully"})

@app.route('/predict_disease', methods=['POST'])
def predict_disease():
    data = request.get_json()
    patient_data = pd.DataFrame(data, index=[0])
    prediction = model.predict(patient_data)
    return jsonify({"predicted_disease": prediction[0]})

if __name__ == '__main__':
    app.run(debug=True)
