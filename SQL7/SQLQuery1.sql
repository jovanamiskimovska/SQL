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
		SUM(gd.AchievementPoints/gd.AchievementMaxPoints*at.ParticipationRate) AS grpt
    FROM dbo.[GradeDetails] AS gd
	INNER JOIN dbo.[AchievementType] AS at ON at.ID = gd.AchievementTypeID 
	GROUP BY gd.AchievementTypeID, gd.AchievementDate, gd.AchievementMaxPoints, gd.AchievementPoints

	BEGIN TRY
	INSERT INTO dbo.[GradeDetails]
	   (
	    AchievementTypeID,
		AchievementPoints,
        AchievementMaxPoints,
		AchievementDate
		)
	VALUES
	(
	@AchievementTypeID,
	@Points,
	@MaxPoints,
	@DateForSpecificGrade
	)
	END TRY

	BEGIN CATCH  
	SELECT  
		ERROR_NUMBER() AS ErrorNum  
		,ERROR_SEVERITY() AS ErrorSev  
		,ERROR_STATE() AS ErrorSt  
		,ERROR_PROCEDURE() AS ErrorPr  
		,ERROR_LINE() AS ErrorLi  
		,ERROR_MESSAGE() AS ErrorMes;  
	END CATCH;  

	SET @Output = (SELECT AchievementTypeID FROM dbo.[GradeDetails])
END
GO

DECLARE @Result NVARCHAR(100);

EXEC CreateGradeDetail 13, 25, 175, '1996-12-13', @Result
SELECT @Result AS Output
GO