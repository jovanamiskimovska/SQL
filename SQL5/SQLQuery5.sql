USE SEDCHome;
GO

DROP FUNCTION IF EXISTS dbo.fn_StudentDetails_MultiStatement;
GO

CREATE OR ALTER FUNCTION dbo.fn_StudentDetails_MultiStatement(@TeacherId INT, @CourseId INT)
RETURNS @Result TABLE(FirstName NVARCHAR(50), LastName NVARCHAR(50), Grade INT, CreatedDate DATE)
AS
BEGIN
INSERT INTO @Result
	SELECT s.FirstName AS FirstName, s.LastName AS LastName, g.Grade AS Grade, g.CreatedDate AS CreatedDate
	FROM dbo.[Teacher] AS t
	INNER JOIN dbo.[Grade] AS g ON g.TeacherID = t.ID
	INNER JOIN dbo.[GradeDetails] AS gd ON gd.GradeID = g.ID
	INNER JOIN dbo.[Course] AS c ON c.ID = g.CourseID
	INNER JOIN dbo.[Student] AS s ON s.ID = g.StudentID
	INNER JOIN dbo.[AchievementType] AS a ON a.ID = gd.AchievementTypeID
	WHERE a.ParticipationRate < gd.AchievementPoints AND t.ID = @TeacherId AND c.ID = @CourseId
	GROUP BY s.FirstName, s.LastName, g.Grade, g.CreatedDate
RETURN
END
GO

SELECT *
FROM dbo.fn_StudentDetails_MultiStatement(2,2)
GO
