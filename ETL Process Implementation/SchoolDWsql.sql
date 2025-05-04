create database SchoolDW collate Latin1_General_CI_AS;
go

use SchoolDW
go

-- Dimension Tables

CREATE TABLE Student (
    ID_Student INT IDENTITY(1,1) PRIMARY KEY,
    PESEL CHAR(11) NOT NULL,
    FullName VARCHAR(60),
    isCurrent BIT,
    ParticipatesInExtraActivity VARCHAR(20)
)
GO

CREATE TABLE Teacher (
    ID_Teacher INT IDENTITY(1,1) PRIMARY KEY,
    PESEL CHAR(11) NOT NULL,
    FullName VARCHAR(60)
)
GO

CREATE TABLE Subject (
    ID_Subject INT IDENTITY(1,1) PRIMARY KEY,
    SubjectName VARCHAR(18)
)
GO

CREATE TABLE Class (
    ID_Class INT IDENTITY(1,1) PRIMARY KEY,
    ClassName VARCHAR(2),
    YearOfCreation INT
)
GO

CREATE TABLE Semester (
    ID_Semester INT IDENTITY(1,1) PRIMARY KEY,
    SemesterName VARCHAR(10)
)
GO

CREATE TABLE Dates (
    ID_Date INT IDENTITY(1,1) PRIMARY KEY,
    Year INT,
    Month VARCHAR(10),
    MonthNo INT,
    Day INT,
    DayOfWeek VARCHAR(10),
    DayOfWeekNo INT,
    WorkingDay VARCHAR(15),
    Vacation VARCHAR(20),
    Holiday VARCHAR(50)
)
GO

CREATE TABLE Activity (
    ID_Activity INT IDENTITY(1,1) PRIMARY KEY,
    ActivityType VARCHAR(12),
    ActivityName VARCHAR(18),
    Frequency VARCHAR(20),
    Location VARCHAR(20)
)
GO

CREATE TABLE Assignment (
    ID_Assignment INT IDENTITY(1,1) PRIMARY KEY,
    AssignmentName VARCHAR(12),
    AssignmentType VARCHAR(8)
)
GO

-- Fact Tables

CREATE TABLE StudentGrade (
    ID_Student INT,
    ID_Teacher INT,
    ID_Subject INT,
    ID_Date INT,
    ID_Semester INT,
    ID_Class INT,
    ID_Assignment INT,
    GradeValue DECIMAL(3,2),
    WeightOfGrade INT,
    WeightedGrade AS (GradeValue * WeightOfGrade) PERSISTED,
    FOREIGN KEY (ID_Student) REFERENCES Student(ID_Student),
    FOREIGN KEY (ID_Teacher) REFERENCES Teacher(ID_Teacher),
    FOREIGN KEY (ID_Subject) REFERENCES Subject(ID_Subject),
    FOREIGN KEY (ID_Date) REFERENCES Dates(ID_Date),
    FOREIGN KEY (ID_Semester) REFERENCES Semester(ID_Semester),
    FOREIGN KEY (ID_Class) REFERENCES Class(ID_Class),
    FOREIGN KEY (ID_Assignment) REFERENCES Assignment(ID_Assignment)
)
GO

CREATE TABLE StudentActivity (
    ID_Student INT,
    ID_Activity INT,
    ID_StartDate INT,
    ID_EndDate INT,
    FOREIGN KEY (ID_Student) REFERENCES Student(ID_Student),
    FOREIGN KEY (ID_Activity) REFERENCES Activity(ID_Activity),
    FOREIGN KEY (ID_StartDate) REFERENCES Dates(ID_Date),
    FOREIGN KEY (ID_EndDate) REFERENCES Dates(ID_Date)
)
GO