CREATE TRIGGER preReqTest
ON Course_Enrolments
FOR INSERT, UPDATE
AS
BEGIN
DECLARE @CourseOfferID INT = (SELECT CourseOffering_ID FROM inserted); --store the input course offer val
DECLARE @StudentID INT = (SELECT Student_ID FROM inserted); --store the input student ID
DECLARE @ex INT = 1; --test purposes
IF @ex = 1 --this is a test to see printed values
	BEGIN --must BEGIN every if and else statement and then END it
		PRINT(@CourseOfferID);
		PRINT(@StudentID);
	END
ELSE
	BEGIN
		RAISERROR('no insert', 1, 1);
		ROLLBACK TRANSACTION; 
	END
DECLARE @GroupID INT = (SELECT Group_ID FROM CourseProgramAssign WHERE Course_ID = @CourseOfferID); --gathers the group ID
PRINT(@GroupID);
END