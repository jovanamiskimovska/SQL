--1.All students with FirstName = Antonio
SELECT * 
FROM [dbo].[Student]
WHERE FirstName = 'Antonio'
GO

--2.All students with DateOfBirthgreater than ‘01.01.1999’
SELECT * 
FROM [dbo].[Student]
WHERE DateOfBirth > '1999-01-01'
GO

--3.All Male Students
SELECT * 
FROM [dbo].[Student]
WHERE Gender = 'M'
GO

--4.All Students with LastNamestarting With ‘T’
SELECT * 
FROM [dbo].[Student]
WHERE LastName LIKE 'T%'
GO

--5.All Students Enrolled in January/1998
SELECT * 
FROM [dbo].[Student]
WHERE EnrolledDate BETWEEN '1998-01-01' AND '1998-01-31'
GO

--6.All Students with LastNamestarting With ‘J’ enrolled in January/1998
SELECT * 
FROM [dbo].[Student]
WHERE EnrolledDate BETWEEN '1998-01-01' AND '1998-01-31'
AND LastName LIKE 'J%'
GO

--7.All  Students with FirstName= Antonio ordered by Last Name
SELECT * 
FROM [dbo].[Student]
WHERE FirstName = 'Antonio'
ORDER BY LastName ASC
GO

--8.All Students ordered by FirstName
SELECT * 
FROM [dbo].[Student]
ORDER BY FirstName ASC
GO

--9.List all Teacher First Names and Student First Names in single result set with duplicates
SELECT FirstName
FROM [dbo].[Teacher]
UNION ALL 
SELECT FirstName
FROM [dbo].[Student]
GO

--10.List all Teacher First Names and Student First Names in single result set without duplicates
SELECT FirstName
FROM [dbo].[Teacher]
UNION 
SELECT FirstName
FROM [dbo].[Student]
GO

--11.List all common First Names for Teachers and Students
SELECT FirstName
FROM [dbo].[Teacher]
INTERSECT 
SELECT FirstName
FROM [dbo].[Student]
GO

--12.Change GradeDetailstable always to insert value 100 in AchievementMaxPointscolumn if no value is provided on insert
ALTER TABLE [dbo].[GradeDetails] 
ADD CONSTRAINT DF_Achievement_Max_Points 
DEFAULT 100 FOR [AchievementMaxPoints]
GO

--13.Change GradeDetailstable to prevent inserting AchievementPointsthat will more than AchievementMaxPoints
ALTER TABLE [dbo].[GradeDetails] 
WITH CHECK 
ADD CONSTRAINT CHK_Achievement_Points
CHECK (AchievementMaxPoints >= AchievementPoints)
GO

--14.Change AchievementTypetable to guarantee unique names across the Achievement types
ALTER TABLE [dbo].[AchievementType] 
WITH CHECK 
ADD CONSTRAINT UC_Achievement_Type UNIQUE (Name)
GO

--15.Create Foreign key constraints from diagram or with script
ALTER TABLE [dbo].[Grade]
ADD FOREIGN KEY (StudentID) 
REFERENCES Student(ID)

ALTER TABLE [dbo].[Grade]
ADD FOREIGN KEY (CourseID)
REFERENCES Course(ID)
GO

ALTER TABLE [dbo].[Grade]
ADD FOREIGN KEY (TeacherID)
REFERENCES Teacher(ID)
GO

ALTER TABLE [dbo].[GradeDetails]
ADD FOREIGN KEY (GradeID)
REFERENCES Grade(ID)
GO

ALTER TABLE [dbo].[GradeDetails]
ADD FOREIGN KEY (AchievementTypeID)
REFERENCES AchievementType(ID)
GO

--16.List all possible combinations of Courses names and AchievementTypenames that can be passed by student
SELECT DISTINCT Name FROM Course
GO

SELECT DISTINCT Name FROM AchievementType
GO

--17.List all Teachers that has any exam Grade
SELECT *
FROM [dbo].[Grade]
WHERE TeacherID <> 0
GO

--18.List all Teachers without exam Grade
SELECT *
FROM [dbo].[Grade]
WHERE TeacherID = 0
GO

--19.List all Students without exam Grade (using Right Join)
SELECT Student.FirstName, Student.LastName, Grade.Grade
FROM [dbo].[Grade] 
RIGHT JOIN [dbo].[Student] ON Student.ID = Grade.StudentID
WHERE Grade.StudentID IS NULL
GO

