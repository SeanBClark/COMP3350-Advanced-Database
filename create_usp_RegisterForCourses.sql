--28/03/20
--Aaron Moss And Sean Clark COMP3350 Advanced Databases Assignment 1
-- Stored procedure for part 5 of assignment 1

--DROP PROCEDURE usp_RegisterForCourses; 

--DROP TYPE CourseOfferingList;

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
    
    -- Checks if student exists if not shows an error.
    IF (@studentNumber = NULL)

        BEGIN

            RAISERROR('No Student Number Present', 12, 1);

            ROLLBACK TRANSACTION;

        END

    ELSE

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