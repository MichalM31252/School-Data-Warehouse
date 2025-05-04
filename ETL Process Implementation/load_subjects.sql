USE SchoolDW;
GO

/* 1. Staging‐view z przedmiotami ze źródła */
IF OBJECT_ID('dbo.vETLSubjects','V') IS NOT NULL
    DROP VIEW dbo.vETLSubjects;
GO
CREATE VIEW dbo.vETLSubjects AS
SELECT
    SubjectID,
    -- przycinamy do 18 znaków, bo taka jest szerokość w hurtowni
    LEFT(SubjectName, 18) AS SubjectName
FROM School.dbo.Subject;
GO

/* 2. MERGE do wymiaru Subject (Type 1) */
MERGE dbo.Subject AS Target
USING dbo.vETLSubjects AS Source
    ON Target.SubjectName = Source.SubjectName

-- Jeśli istnieje wpis i nazwa się zmieniła (np. skrócona lub poprawiona) → zaktualizuj
WHEN MATCHED 
     AND Target.SubjectName <> Source.SubjectName
THEN
    UPDATE SET SubjectName = Source.SubjectName

-- Jeśli nie ma danego przedmiotu w wymiarze → wstaw nowy
WHEN NOT MATCHED BY TARGET
THEN
    INSERT (SubjectName)
    VALUES (Source.SubjectName)
;  -- średnik wymagany po MERGE
GO

/* 3. Sprzątanie staging‐view */
DROP VIEW dbo.vETLSubjects;
GO
