USE School;
GO

CREATE TABLE Subject (
	SubjectID INT PRIMARY KEY,
	SubjectName Varchar(50)
)

CREATE TABLE Teacher (
	PESEL Varchar(11) PRIMARY KEY,
	FirstName Varchar(30),
	LastName Varchar(30)
)

CREATE TABLE Grade (
	GradeID INT PRIMARY KEY,
	GradeValue FLOAT,
	WeightOfGrade INT,
	Date Datetime
)

CREATE TABLE Class (
	ClassID Varchar(2) PRIMARY KEY,
	YearOfCreation INT
)

CREATE TABLE Semester (
	SemesterID INT PRIMARY KEY,
	Name Varchar(20),
	StartDate Datetime,
	EndDate Datetime,
	Year INT
)

CREATE TABLE Student (
	PESEL Varchar(11) PRIMARY KEY,
	FirstName Varchar(30),
	LastName Varchar(30),
	GuardianContact Varchar(40),
	ClassID Varchar(2),
	FOREIGN KEY (ClassID) REFERENCES Class(ClassID)
		ON UPDATE CASCADE
)

CREATE TABLE TCS (
	TcsID INT PRIMARY KEY,
	TeacherID Varchar(11),
	ClassID Varchar(2),
	SubjectID INT,
	FOREIGN KEY (TeacherID) REFERENCES Teacher(PESEL)
		ON UPDATE CASCADE,
	FOREIGN KEY (ClassID) REFERENCES Class(ClassID)
		ON UPDATE CASCADE,
	FOREIGN KEY (SubjectID) REFERENCES Subject(SubjectID)
		ON UPDATE CASCADE
)

CREATE TABLE ClassSemester (
	ClassID Varchar(2),
	SemesterID INT,
	PRIMARY KEY (ClassID, SemesterID),
	FOREIGN KEY (ClassID) REFERENCES Class(ClassID)
		ON UPDATE CASCADE,
	FOREIGN KEY (SemesterID) REFERENCES Semester(SemesterID)
		ON UPDATE CASCADE
)

CREATE TABLE Assignment (
	AssignmentID INT PRIMARY KEY,
	AssignmentName Varchar(50),
	Deadline Datetime,
	TcsID INT,
	SemesterID INT,
	FOREIGN KEY (TcsID) REFERENCES TCS(TcsID)
		ON UPDATE CASCADE,
	FOREIGN KEY (SemesterID) REFERENCES Semester(SemesterID)
		ON UPDATE CASCADE
)

CREATE TABLE StudentAssignment (
	StudentID Varchar(11),
	AssignmentID INT,
	PRIMARY KEY (StudentID, AssignmentID),
	SubmissionDate Datetime,
	GradeID INT,
	FOREIGN KEY (StudentID) REFERENCES Student(PESEL)
		ON UPDATE CASCADE,
	FOREIGN KEY (AssignmentID) REFERENCES Assignment(AssignmentID),
	FOREIGN KEY (GradeID) REFERENCES Grade(GradeID)
		ON UPDATE CASCADE
)