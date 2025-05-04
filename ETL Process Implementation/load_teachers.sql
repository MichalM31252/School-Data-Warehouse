USE SchoolDW;
GO

/* 1. Staging‐view z nauczycielami ze źródła */
IF OBJECT_ID('dbo.vETLTeachers','V') IS NOT NULL
    DROP VIEW dbo.vETLTeachers;
GO

CREATE VIEW dbo.vETLTeachers AS
SELECT
    PESEL,
    /* scalamy imię i nazwisko w jedno pole – przycinamy do 60 znaków */
    LEFT(FirstName + ' ' + LastName, 60) AS FullName
FROM School.dbo.Teacher;
GO

/* 2. MERGE do wymiaru Teacher (Type 1) */
MERGE dbo.Teacher AS Target
USING dbo.vETLTeachers AS Source
    ON Target.PESEL = Source.PESEL

-- jeśli nauczyciel istnieje, ale zmieniło się imię/nazwisko → aktualizuj
WHEN MATCHED 
     AND Target.FullName <> Source.FullName
THEN
    UPDATE SET FullName = Source.FullName

-- jeśli nauczyciel nie istnieje w wymiarze → wstaw nowy
WHEN NOT MATCHED BY TARGET
THEN
    INSERT (PESEL, FullName)
    VALUES (Source.PESEL, Source.FullName)
;  -- średnik wymagany po MERGE
GO

/* 3. Sprzątanie */
DROP VIEW dbo.vETLTeachers;
GO
