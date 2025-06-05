# ClinicDB-Relational-Information-System-for-Diagnostic-Clinics
This project was developed as part of the "DBMS – Master AI&DS 2024/25" course. It presents the design and implementation of a relational database for a private clinic specialized in diagnostic services.

## 📌 Project Goals

- Manage diagnostic exam bookings
- Store information about patients, doctors, and partner laboratories
- Handle clinical reports and test outcomes
- Track payments and patient feedback

## 🗂 Repository Contents

- `Relazione_AT_FR_JM.docx`: full project documentation (in Italian)
- `Codice_Progetto_AT_FR_JS.sql`: SQL script for database creation
- `Tabelle create per test/`: sample data in `.csv` format for all main entities

## 🏗 Database Structure

The main modeled entities include:

- **Patient**: personal data, tax code, contact details
- **Doctor**: identification, specialization, associated exams
- **Exam**: type, outcome, doctor assignment
- **Booking**: schedule, status
- **Payment**: amount, method, status
- **Report**: clinical result
- **Review**: patient feedback
- **Partner Laboratories**: external labs for exam execution

## ▶️ How to Use

1. Import the SQL script `Codice_Progetto_AT_FR_JS.sql` into a relational DBMS (e.g., MySQL or PostgreSQL).
2. Populate tables using the `.csv` files located in the `Tabelle create per test/` folder.
3. Refer to the documentation file for the complete conceptual and logical model.
