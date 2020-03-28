--28/03/20
--Aaron Moss And Sean Clark COMP3350 Advanced Databases Assignment 1
--In this file: Tables to set up a testenvironment for the trigger, Inserts to test the trigger and a Trigger
--NOTE: IF YOU WOULD LIKE TO CHANGE THE OUTCOME, NAVIGATE TO:
--COURSE ENROLMENTS INSERT (LINE 106) AND CHANGE THE STATUS TO 1 TO HAVE A SUCCESSFUL OUTPUT


--USE THIS STATEMENT TO CREATE A NEW DB ENVIRONMENT TO RUN IF YOU WOULD LIKE

--if not exists(select * from sys.databases where name = 'TriggerTest')
--    create database TriggerTest
--GO
--USE TriggerTest
--GO

DROP TABLE CourseProgramAssign
DROP TABLE Course_Enrolments
DROP TABLE Course_Offering
DROP TABLE GroupCourseAssign
DROP TABLE PreReqCourseGroup
DROP TABLE Course
DROP TABLE Student

GO
--You Can toggle between on an off to view rows affected
SET NOCOUNT ON;
--SET NOCOUNT OFF;
GO


CREATE TABLE Student (
Student_ID INT PRIMARY KEY IDENTITY(1,1),
StuName VARCHAR(20)
)

CREATE TABLE Course ( --Just holds general courses
Course_ID INT PRIMARY KEY IDENTITY(1,1),
Name VARCHAR(30) UNIQUE NOT NULL,
Credits INT NOT NULL,
Description TEXT NOT NULL
)

CREATE TABLE PreReqCourseGroup ( -- Holds a number, which will be an ID of a group that holds mutliple courses that are pre requisites for another course
Group_ID INT PRIMARY KEY IDENTITY (1,1)
)

CREATE TABLE GroupCourseAssign ( --takes a groupID and a courseID, a group has many courses a part of it, this table allows us to reference what courses a groupID Holds
--for example: Group 10 has course 1, 2, 3.... and group 11 has courses 1,3,6,7 <<< group 10 and 11 store pre requisite courses for another course
Group_ID INT,
Course_ID INT,
PRIMARY KEY(Group_ID, Course_ID),
FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (Group_ID) REFERENCES PreReqCourseGroup(Group_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Course_Offering ( --test table differs from Actual Table
CourseOffering_ID INT PRIMARY KEY IDENTITY(1,1),
Course_ID INT,
FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
)

CREATE TABLE Course_Enrolments ( 
Student_ID INT,
CourseOffering_ID INT,
Course_Status BIT DEFAULT 0,
PRIMARY KEY(Student_ID, CourseOffering_ID),
FOREIGN KEY (CourseOffering_ID) REFERENCES Course_Offering(CourseOffering_ID) ON DELETE NO ACTION,
FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE CourseProgramAssign ( --this keeps track of a course assigned to a program, group PK references the pre reqs for the course
CourseProgID INT PRIMARY KEY IDENTITY(1,1),
Group_ID INT,
Course_ID INT,
FOREIGN KEY (Group_ID) REFERENCES PreReqCourseGroup(Group_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

--Insert into student
INSERT INTO Student (StuName) VALUES ('Aaron');

--Insert into course
INSERT INTO Course(Name, Credits, Description) VALUES ('Course 1', 120, 'A course');
INSERT INTO Course(Name, Credits, Description) VALUES ('Course 2', 100, 'A course');
INSERT INTO Course(Name, Credits, Description) VALUES ('Course 3', 40, 'A course');
INSERT INTO Course(Name, Credits, Description) VALUES ('Course 4', 110, 'A course');
INSERT INTO Course(Name, Credits, Description) VALUES ('Course 5', 30, 'A course');

--Insert Into preReqGroup
INSERT INTO PreReqCourseGroup DEFAULT VALUES;
INSERT INTO PreReqCourseGroup DEFAULT VALUES;

--Insert course group assign
INSERT INTO GroupCourseAssign(Group_ID, Course_ID) VALUES (1, 1);
INSERT INTO GroupCourseAssign(Group_ID, Course_ID) VALUES (1, 2);
INSERT INTO GroupCourseAssign(Group_ID, Course_ID) VALUES (2, 3);

--Insert into course offering
INSERT INTO Course_Offering(Course_ID) VALUES (1);
INSERT INTO Course_Offering(Course_ID) VALUES (2);
INSERT INTO Course_Offering(Course_ID) VALUES (3);
INSERT INTO Course_Offering(Course_ID) VALUES (4);

--Insert into course enrolments
--Change the first courses enrolment course status to 1 to return a different result from the trigger
INSERT INTO Course_Enrolments (Student_ID, CourseOffering_ID, Course_Status) VALUES (1, 1, 0); --the 0 for course status indicates that the student has no completed the course yet
INSERT INTO Course_Enrolments (Student_ID, CourseOffering_ID, Course_Status) VALUES (1, 2, 1);

--program assign
INSERT INTO CourseProgramAssign (Group_ID, Course_ID) VALUES (NULL, 1);
INSERT INTO CourseProgramAssign (Group_ID, Course_ID) VALUES (NULL, 2);
INSERT INTO CourseProgramAssign (Group_ID, Course_ID) VALUES (1, 3);


GO

--trigger to determine whether or not a student can enrol in a course based on pre requisites
CREATE TRIGGER preReqTest
ON Course_Enrolments
FOR INSERT, UPDATE
AS
BEGIN
DECLARE @Result INT = 0; --will change from 0 if requirements are not met
DECLARE @TempCourseID INT;
DECLARE @CourseOfferID INT = (SELECT CourseOffering_ID FROM inserted); --store the input course offer val
DECLARE @StudentID INT = (SELECT Student_ID FROM inserted); --store the input student ID
DECLARE @GroupID INT = (SELECT Group_ID FROM CourseProgramAssign WHERE Course_ID = @CourseOfferID); --gathers the group ID


-- creating a CURSOR to get all the course IDs of a specified pre requiste group ID
DECLARE courseCollect CURSOR
FOR 
SELECT Course_ID
FROM GroupCourseAssign
WHERE Group_ID = @GroupID
FOR READ ONLY

OPEN courseCollect

FETCH NEXT FROM courseCollect INTO @TempCourseID --stores the next courseID in the cursor inside a temp variable

WHILE @@FETCH_STATUS = 0
BEGIN
	IF NOT EXISTS (SELECT * FROM Course_Enrolments WHERE CourseOffering_ID = @TempCourseID AND Student_ID = @StudentID AND Course_Status = 1)
	BEGIN
		SET @Result = @Result + 1;
	END

	FETCH NEXT FROM  courseCollect INTO @TempCourseID
END

CLOSE courseCollect

--if the result is above 0, that means one of the requirements above were not met and the result incremented resulting in an error
IF @Result > 0
	BEGIN
		RAISERROR('Unable To Insert, Course Requirements Not Met', 1, 1);
		ROLLBACK TRANSACTION; 
	END

DEALLOCATE courseCollect

END


GO

--this student with the ID 1, would like to enrol in course 3
--Course 3 is assigned group ID 1, Group ID 1 contains Course ID 1 AND Course ID 2 in group course assign table which assigns course to a pre req group
-- student ID has enroled in courses with ID 1 and 2, BUT has not completed course 1, as its status is 0
-- the transaction should roll back and say unable to insert
INSERT INTO Course_Enrolments (Student_ID, CourseOffering_ID, Course_Status) VALUES (1, 3, 1);
