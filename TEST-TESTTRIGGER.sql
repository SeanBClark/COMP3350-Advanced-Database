CREATE TRIGGER preReqTest
ON Course_Enrolments
FOR INSERT, UPDATE
AS
BEGIN
DECLARE @CourseOfferID INT = (SELECT CourseOffering_ID FROM inserted);
DECLARE @StudentID INT = (SELECT Student_ID FROM inserted);

IF (exists(select Course.Course_ID from Course where Course.Course_ID = @CourseOfferID))

	-- select Course.Course_ID from Course where Course.Course_ID = @CourseOfferID

    select Course_Offering.Course_ID , Course.Course_ID, GroupCourseAssign.Course_ID, PreReqCourseGroup.Group_ID from Course_Offering 
    join Course_Enrolments on Course_Enrolments.CourseOffering_ID = Course_Offering.CourseOffering_ID
    join Course on Course_Offering.Course_ID = Course.Course_ID
    join GroupCourseAssign on GroupCourseAssign.Course_ID = Course.Course_ID 
    join PreReqCourseGroup on PreReqCourseGroup.Group_ID = GroupCourseAssign.Group_ID
    where GroupCourseAssign.Course_ID = Course.Course_ID and Course_Enrolments.Student_ID = @StudentID and Course_Enrolments.Course_Status = 1;

ELSE

	BEGIN
		RAISERROR('no insert', 1, 1);
		ROLLBACK TRANSACTION; 
	END

END

--DECLARE @ex INT = 1; --test purposes
----BEGIN
--IF @ex = 1
--	BEGIN
--		PRINT(@CourseOfferID);
--		PRINT(@StudentID);
--	END
--ELSE
--	BEGIN
--		RAISERROR('no insert', 1, 1);
--		ROLLBACK TRANSACTION; 
--	END
----END


--END