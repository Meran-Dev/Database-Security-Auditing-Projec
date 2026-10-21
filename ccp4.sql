use secureDatabaseManagementSystem;

CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    FullName VARCHAR(100) NOT NULL,
    SystemRole VARCHAR(20) CHECK (SystemRole IN ('Admin', 'Manager', 'Staff')),
    Salary DECIMAL(10,2) NOT NULL
);

CREATE TABLE Financial_Records (
    RecordID INT PRIMARY KEY IDENTITY(1,1),
    AccountNumber VARCHAR(20) UNIQUE NOT NULL,
    AccountBalance DECIMAL(15,2) NOT NULL
);

CREATE TABLE Audit_Log (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    ChangedBy VARCHAR(100) DEFAULT SYSTEM_USER,
    ChangeTimestamp DATETIME DEFAULT GETDATE(),
    TableName VARCHAR(50),
    ActionType VARCHAR(10), -- INSERT, UPDATE, or DELETE
    RecordKeyID INT,
    OldValue VARCHAR(MAX),
    NewValue VARCHAR(MAX)
);

CREATE TABLE Security_Alerts (
    AlertID INT PRIMARY KEY IDENTITY(1,1),
    AlertTimestamp DATETIME DEFAULT GETDATE(),
    TriggeredBy VARCHAR(100) DEFAULT SYSTEM_USER,
    AlertMessage VARCHAR(500),
    SeverityLevel VARCHAR(20) DEFAULT 'CRITICAL'
);