--28/03/20
--Aaron Moss And Sean Clark COMP3350 Advanced Databases Assignment 1
--In this file: A trigger to verify course pre reqs are met


--USE THIS STATEMENT TO CREATE USE STANDARD DB ENVIRONMENT TO RUN IF YOU WOULD LIKE

if not exists(select * from sys.databases where name = 'UniDB')
    create database UniDB
GO
USE UniDB
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
