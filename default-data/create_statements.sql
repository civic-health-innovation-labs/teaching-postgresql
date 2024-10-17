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
    PatientID INT,
    AppointmentID SERIAL PRIMARY KEY,
    AppointmentDate TIMESTAMP NOT NULL,
    Status VARCHAR(20),
    FOREIGN KEY (PatientID) REFERENCES PatientDemographics(PatientID) ON DELETE SET NULL
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
    DiedTime TIME,
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


-- CPRD Synthetic Records
CREATE TABLE cprdsyn_region (
    regionid SERIAL PRIMARY KEY,
    description VARCHAR(25)
);

CREATE TABLE cprdsyn_practice (
    pracid SERIAL PRIMARY KEY,
    region INT,
    FOREIGN KEY (region) REFERENCES cprdsyn_region(regionid)
);

CREATE TABLE cprdsyn_gender (
    genderid SERIAL PRIMARY KEY,
    description VARCHAR(15)
);

CREATE TABLE cprdsyn_patienttype (
    patienttypeid SERIAL PRIMARY KEY,
    description VARCHAR(30)
);

CREATE TABLE cprdsyn_patient (
    patsid BIGSERIAL PRIMARY KEY,
    pracid INT,
    gender INT,
    emis_ddate DATE,
    patienttypeid INT,
    acceptable INT,
    regstartdate DATE,
    dob DATE,
    ageatreg INT,
    FOREIGN KEY (pracid) REFERENCES cprdsyn_practice(pracid),
    FOREIGN KEY (gender) REFERENCES cprdsyn_gender(genderid),
    FOREIGN KEY (patienttypeid) REFERENCES cprdsyn_patienttype(patienttypeid)
);

CREATE TABLE cprdsyn_md (
    medcodeid BIGSERIAL PRIMARY KEY,
    term VARCHAR(70),
    originalreadcode VARCHAR(10),
    cleansedreadcode VARCHAR(10),
    snomedctconceptid BIGINT,
    snomedctdescriptionid BIGINT
);

CREATE TABLE cprdsyn_observation (
    patsid BIGINT NOT NULL,
    obsid BIGINT,
    obsdate DATE,
    enterdate DATE,
    medcodeid BIGINT NOT NULL,
    FOREIGN KEY (patsid) REFERENCES cprdsyn_patient(patsid),
    FOREIGN KEY (medcodeid) REFERENCES cprdsyn_md(medcodeid)
);

CREATE TABLE cprdsyn_pd (
    prodcodeid BIGSERIAL PRIMARY KEY,
    termfromemis VARCHAR(100),
    productname VARCHAR(100),
    formulation VARCHAR(30),
    routeofadministration VARCHAR(30),
    drugsubstancename VARCHAR(150),
    substancestrength VARCHAR(130)
);

CREATE TABLE cprdsyn_medication (
    patsid BIGINT NOT NULL,
    issuedate DATE,
    enterdate DATE,
    prodcodeid BIGINT,
    quantity INT,
    duration INT,
    FOREIGN KEY (patsid) REFERENCES cprdsyn_patient(patsid),
    FOREIGN KEY (prodcodeid) REFERENCES cprdsyn_pd(prodcodeid)
);
