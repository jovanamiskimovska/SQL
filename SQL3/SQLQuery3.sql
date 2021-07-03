USE SEDCHome
GO

--1. Calculate the count of all grades in the system

SELECT COUNT(*) AS AllGrades
FROM [dbo].[Grade]
GO

--2. Calculate the count of all grades per Teacher in the system

SELECT TeacherID, COUNT(*) AS AllGrades
FROM [dbo].[Grade]
GROUP BY TeacherID
GO

--3. Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100)

SELECT TeacherID, COUNT(*) AS AllGrades
FROM [dbo].[Grade]
WHERE StudentID < 100
GROUP BY TeacherID
GO

--4. Find the Maximal Grade, and the Average Grade per Student on all grades in the system

SELECT StudentID, MAX(Grade) AS MaxGrade
FROM [dbo].[Grade]
GROUP BY StudentID
GO

SELECT StudentID, AVG(Grade) AS AvgGrade
FROM [dbo].[Grade]
GROUP BY StudentID
GO

--5. Calculate the count of all grades per Teacher in the system and filter only grade count greater then 200

SELECT TeacherID, COUNT(Grade) AS AllGrades
FROM [dbo].[Grade]
GROUP BY TeacherID
HAVING COUNT(Grade) > 200
GO

--6. Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100) and filter teachers with more than 50 Grade count

SELECT TeacherID, COUNT(Grade) AS AllGrades
FROM [dbo].[Grade]
WHERE StudentID < 100
GROUP BY TeacherID
HAVING COUNT(Grade) > 50
GO

--7. Find the Grade Count, Maximal Grade, and the Average Grade per Student on all grades in the system. Filter only records where Maximal Grade is equal to Average Grade

SELECT StudentID, COUNT(Grade) AS AllGrades, MAX(Grade) AS MaxGrade, AVG(Grade) AS AvgGrade
FROM [dbo].[Grade]
GROUP BY StudentID
HAVING MAX(Grade) = AVG(Grade)
GO

--8. List Student First Name and Last Name next to the other details from previous query

SELECT g.StudentID, s.FirstName, s.LastName, COUNT(Grade) AS AllGrades, MAX(Grade) AS MaxGrade, AVG(Grade) AS AvgGrade
FROM [dbo].[Grade] AS g
JOIN [dbo].[Student] AS s ON g.StudentID = s.ID
GROUP BY g.StudentID, s.FirstName, s.LastName
HAVING MAX(Grade) = AVG(Grade)
GO

--9. Create new view (vv_StudentGrades) that will List all StudentIdsand count of Grades per student

CREATE VIEW vv_StudentGrades
AS 
SELECT StudentID, COUNT(Grade) AS AllGrades
FROM [dbo].[Grade]
GROUP BY StudentID
GO

--10. Change the view to show Student First and Last Names instead of StudentID

CREATE OR ALTER VIEW vv_StudentGrades
AS 
SELECT s.FirstName, s.LastName, COUNT(Grade) AS AllGrades
FROM [dbo].[Grade] AS g
JOIN [dbo].[Student] AS s ON g.StudentID = s.ID
GROUP BY s.FirstName, s.LastName
GO

--11. List all rows from view ordered by biggest Grade Count

SELECT *
FROM vv_StudentGrades
ORDER BY AllGrades DESC
GO

--12. Create new view (vv_StudentGradeDetails) that will List all Students (FirstName and LastName) and Count the courses he passed through the exam(Ispit)

CREATE VIEW vv_StudentGradeDetails
AS
SELECT s.FirstName, s.LastName, COUNT(g.Grade) AS AllCoursesPassed, a.Name
FROM [dbo].[Grade] AS g
INNER JOIN [dbo].[Student] AS s ON s.ID = g.StudentID
INNER JOIN [dbo].[GradeDetails] AS gd ON gd.GradeID = g.ID
INNER JOIN [dbo].[AchievementType] AS a ON a.ID = gd.AchievementTypeID
WHERE a.ParticipationRate < gd.AchievementPoints
AND a.Name = 'Ispit'
GROUP BY s.FirstName, s.LastName, a.Name
GO

SELECT *
FROM vv_StudentGradeDetails
ORDER BY AllCoursesPassed DESC
GO