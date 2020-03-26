CREATE TRIGGER preReqTest
ON Course_Enrolments
FOR INSERT, UPDATE
AS
BEGIN
DECLARE @CourseOfferID INT = (SELECT CourseOffering_ID FROM inserted);
DECLARE @StudentID INT = (SELECT Student_ID FROM inserted);
DECLARE @ex INT = 1; --test purposes
--BEGIN
IF @ex = 1
	BEGIN
		PRINT(@CourseOfferID);
		PRINT(@StudentID);
	END
ELSE
	BEGIN
		RAISERROR('no insert', 1, 1);
		ROLLBACK TRANSACTION; 
	END
--END


END