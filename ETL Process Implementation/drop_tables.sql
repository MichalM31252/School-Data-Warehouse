USE SchoolDW;
GO

-- 1. Usuń tabele faktów (zależności wymiary → fakty)
IF OBJECT_ID('dbo.StudentActivity','U') IS NOT NULL
    DROP TABLE dbo.StudentActivity;
GO

IF OBJECT_ID('dbo.StudentGrade','U') IS NOT NULL
    DROP TABLE dbo.StudentGrade;
GO

-- 2. Usuń tabele wymiarów
IF OBJECT_ID('dbo.Assignment','U') IS NOT NULL
    DROP TABLE dbo.Assignment;
GO

IF OBJECT_ID('dbo.Activity','U') IS NOT NULL
    DROP TABLE dbo.Activity;
GO

IF OBJECT_ID('dbo.Dates','U') IS NOT NULL
    DROP TABLE dbo.Dates;
GO

IF OBJECT_ID('dbo.Semester','U') IS NOT NULL
    DROP TABLE dbo.Semester;
GO

IF OBJECT_ID('dbo.Class','U') IS NOT NULL
    DROP TABLE dbo.Class;
GO

IF OBJECT_ID('dbo.Subject','U') IS NOT NULL
    DROP TABLE dbo.Subject;
GO

IF OBJECT_ID('dbo.Teacher','U') IS NOT NULL
    DROP TABLE dbo.Teacher;
GO

IF OBJECT_ID('dbo.Student','U') IS NOT NULL
    DROP TABLE dbo.Student;
GO

