USE SchoolDW;
GO

IF OBJECT_ID('dbo.vETLSemesters','V') IS NOT NULL
    DROP VIEW dbo.vETLSemesters;
GO

CREATE VIEW dbo.vETLSemesters AS
SELECT SemesterID,
    CASE
        WHEN MONTH(StartDate) <= 6
            THEN 'Summer' + CAST(YEAR(StartDate) AS VARCHAR(4))
        ELSE 'Winter' + CAST(YEAR(StartDate) AS VARCHAR(4))
    END AS SemesterName
FROM School.dbo.Semester;
GO

MERGE dbo.Semester AS T
USING dbo.vETLSemesters AS S
ON T.SemesterName = S.SemesterName

WHEN NOT MATCHED BY TARGET
THEN
    INSERT (SemesterName)
    VALUES (S.SemesterName)
;
GO

DROP VIEW dbo.vETLSemesters;