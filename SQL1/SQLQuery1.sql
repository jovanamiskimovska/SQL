CREATE DATABASE HOMEWORK1DB
GO
USE HOMEWORK1DB
GO


CREATE TABLE [dbo].[Student]
(
	[ID] INT IDENTITY(1,1) NOT NULL, 
	[FirstName] NVARCHAR(50) NULL,
	[LastName] NVARCHAR(50) NULL,
	[DateOfBirth] DATE NULL,
	[EnrolledDate] DATE NULL,
	[Gender] NVARCHAR(50) NULL,
	[NationalIDNumber] INT NOT NULL,
	[StudentCardNumber] INT NULL
	PRIMARY KEY(ID)
);

CREATE TABLE [dbo].[Teacher]
(
	[ID] INT IDENTITY(1,1) NOT NULL, 
	[FirstName] NVARCHAR(50) NULL,
	[LastName] NVARCHAR(50) NULL,
	[DateOfBirth] DATE NULL,
	[AcademicRank] INT NULL,
	[HireDate] DATE NULL
	PRIMARY KEY(ID)
);

CREATE TABLE [dbo].[GradeDetails]
(
	[ID] INT IDENTITY(1,1) NOT NULL, 
	[GradeID] INT NOT NULL,
	[AchievementTypeID] INT NOT NULL,
	[AchievementPoints] INT NULL,
	[AchievementMaxPoints] INT NULL,
	[AchievementDate] DATE NULL
	PRIMARY KEY(ID)
);

CREATE TABLE [dbo].[Course]
(
	[ID] INT IDENTITY(1,1) NOT NULL, 
	[Name] NVARCHAR NULL,
	[Credit] INT NULL,
	[AcademicYear] INT NULL,
	[Semestar] INT NULL,
	PRIMARY KEY(ID)
);

CREATE TABLE [dbo].[Grade]
(
	[ID] INT IDENTITY(1,1) NOT NULL, 
	[StudentID] INT NOT NULL,
	[CourseID] INT NOT NULL,
	[TeacherID] INT NOT NULL,
	[Grade] INT NULL,
	[Comment] NVARCHAR NULL,
	[CreatedDate] DATE NULL
	PRIMARY KEY(ID)
);

CREATE TABLE [dbo].[AchievementType]
(
	[ID] INT IDENTITY(1,1) NOT NULL, 
	[Name] NVARCHAR NULL,
	[Description] NVARCHAR NULL,
	[ParticipationRate] INT NULL,
	PRIMARY KEY(ID)
);