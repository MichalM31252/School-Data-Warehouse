USE SchoolDW;
GO

IF OBJECT_ID('dbo.vETLAssignments','V') IS NOT NULL
    DROP VIEW dbo.vETLAssignments;
GO

CREATE VIEW dbo.vETLAssignments AS
SELECT
    AssignmentID,
    AssignmentName,
    CASE
        WHEN CHARINDEX('#', AssignmentName) > 0
            THEN LEFT(AssignmentName, CHARINDEX('#', AssignmentName) -1)
        ELSE NULL
    END AS AssignmentType
FROM School.dbo.Assignment;
GO

MERGE dbo.Assignment AS T
USING dbo.vETLAssignments AS S
    ON T.AssignmentName = S.AssignmentName
    AND T.AssignmentType = S.AssignmentType
WHEN NOT MATCHED BY TARGET
    THEN INSERT (AssignmentName, AssignmentType)
    VALUES (S.AssignmentName, S.AssignmentType)
;

DROP VIEW dbo.vETLAssignments;
GO