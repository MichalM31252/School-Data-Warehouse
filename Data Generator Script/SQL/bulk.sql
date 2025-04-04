USE School;
GO

:setvar DataFolder "C:\Users\malag\OneDrive\Pulpit\warehouses" ----- TU TRZEBA PODAÆ ŒCIE¯KÊ DO FOLDERU
GO

-- Subject
BULK INSERT Subject
FROM '$(DataFolder)\Subject_1.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
GO

-- Teacher
BULK INSERT Teacher
FROM '$(DataFolder)\Teacher_1.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
GO

-- Grade
BULK INSERT Grade
FROM '$(DataFolder)\Grade_1.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
GO

-- Class
BULK INSERT Class
FROM '$(DataFolder)\Class_1.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
GO

-- Semester
BULK INSERT Semester
FROM '$(DataFolder)\Semester_1.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
GO

-- Student
BULK INSERT Student
FROM '$(DataFolder)\Student_1.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
GO

-- TCS
BULK INSERT TCS
FROM '$(DataFolder)\TCS_1.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
GO

-- ClassSemester
BULK INSERT ClassSemester
FROM '$(DataFolder)\ClassSemester_1.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
GO

-- Assignment
BULK INSERT Assignment
FROM '$(DataFolder)\Assignment_1.csv' 
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
GO

-- StudentAssignment
BULK INSERT StudentAssignment
FROM '$(DataFolder)\StudentAssignment_1.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
GO
