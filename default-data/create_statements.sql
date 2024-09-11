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

CREATE TABLE e3_baseline (
    PatID SERIAL PRIMARY KEY,
    Sex INT,
    DateOfSurgery DATE,
    Eligible INT,
    TumourType INT,
    TumourTypeSpecify VARCHAR(100),
    TumourSize1 INT,
    TumourSize2 INT,
    LymphNodes INT,
    LymphNodeSpecify VARCHAR(50),
    NumberPositive1 INT,
    NumberPositive2 INT,
    ResectionMargins INT,
    RStatus INT,
    TNMStagepT INT,
    TNMStagepN INT,
    TNMStageM INT,
    Stage INT,
    WHOPerfStatus INT,
    QualityLifeStudy INT,
    RandTo INT,
    Differentiation INT,
    Country INT
);

CREATE TABLE e3_fu (
    PatID INT NOT NULL,
    DateOfAssessment DATE,
    Weight NUMERIC(4,1),
    WHOPS INT,
    Diabetic INT,
    EnzymeSupp INT,
    CA199 INT,
    CA199Date DATE,
    FOREIGN KEY (PatID) REFERENCES e3_baseline(PatID)
);

CREATE TABLE e3_nod (
    PatID INT NOT NULL,
    DiedDate DATE,
    DiedTime TIMESTAMP,
    CauseOfDeath INT,
    CauseOfDeathSpecify VARCHAR(100),
    CreatedDate DATE,
    LastEditDate DATE,
    Timestamp TIMESTAMP,
    CensorField DATE,
    Patinelreason VARCHAR(50),
    FOREIGN KEY (PatID) REFERENCES e3_baseline(PatID)
);

CREATE TABLE e3_surg (
    PatID INT NOT NULL,
    Height INT,
    Weight NUMERIC(4,1),
    Smoking INT,
    ConMedCond INT,
    ReqTreatment INT,
    Diabetic INT,
    EnzymeSupp INT,
    ASAClass INT,
    PreOpCA199 INT,
    PreOpDate DATE,
    PostOpCA199 INT,
    PostOpDate DATE,
    Surgery INT,
    ExtentOfResection INT,
    PortalVeinResection INT,
    Cholecystectomy INT,
    TruncalVagotomy INT,
    LiverMetastases INT,
    Ascites INT,
    PeritonealMetastases INT,
    LocalInvasion INT,
    Diff TEXT,
    FOREIGN KEY (PatID) REFERENCES e3_baseline(PatID)
);
