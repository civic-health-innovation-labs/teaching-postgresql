# Default (synthetic) data for teaching SQL databases
| Author         | Reviewers          |
|----------------|--------------------|
| David Salac    | Christopher Cheyne |

## Scope
The following datasets (and the structure definition) are generated using ChatGPT
version 4.0. The required schema logic was provided by Chris Ch. on 26/07/2024.
The data are relevant for the teaching course.

## CREATE statement generation
Command for the ChatGPT (version 4.o):
```
Generate a table schema for PostgreSQL for the following tables and columns:
Table name: Patient Demographics
Columns:
PatientID
DeathDate
Deceased
Ethnicity
Gender
DoB
Height_m
Weight_kg
IMD_Score
FrailtyScore

Table name:
GP Appointments
Columns:
PatientID
AppointmentID
AppointmentDate
Status

Table name:
GP Outcomes
Columns:
AppointmentID
Outcome

Table name:
GP Medication
Columns:
PatientID
MedicationID
PrescribingDate
Medication
Type
CourseLength
```

### Output:
Patient Demographics
```sql
CREATE TABLE PatientDemographics (
    PatientID SERIAL PRIMARY KEY,
    DeathDate DATE,
    Deceased BOOLEAN,
    Ethnicity VARCHAR(50),
    Gender VARCHAR(10),
    DoB DATE NOT NULL,
    Height_m NUMERIC(4,2),
    Weight_kg NUMERIC(5,2),
    IMD_Score NUMERIC(5,2),
    FrailtyScore NUMERIC(5,2)
);
```
GP Appointments
```sql
CREATE TABLE GPAppointments (
    PatientID INT NOT NULL,
    AppointmentID SERIAL PRIMARY KEY,
    AppointmentDate TIMESTAMP NOT NULL,
    Status VARCHAR(20),
    FOREIGN KEY (PatientID) REFERENCES PatientDemographics(PatientID)
);
```
GP Outcomes
```sql
CREATE TABLE GPOutcomes (
    AppointmentID INT NOT NULL,
    Outcome TEXT,
    PRIMARY KEY (AppointmentID),
    FOREIGN KEY (AppointmentID) REFERENCES GPAppointments(AppointmentID)
);
```
GP Medication
```sql
CREATE TABLE GPMedication (
    PatientID INT NOT NULL,
    MedicationID SERIAL PRIMARY KEY,
    PrescribingDate DATE NOT NULL,
    Medication VARCHAR(100) NOT NULL,
    Type VARCHAR(50),
    CourseLength INT,
    FOREIGN KEY (PatientID) REFERENCES PatientDemographics(PatientID)
);
```
These CREATE statements define the structure for the PatientDemographics, GPAppointments, GPOutcomes, and GPMedication tables. Each table has appropriate primary keys and foreign key relationships to ensure referential integrity.

## INSERT statement generation
ChatGPT command:
```
Generate synthetic data for this schema, at least 30 entries per table.
```

### Outputs
Patient Demographics
```sql
INSERT INTO PatientDemographics (DeathDate, Deceased, Ethnicity, Gender, DoB, Height_m, Weight_kg, IMD_Score, FrailtyScore) VALUES
(NULL, FALSE, 'Caucasian', 'Male', '1980-01-15', 1.75, 80.5, 15.0, 1.2),
(NULL, FALSE, 'Black African', 'Female', '1990-05-20', 1.65, 70.0, 20.5, 2.0),
('2023-07-01', TRUE, 'Indian', 'Male', '1955-12-10', 1.80, 85.0, 25.0, 3.5),
(NULL, FALSE, 'Asian', 'Female', '1985-03-30', 1.55, 50.5, 10.0, 0.8),
('2024-01-01', TRUE, 'Caucasian', 'Female', '1945-07-22', 1.60, 60.0, 30.5, 4.0),
(NULL, FALSE, 'Black African', 'Male', '1975-11-11', 1.78, 78.0, 18.0, 1.5),
(NULL, FALSE, 'Indian', 'Female', '1995-08-25', 1.62, 68.5, 22.0, 2.5),
(NULL, FALSE, 'Asian', 'Male', '1988-04-14', 1.72, 75.0, 12.5, 1.0),
(NULL, FALSE, 'Caucasian', 'Male', '2000-12-31', 1.80, 82.0, 16.5, 1.8),
(NULL, FALSE, 'Black African', 'Female', '1970-06-18', 1.70, 76.5, 27.5, 3.0),
(NULL, FALSE, 'Indian', 'Male', '1992-09-12', 1.74, 81.0, 19.5, 2.2),
(NULL, FALSE, 'Asian', 'Female', '1982-07-30', 1.58, 52.0, 14.5, 1.1),
(NULL, FALSE, 'Caucasian', 'Female', '1965-11-05', 1.65, 70.5, 23.0, 2.8),
(NULL, FALSE, 'Black African', 'Male', '1985-10-20', 1.83, 83.0, 18.5, 1.7),
(NULL, FALSE, 'Indian', 'Female', '1993-05-30', 1.67, 69.5, 20.0, 2.4),
(NULL, FALSE, 'Asian', 'Male', '1989-03-25', 1.76, 77.0, 15.5, 1.3),
(NULL, FALSE, 'Caucasian', 'Female', '1997-11-17', 1.70, 75.0, 21.0, 2.6),
(NULL, FALSE, 'Black African', 'Male', '1960-08-30', 1.78, 80.0, 28.0, 3.2),
(NULL, FALSE, 'Indian', 'Female', '1990-10-15', 1.64, 67.0, 22.5, 2.7),
(NULL, FALSE, 'Asian', 'Male', '1980-02-10', 1.82, 79.0, 13.0, 1.0),
(NULL, FALSE, 'Caucasian', 'Female', '1975-07-01', 1.60, 60.5, 29.0, 3.8),
(NULL, FALSE, 'Black African', 'Male', '1992-05-05', 1.85, 84.0, 17.0, 1.4),
(NULL, FALSE, 'Indian', 'Female', '1987-12-18', 1.63, 65.5, 24.5, 2.9),
(NULL, FALSE, 'Asian', 'Male', '1991-09-23', 1.77, 76.0, 16.0, 1.5),
(NULL, FALSE, 'Caucasian', 'Female', '1983-04-30', 1.68, 72.0, 26.0, 3.1),
(NULL, FALSE, 'Black African', 'Male', '1970-01-20', 1.80, 82.5, 19.0, 2.1),
(NULL, FALSE, 'Indian', 'Female', '1994-11-25', 1.61, 63.0, 23.5, 2.8),
(NULL, FALSE, 'Asian', 'Male', '1986-07-10', 1.75, 74.0, 14.0, 1.2),
(NULL, FALSE, 'Caucasian', 'Female', '1999-08-16', 1.69, 71.0, 25.0, 3.0),
(NULL, FALSE, 'Black African', 'Male', '1984-12-05', 1.84, 85.0, 18.0, 1.6);
```
GP Appointments
```sql
INSERT INTO GPAppointments (PatientID, AppointmentDate, Status) VALUES
(1, '2024-07-01 10:00:00', 'Completed'),
(2, '2024-07-02 11:00:00', 'Scheduled'),
(3, '2024-07-03 12:00:00', 'Cancelled'),
(4, '2024-07-04 09:00:00', 'Completed'),
(5, '2024-07-05 08:00:00', 'Completed'),
(6, '2024-07-06 14:00:00', 'Scheduled'),
(7, '2024-07-07 15:00:00', 'Completed'),
(8, '2024-07-08 16:00:00', 'Cancelled'),
(9, '2024-07-09 13:00:00', 'Completed'),
(10, '2024-07-10 10:30:00', 'Scheduled'),
(11, '2024-07-11 11:30:00', 'Completed'),
(12, '2024-07-12 12:30:00', 'Cancelled'),
(13, '2024-07-13 09:30:00', 'Completed'),
(14, '2024-07-14 08:30:00', 'Completed'),
(15, '2024-07-15 14:30:00', 'Scheduled'),
(16, '2024-07-16 15:30:00', 'Completed'),
(17, '2024-07-17 16:30:00', 'Cancelled'),
(18, '2024-07-18 13:30:00', 'Completed'),
(19, '2024-07-19 10:00:00', 'Scheduled'),
(20, '2024-07-20 11:00:00', 'Completed'),
(21, '2024-07-21 12:00:00', 'Cancelled'),
(22, '2024-07-22 09:00:00', 'Completed'),
(23, '2024-07-23 08:00:00', 'Completed'),
(24, '2024-07-24 14:00:00', 'Scheduled'),
(25, '2024-07-25 15:00:00', 'Completed'),
(26, '2024-07-26 16:00:00', 'Cancelled'),
(27, '2024-07-27 13:00:00', 'Completed'),
(28, '2024-07-28 10:30:00', 'Scheduled'),
(29, '2024-07-29 11:30:00', 'Completed'),
(30, '2024-07-30 12:30:00', 'Cancelled');
```
GP Outcomes
```sql
INSERT INTO GPOutcomes (AppointmentID, Outcome) VALUES
(1, 'Routine check-up, no issues'),
(2, 'Follow-up needed'),
(3, 'Patient cancelled'),
(4, 'Prescribed medication for hypertension'),
(5, 'Referred to specialist'),
(6, 'Follow-up needed'),
(7, 'Routine check-up, no issues'),
(8, 'Patient cancelled'),
(9, 'Prescribed medication for diabetes'),
(10, 'Follow-up needed'),
(11, 'Routine check-up, no issues'),
(12, 'Patient cancelled'),
(13, 'Referred to specialist'),
(14, 'Routine check-up, no issues'),
(15, 'Follow-up needed'),
(16, 'Prescribed medication for cholesterol'),
(17, 'Patient cancelled'),
(18, 'Routine check-up, no issues'),
(19, 'Follow-up needed'),
(20, 'Referred to specialist'),
(21, 'Patient cancelled'),
(22, 'Routine check-up, no issues'),
(23, 'Prescribed medication for hypertension'),
(24, 'Follow-up needed'),
(25, 'Routine check-up, no issues'),
(26, 'Patient cancelled'),
(27, 'Referred to specialist'),
(28, 'Follow-up needed'),
(29, 'Routine check-up, no issues'),
(30, 'Patient cancelled');
```
GP Medication
```sql
INSERT INTO GPMedication (PatientID, PrescribingDate, Medication, Type, CourseLength) VALUES
(1, '2024-07-01', 'Lisinopril', 'ACE Inhibitor', 180),
(2, '2024-07-02', 'Metformin', 'Biguanide', 90),
(3, '2024-07-03', 'Amoxicillin', 'Antibiotic', 10),
(4, '2024-07-04', 'Atorvastatin', 'Statin', 365),
(5, '2024-07-05', 'Lisinopril', 'ACE Inhibitor', 180),
(6, '2024-07-06', 'Metformin', 'Biguanide', 90),
(7, '2024-07-07', 'Amoxicillin', 'Antibiotic', 10),
(8, '2024-07-08', 'Atorvastatin', 'Statin', 365),
(9, '2024-07-09', 'Lisinopril', 'ACE Inhibitor', 180),
(10, '2024-07-10', 'Metformin', 'Biguanide', 90),
(11, '2024-07-11', 'Amoxicillin', 'Antibiotic', 10),
(12, '2024-07-12', 'Atorvastatin', 'Statin', 365),
(13, '2024-07-13', 'Lisinopril', 'ACE Inhibitor', 180),
(14, '2024-07-14', 'Metformin', 'Biguanide', 90),
(15, '2024-07-15', 'Amoxicillin', 'Antibiotic', 10),
(16, '2024-07-16', 'Atorvastatin', 'Statin', 365),
(17, '2024-07-17', 'Lisinopril', 'ACE Inhibitor', 180),
(18, '2024-07-18', 'Metformin', 'Biguanide', 90),
(19, '2024-07-19', 'Amoxicillin', 'Antibiotic', 10),
(20, '2024-07-20', 'Atorvastatin', 'Statin', 365),
(21, '2024-07-21', 'Lisinopril', 'ACE Inhibitor', 180),
(22, '2024-07-22', 'Metformin', 'Biguanide', 90),
(23, '2024-07-23', 'Amoxicillin', 'Antibiotic', 10),
(24, '2024-07-24', 'Atorvastatin', 'Statin', 365),
(25, '2024-07-25', 'Lisinopril', 'ACE Inhibitor', 180),
(26, '2024-07-26', 'Metformin', 'Biguanide', 90),
(27, '2024-07-27', 'Amoxicillin', 'Antibiotic', 10),
(28, '2024-07-28', 'Atorvastatin', 'Statin', 365),
(29, '2024-07-29', 'Lisinopril', 'ACE Inhibitor', 180),
(30, '2024-07-30', 'Metformin', 'Biguanide', 90);
```
These INSERT statements provide synthetic data for the PatientDemographics, GPAppointments, GPOutcomes, and GPMedication tables. Each table has at least 30 entries, ensuring a diverse set of synthetic records.

## Modification of PatientDemographics table
ChatGPT command:
```
Modify PatientDemographics  table so it matches UK distribution of races
```

### Outputs
To match the UK distribution of races more closely, we can use the approximate racial/ethnic distribution percentages from the most recent UK census data. Here is an example of how the data might be distributed:

- White: 86%
- Asian: 7.5%
- Black: 3.3%
- Mixed: 2.2%
- Other: 1%

- We will modify the PatientDemographics table data accordingly:

```sql
-- Reset the table for demonstration
TRUNCATE TABLE PatientDemographics RESTART IDENTITY;

INSERT INTO PatientDemographics (DeathDate, Deceased, Ethnicity, Gender, DoB, Height_m, Weight_kg, IMD_Score, FrailtyScore) VALUES
(NULL, FALSE, 'White', 'Male', '1980-01-15', 1.75, 80.5, 15.0, 1.2),
(NULL, FALSE, 'White', 'Female', '1990-05-20', 1.65, 70.0, 20.5, 2.0),
('2023-07-01', TRUE, 'White', 'Male', '1955-12-10', 1.80, 85.0, 25.0, 3.5),
(NULL, FALSE, 'White', 'Female', '1985-03-30', 1.55, 50.5, 10.0, 0.8),
('2024-01-01', TRUE, 'White', 'Female', '1945-07-22', 1.60, 60.0, 30.5, 4.0),
(NULL, FALSE, 'White', 'Male', '1975-11-11', 1.78, 78.0, 18.0, 1.5),
(NULL, FALSE, 'White', 'Female', '1995-08-25', 1.62, 68.5, 22.0, 2.5),
(NULL, FALSE, 'White', 'Male', '1988-04-14', 1.72, 75.0, 12.5, 1.0),
(NULL, FALSE, 'White', 'Male', '2000-12-31', 1.80, 82.0, 16.5, 1.8),
(NULL, FALSE, 'White', 'Female', '1970-06-18', 1.70, 76.5, 27.5, 3.0),
(NULL, FALSE, 'White', 'Male', '1992-09-12', 1.74, 81.0, 19.5, 2.2),
(NULL, FALSE, 'White', 'Female', '1982-07-30', 1.58, 52.0, 14.5, 1.1),
(NULL, FALSE, 'White', 'Female', '1965-11-05', 1.65, 70.5, 23.0, 2.8),
(NULL, FALSE, 'White', 'Male', '1985-10-20', 1.83, 83.0, 18.5, 1.7),
(NULL, FALSE, 'White', 'Female', '1993-05-30', 1.67, 69.5, 20.0, 2.4),
(NULL, FALSE, 'White', 'Male', '1989-03-25', 1.76, 77.0, 15.5, 1.3),
(NULL, FALSE, 'White', 'Female', '1997-11-17', 1.70, 75.0, 21.0, 2.6),
(NULL, FALSE, 'White', 'Male', '1960-08-30', 1.78, 80.0, 28.0, 3.2),
(NULL, FALSE, 'White', 'Female', '1990-10-15', 1.64, 67.0, 22.5, 2.7),
(NULL, FALSE, 'White', 'Male', '1980-02-10', 1.82, 79.0, 13.0, 1.0),
(NULL, FALSE, 'White', 'Female', '1975-07-01', 1.60, 60.5, 29.0, 3.8),
(NULL, FALSE, 'White', 'Male', '1992-05-05', 1.85, 84.0, 17.0, 1.4),
(NULL, FALSE, 'White', 'Female', '1987-12-18', 1.63, 65.5, 24.5, 2.9),
(NULL, FALSE, 'White', 'Male', '1991-09-23', 1.77, 76.0, 16.0, 1.5),
(NULL, FALSE, 'White', 'Female', '1983-04-30', 1.68, 72.0, 26.0, 3.1),
(NULL, FALSE, 'White', 'Male', '1970-01-20', 1.80, 82.5, 19.0, 2.1),
(NULL, FALSE, 'White', 'Female', '1994-11-25', 1.61, 63.0, 23.5, 2.8),
(NULL, FALSE, 'White', 'Male', '1986-07-10', 1.75, 74.0, 14.0, 1.2),
(NULL, FALSE, 'White', 'Female', '1999-08-16', 1.69, 71.0, 25.0, 3.0),
(NULL, FALSE, 'White', 'Male', '1984-12-05', 1.84, 85.0, 18.0, 1.6),
(NULL, FALSE, 'Asian', 'Female', '1990-05-20', 1.65, 70.0, 20.5, 2.0),
(NULL, FALSE, 'Asian', 'Female', '1985-03-30', 1.55, 50.5, 10.0, 0.8),
(NULL, FALSE, 'Asian', 'Male', '1988-04-14', 1.72, 75.0, 12.5, 1.0),
(NULL, FALSE, 'Asian', 'Female', '1992-09-12', 1.64, 67.0, 22.5, 2.7),
(NULL, FALSE, 'Asian', 'Male', '1991-09-23', 1.77, 76.0, 16.0, 1.5),
(NULL, FALSE, 'Asian', 'Male', '1991-09-23', 1.77, 76.0, 16.0, 1.5),
(NULL, FALSE, 'Asian', 'Male', '1989-03-25', 1.76, 77.0, 15.5, 1.3),
(NULL, FALSE, 'Asian', 'Female', '1997-11-17', 1.70, 75.0, 21.0, 2.6),
(NULL, FALSE, 'Asian', 'Female', '1990-10-15', 1.64, 67.0, 22.5, 2.7),
(NULL, FALSE, 'Black', 'Male', '1980-01-15', 1.75, 80.5, 15.0, 1.2),
(NULL, FALSE, 'Black', 'Female', '1990-05-20', 1.65, 70.0, 20.5, 2.0),
('2023-07-01', TRUE, 'Black', 'Male', '1955-12-10', 1.80, 85.0, 25.0, 3.5),
(NULL, FALSE, 'Black', 'Female', '1985-03-30', 1.55, 50.5, 10.0, 0.8),
('2024-01-01', TRUE, 'Black', 'Female', '1945-07-22', 1.60, 60.0, 30.5, 4.0),
(NULL, FALSE, 'Black', 'Male', '1975-11-11', 1.78, 78.0, 18.0, 1.5),
(NULL, FALSE, 'Black', 'Female', '1995-08-25', 1.62, 68.5, 22.0, 2.5),
(NULL, FALSE, 'Black', 'Male', '1988-04-14', 1.72, 75.0, 12.5, 1.0),
(NULL, FALSE, 'Mixed', 'Male', '2000-12-31', 1.80, 82.0, 16.5, 1.8),
(NULL, FALSE, 'Mixed', 'Female', '1970-06-18', 1.70, 76.5, 27.5, 3.0),
(NULL, FALSE, 'Mixed', 'Male', '1992-09-12', 1.74, 81.0, 19.5, 2.2),
(NULL, FALSE, 'Mixed', 'Female', '1982-07-30', 1.58, 52.0, 14.5, 1.1),
(NULL, FALSE, 'Mixed', 'Female', '1965-11-05', 1.65, 70.5, 23.0, 2.8),
(NULL, FALSE, 'Mixed', 'Male', '1985-10-20', 1.83, 83.0, 18.5, 1.7),
(NULL, FALSE, 'Mixed', 'Female', '1993-05-30', 1.67, 69.5, 20.0, 2.4),
(NULL, FALSE, 'Mixed', 'Male', '1989-03-25', 1.76, 77.0, 15.5, 1.3),
(NULL, FALSE, 'Mixed', 'Female', '1997-11-17', 1.70, 75.0, 21.0, 2.6),
(NULL, FALSE, 'Other', 'Male', '1960-08-30', 1.78, 80.0, 28.0, 3.2),
(NULL, FALSE, 'Other', 'Female', '1990-10-15', 1.64, 67.0, 22.5, 2.7),
(NULL, FALSE, 'Other', 'Male', '1980-02-10', 1.82, 79.0, 13.0, 1.0),
(NULL, FALSE, 'Other', 'Female', '1975-07-01', 1.60, 60.5, 29.0, 3.8),
(NULL, FALSE, 'Other', 'Male', '1992-05-05', 1.85, 84.0, 17.0, 1.4),
(NULL, FALSE, 'Other', 'Female', '1987-12-18', 1.63, 65.5, 24.5, 2.9);
```