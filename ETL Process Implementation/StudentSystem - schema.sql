create database School collate Latin1_General_CI_AS;
go

USE School
GO

CREATE TABLE Subject (
	SubjectID INT PRIMARY KEY,
	SubjectName Varchar(50)
)
GO

CREATE TABLE Teacher (
	PESEL Varchar(11) PRIMARY KEY,
	FirstName Varchar(30),
	LastName Varchar(30)
)
GO

CREATE TABLE Grade (
	GradeID INT PRIMARY KEY,
	GradeValue DECIMAL(4,2),
	WeightOfGrade INT,
	GradeDate Datetime
)
GO

CREATE TABLE Class (
	ClassID Varchar(2) PRIMARY KEY,
	YearOfCreation INT
)
GO

CREATE TABLE Semester (
	SemesterID INT PRIMARY KEY,
	Name Varchar(20),
	StartDate Datetime,
	EndDate Datetime,
	Year INT
)
GO

CREATE TABLE Student (
	PESEL Varchar(11) PRIMARY KEY,
	FirstName Varchar(30),
	LastName Varchar(30),
	GuardianContact Varchar(40),
	ClassID Varchar(2) FOREIGN KEY REFERENCES Class
)
GO

CREATE TABLE TCS (
	TcsID INT PRIMARY KEY,
	TeacherID Varchar(11) FOREIGN KEY REFERENCES Teacher,
	ClassID Varchar(2) FOREIGN KEY REFERENCES Class,
	SubjectID INT FOREIGN KEY REFERENCES Subject
)
GO

CREATE TABLE ClassSemester (
	ClassID Varchar(2) FOREIGN KEY REFERENCES Class,
	SemesterID INT FOREIGN KEY REFERENCES Semester,
	PRIMARY KEY (ClassID, SemesterID)
)
GO

CREATE TABLE Assignment (
	AssignmentID INT PRIMARY KEY,
	AssignmentName Varchar(50),
	Deadline Datetime,
	TcsID INT FOREIGN KEY REFERENCES TCS,
	SemesterID INT FOREIGN KEY REFERENCES Semester
)
GO

CREATE TABLE StudentAssignment (
	StudentID Varchar(11) FOREIGN KEY REFERENCES Student,
	AssignmentID INT FOREIGN KEY REFERENCES Assignment,
	PRIMARY KEY (StudentID, AssignmentID),
	SubmissionDate Datetime,
	GradeID INT FOREIGN KEY REFERENCES Grade
)
GO