--28/03/20
--Aaron Moss And Sean Clark COMP3350 Advanced Databases Assignment 1
--  Basice test for stored procedure

-- Set ST as var
DECLARE @PreReq AS CourseOfferingList

-- Inserts student 1 into the table via the stored procedure
INSERT INTO @PreReq (CourseOfferingIds)

    SELECT 1;

EXEC usp_RegisterForCourses @studentNumber = 1;