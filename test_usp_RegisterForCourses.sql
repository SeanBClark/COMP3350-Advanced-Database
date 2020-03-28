DECLARE @PreReq AS CourseOfferingList

INSERT INTO @PreReq (CourseOfferingIds)

    SELECT 1;

EXEC usp_RegisterForCourses @studentNumber = 1;