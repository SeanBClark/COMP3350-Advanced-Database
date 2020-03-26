---- Student
----Course Enrolment
----Course Offering
--if not exists(select * from sys.databases where name = 'TriggerTest')
--    create database TriggerTest
--GO
--USE TriggerTest
--GO

DROP TABLE Course_Enrolments
DROP TABLE Course_Offering
DROP TABLE GroupCourseAssign
DROP TABLE PreReqCourseGroup
DROP TABLE Course
DROP TABLE Student


CREATE TABLE Student (
Student_ID INT PRIMARY KEY IDENTITY(1,1),
StuName VARCHAR(20)
)

CREATE TABLE Course ( --Just holds general courses
Course_ID INT PRIMARY KEY IDENTITY(1,1),
Name VARCHAR(30) UNIQUE NOT NULL,
Credits INT NOT NULL,
Description TEXT NOT NULL
)

CREATE TABLE PreReqCourseGroup ( -- Holds a number, which will be an ID of a group that holds mutliple courses that are pre requisites for another course
Group_ID INT PRIMARY KEY IDENTITY (1,1)
)

CREATE TABLE GroupCourseAssign ( --takes a groupID and a courseID, a group has many courses a part of it, this table allows us to reference what courses a groupID Holds
--for example: Group 10 has course 1, 2, 3.... and group 11 has courses 1,3,6,7 <<< group 10 and 11 store pre requisite courses for another course
Group_ID INT,
Course_ID INT,
PRIMARY KEY(Group_ID, Course_ID),
FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (Group_ID) REFERENCES PreReqCourseGroup(Group_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Course_Offering ( --test table differs from Actual Table
CourseOffering_ID INT PRIMARY KEY IDENTITY(1,1),
Course_ID INT,
FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
)

CREATE TABLE Course_Enrolments ( --May need to fix this table but at the moment it stores what is needed
CourseEnrol_ID INT PRIMARY KEY IDENTITY(1,1),
Student_ID INT,
CourseOffering_ID INT,
Course_Status BIT DEFAULT 0,
FOREIGN KEY (CourseOffering_ID) REFERENCES Course_Offering(CourseOffering_ID) ON DELETE NO ACTION,
FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

--Insert into student
INSERT INTO Student (StuName) VALUES ('g');

--Insert into course
INSERT INTO Course(Name, Credits, Description) VALUES ('Course 1', 120, 'A course');
INSERT INTO Course(Name, Credits, Description) VALUES ('Course 2', 100, 'A course');
INSERT INTO Course(Name, Credits, Description) VALUES ('Course 3', 40, 'A course');
INSERT INTO Course(Name, Credits, Description) VALUES ('Course 4', 110, 'A course');
INSERT INTO Course(Name, Credits, Description) VALUES ('Course 5', 30, 'A course');

--Insert Into preReqGroup
INSERT INTO PreReqCourseGroup DEFAULT VALUES;

--Insert course group assign
INSERT INTO GroupCourseAssign(Group_ID, Course_ID) VALUES (1, 1);
INSERT INTO GroupCourseAssign(Group_ID, Course_ID) VALUES (1, 2);
INSERT INTO GroupCourseAssign(Group_ID, Course_ID) VALUES (1, 3);

--Insert into course offering
INSERT INTO Course_Offering(Course_ID) VALUES (1);
INSERT INTO Course_Offering(Course_ID) VALUES (2);
INSERT INTO Course_Offering(Course_ID) VALUES (3);
INSERT INTO Course_Offering(Course_ID) VALUES (4);

--Insert into course enrolments
INSERT INTO Course_Enrolments (Student_ID, CourseOffering_ID, Course_Status) VALUES (1, 1, 1);
INSERT INTO Course_Enrolments (Student_ID, CourseOffering_ID, Course_Status) VALUES (1, 2, 1);
--INSERT INTO Course_Enrolments (Student_ID, CourseOffering_ID, Course_Status) VALUES (1, 3, 1);

SELECT * FROM Course_Enrolments