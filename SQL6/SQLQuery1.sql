USE SEDCHome
GO

-- Exercise 1

CREATE OR ALTER PROCEDURE dbo.CreateGrade(
@StudentID INT,
@TeacherID SMALLINT,
@CourseID SMALLINT,
@CreatedDate DATETIME,
@Grade TINYINT
)
AS
BEGIN

	INSERT INTO dbo.[Grade](StudentID, TeacherID, CourseID, CreatedDate,Grade)
	VALUES (@StudentID, @TeacherID, @CourseID, @CreatedDate, @Grade)

	SELECT g.TeacherID, g.StudentID, COUNT(g.Grade) AS TotalStudentGrades
	FROM dbo.[Grade] AS g
	WHERE StudentID = @StudentID
	GROUP BY g.TeacherID, g.StudentID

	SELECT g.TeacherID, g.StudentID, MAX(g.Grade) AS MaxStudentGrade
	FROM dbo.[Grade] AS g
	WHERE StudentID = @StudentID AND TeacherID = @TeacherID
	GROUP BY g.TeacherID, g.StudentID

END
GO

EXEC dbo.CreateGrade @StudentID = 5, @TeacherID= 7, @CourseID = 3, @CreatedDate = '1996-12-13', @Grade = 7

-- Exercise 2

USE SEDCHome
GO

CREATE OR ALTER PROCEDURE dbo.CreateGradeDetail (
	@AchievementTypeID INT,
	@Points TINYINT,
	@MaxPoints TINYINT,
	@DateForSpecificGrade DATETIME,
	@Output NVARCHAR(100)
) 
AS
BEGIN
    SELECT 
        AchievementTypeID,
		AchievementPoints,
        AchievementMaxPoints,
		AchievementDate,
		SUM(gd.AchievementPoints/gd.AchievementMaxPoints*at.ParticipationRate) AS GradePoints
    FROM
        dbo.[GradeDetails] AS gd
	INNER JOIN dbo.[AchievementType] AS at ON at.ID = gd.AchievementTypeID 
	GROUP BY gd.AchievementTypeID, gd.AchievementDate, gd.AchievementMaxPoints, gd.AchievementPoints
	SET @Output = (SELECT AchievementTypeID FROM GradeDetails)
END
GO

DECLARE @Result NVARCHAR(100);

EXEC dbo.CreateGradeDetail 5, 13, 150, '1996-12-13', @Result
SELECT @Result AS Output
GO
