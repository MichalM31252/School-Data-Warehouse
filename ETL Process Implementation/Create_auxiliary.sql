USE master;
CREATE DATABASE auxiliary;
GO

USE auxiliary;

CREATE TABLE Holidays (
    HolidayDate DATE Primary Key,
    HolidayName Varchar(50),
    FreeDay BIT
);

CREATE TABLE Vacation (
    VacationName Varchar(50),
    StartDate DATE,
    EndDate DATE,
    PRIMARY KEY(StartDate, EndDate)
);

USE master;
GO