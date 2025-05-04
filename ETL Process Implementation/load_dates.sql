USE SchoolDW;
-- (nie ma GO, cały skrypt to jedna partia)

/* 1) Wypełnienie tabeli Dates */
DECLARE 
    @StartDate DATE,
    @EndDate   DATE,
    @CurrDate  DATE;

SET @StartDate = '1990-01-01';
SET @EndDate   = '2025-12-31';
SET @CurrDate  = @StartDate;

WHILE @CurrDate <= @EndDate
BEGIN
    INSERT INTO dbo.Dates
        (Year, Month, MonthNo, Day, DayOfWeek, DayOfWeekNo, WorkingDay, Vacation, Holiday)
    VALUES
        (
         YEAR(@CurrDate),
         DATENAME(month,   @CurrDate),
         MONTH(@CurrDate),
         DAY(@CurrDate),
         DATENAME(weekday,@CurrDate),
         DATEPART(weekday,@CurrDate),
         CASE WHEN DATEPART(weekday,@CurrDate)=1 
              THEN 'day off' 
              ELSE 'working day' END,
         'non-vacation',
         'non-holiday'
        );

    SET @CurrDate = DATEADD(day,1,@CurrDate);
END

/* 2) Widok stagingowy */
IF OBJECT_ID('dbo.vETLDatesData','V') IS NOT NULL
    DROP VIEW dbo.vETLDatesData;

GO
CREATE VIEW dbo.vETLDatesData
AS
SELECT
    d.ID_Date,
    CASE
        WHEN h.FreeDay       = 1 THEN 'day off'
        WHEN d.DayOfWeekNo   = 1 THEN 'day off'
        ELSE 'working day'
    END                    AS WorkingDay,
    ISNULL(v.VacationName, 'non-vacation') AS Vacation,
    ISNULL(h.HolidayName , 'non-holiday')  AS Holiday
FROM dbo.Dates d
LEFT JOIN auxiliary.dbo.Holidays h
    ON h.HolidayDate = DATEFROMPARTS(d.Year, d.MonthNo, d.Day)
LEFT JOIN auxiliary.dbo.Vacation v
    ON DATEFROMPARTS(d.Year, d.MonthNo, d.Day)
       BETWEEN v.StartDate AND v.EndDate
;  -- konieczny średnik po definicji CREATE VIEW
GO
/* 3) Aktualizacja tabeli Dates */
MERGE dbo.Dates AS T
USING dbo.vETLDatesData AS S
    ON T.ID_Date = S.ID_Date
WHEN MATCHED THEN
    UPDATE 
       SET T.WorkingDay = S.WorkingDay,
           T.Vacation   = S.Vacation,
           T.Holiday    = S.Holiday
;  -- średnik konieczny po MERGE

/* 4) Sprzątanie */
DROP VIEW dbo.vETLDatesData;
