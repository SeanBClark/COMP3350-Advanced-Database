DROP PROCEDURE usp_RegisterForCourses; 

DROP TYPE CourseOfferingList;

CREATE  TYPE CourseOfferingList
    AS TABLE
    (

        CourseOfferingIds INT

    )
GO

CREATE PROCEDURE usp_RegisterForCourses 
    
    @studentNumber INT,
    @TVP CourseOfferingList READONLY

    AS
    SET NOCOUNT ON

        INSERT INTO Course_Enrolments
            (

                Student_ID,
                CourseOffering_ID,
                Course_Status

            )
        
        SELECT @studentNumber, 1, 0 
		FROM @TVP;

GO

select * from Course_Enrolments;