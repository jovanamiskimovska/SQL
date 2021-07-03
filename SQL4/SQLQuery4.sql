USE SEDCHome
GO

--1.
DECLARE @FirstName NVARCHAR(50)
SET @FirstName = 'Antonio'
SELECT *
FROM [dbo].[Student]
WHERE FirstName = @FirstName

--2.
DECLARE @FemaleStudents TABLE
(
    StudentId INT NOT NULL,
	FirstName NVARCHAR(50),
	LastName NVARCHAR(50),
	DateOfBirth DATE
);
INSERT INTO @FemaleStudents
SELECT ID, FirstName, LastName, DateOfBirth
FROM [dbo].[Student]
WHERE Gender = 'F'
SELECT *
FROM @FemaleStudents
GO

--3.
CREATE TABLE #TEMPStudent
(
    LastName NVARCHAR(50),
	EnrolledDate date
);
GO
INSERT INTO #TEMPStudent
SELECT LastName, EnrolledDate
FROM [dbo].[Student]
WHERE Gender = 'M' 
AND FirstName LIKE 'A%'
SELECT *
FROM #TEMPStudent
WHERE LEN(LastName)=7
GO

--4.
SELECT *
FROM [dbo].[Teacher]
WHERE LEN(FirstName) < 5 AND LEFT(FirstName,3) = LEFT(LastName,3)
GO

--5.
CREATE FUNCTION dbo.fn_FormatStudentName(@StudentID INT)
	RETURNS NVARCHAR(700)
	AS
	BEGIN
		DECLARE @Output NVARCHAR(700)
		SELECT @Output = REPLACE(Student.StudentCardNumber, 'sc-', '')+'-'+LEFT(FirstName,1)+'.'+LastName
		FROM [dbo].[Student]
		WHERE ID = @StudentID
		RETURN @Output
	END
	GO
	SELECT * , dbo.fn_FormatStudentName(ID) AS Result
	FROM [dbo].[Student]