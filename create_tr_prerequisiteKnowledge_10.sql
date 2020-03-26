CREATE TRIGGER preReqTest
ON Course_Enrolments
FOR INSERT, UPDATE
AS
BEGIN

	-- FOR select all from courseAssign group (Not sure which one) where prereqgroup = something
	-- if course enrol id = prerequ id 
	-- if result correct procide
	-- else don't

END
GO