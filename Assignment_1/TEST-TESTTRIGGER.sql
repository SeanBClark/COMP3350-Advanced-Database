CREATE TRIGGER preReqTest
ON Course_Enrolments
FOR INSERT, UPDATE
AS
BEGIN
DECLARE @Result INT = 0;
DECLARE @TempCourseID INT;
DECLARE @CourseOfferID INT = (SELECT CourseOffering_ID FROM inserted); --store the input course offer val
DECLARE @StudentID INT = (SELECT Student_ID FROM inserted); --store the input student ID
DECLARE @GroupID INT = (SELECT Group_ID FROM CourseProgramAssign WHERE Course_ID = @CourseOfferID); --gathers the group ID

DECLARE courseCollect CURSOR
FOR 
SELECT Course_ID
FROM GroupCourseAssign
WHERE Group_ID = @GroupID
FOR READ ONLY

OPEN courseCollect

FETCH NEXT FROM courseCollect INTO @TempCourseID

WHILE @@FETCH_STATUS = 0
BEGIN
	IF NOT EXISTS (SELECT * FROM Course_Enrolments WHERE CourseOffering_ID = @TempCourseID AND Student_ID = @StudentID AND Course_Status = 1)
	BEGIN
		SET @Result = @Result + 1;
	END

	FETCH NEXT FROM  courseCollect INTO @TempCourseID
END

CLOSE courseCollect

IF @Result > 0
	BEGIN
		RAISERROR('Unable To Insert, Course Requirements Not Met', 1, 1);
		ROLLBACK TRANSACTION; 
	END

DEALLOCATE courseCollect

END