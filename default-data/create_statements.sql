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

CREATE TABLE GPAppointments (
    PatientID INT NOT NULL,
    AppointmentID SERIAL PRIMARY KEY,
    AppointmentDate TIMESTAMP NOT NULL,
    Status VARCHAR(20),
    FOREIGN KEY (PatientID) REFERENCES PatientDemographics(PatientID)
);

CREATE TABLE GPOutcomes (
    AppointmentID INT NOT NULL,
    Outcome TEXT,
    PRIMARY KEY (AppointmentID),
    FOREIGN KEY (AppointmentID) REFERENCES GPAppointments(AppointmentID)
);

CREATE TABLE GPMedication (
    PatientID INT NOT NULL,
    MedicationID SERIAL PRIMARY KEY,
    PrescribingDate DATE NOT NULL,
    Medication VARCHAR(100) NOT NULL,
    Type VARCHAR(50),
    CourseLength INT,
    FOREIGN KEY (PatientID) REFERENCES PatientDemographics(PatientID)
);
