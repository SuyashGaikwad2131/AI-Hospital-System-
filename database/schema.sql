-- Patient Table
CREATE TABLE patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    gender ENUM('Male', 'Female', 'Other'),
    contact_no VARCHAR(15),
    address TEXT,
    medical_history TEXT
);

-- Doctor Table
CREATE TABLE doctor (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    specialization VARCHAR(100),
    contact_no VARCHAR(15)
);

-- Appointment Table
CREATE TABLE appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    FOREIGN KEY(patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY(doctor_id) REFERENCES doctor(doctor_id)
);

-- Diagnosis Table
CREATE TABLE diagnosis (
    diagnosis_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    diagnosis_details TEXT,
    predicted_disease VARCHAR(100),
    date_of_diagnosis DATE,
    FOREIGN KEY(patient_id) REFERENCES patient(patient_id)
);

-- Billing Table
CREATE TABLE billing (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    amount DECIMAL(10, 2),
    payment_status ENUM('Pending', 'Paid'),
    date_of_bill DATE,
    FOREIGN KEY(patient_id) REFERENCES patient(patient_id)
);
