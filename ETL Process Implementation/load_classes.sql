USE SchoolDW
GO

IF OBJECT_ID('dbo.vETLClasses','V') IS NOT NULL
    DROP VIEW dbo.vETLClasses;
GO
CREATE VIEW dbo.vETLClasses AS
SELECT
    ClassID AS ClassName,
    YearOfCreation
FROM School.dbo.Class;
GO

MERGE dbo.Class AS T
USING dbo.vETLClasses AS S
    ON T.ClassName = S.ClassName

WHEN MATCHED AND T.YearOfCreation <> S.YearOfCreation
THEN 
    UPDATE SET YearOfCreation = S.YearOfCreation

WHEN NOT MATCHED BY TARGET
THEN
    INSERT (ClassName, YearOfCreation)
    VALUES (S.ClassName, S.YearOfCreation)
;
GO

DROP VIEW dbo.vETLClasses;
GO