	--28/03/20
--Aaron Moss And Sean Clark COMP3350 Advanced Databases Assignment 1
--In this file: Creation of tables with not nulls, checks and defaults assigned, also some standard inserts


--USE THIS STATEMENT TO CREATE USE STANDARD DB ENVIRONMENT TO RUN IF YOU WOULD LIKE

--if not exists(select * from sys.databases where name = 'UniDB')
--    create database UniDB
--GO
--USE UniDB
--GO


--TOGGLE NO COUNT ON OR OFF
--GO
  --You Can toggle between on an off to view rows affected
  --SET NOCOUNT ON;
  --SET NOCOUNT OFF;
--GO

DROP TABLE Course_Enrolments
DROP TABLE Timetable_Info
DROP TABLE Course_Offering
DROP TABLE Facilities
DROP TABLE Building
DROP TABLE Campus
DROP TABLE Minor
DROP TABLE Major
DROP TABLE CourseProgramAssign
DROP TABLE GroupCourseAssign
DROP TABLE PreReqCourseGroup
DROP TABLE Course
DROP TABLE Student_Enrolments
DROP TABLE Program_Convenor_Assign
DROP TABLE Program
DROP TABLE Semester_Trimester
DROP TABLE Organisational_Unit_Register
DROP TABLE SubOrganisation_Unit
DROP TABLE Organisation_Unit
DROP TABLE Program_Convenor
DROP TABLE Course_Coordinator
DROP TABLE Academic_Staff
DROP TABLE Admin_Staff
DROP TABLE Staff
DROP TABLE Student
DROP TABLE Contact_Number
DROP TABLE Address
DROP TABLE Name

CREATE TABLE Name (
Name_ID INT PRIMARY KEY IDENTITY(1, 1),
First_Name VARCHAR(40) NOT NULL,
Middle_Name VARCHAR(40),
Last_Name VARCHAR(40) NOT NULL
)

CREATE TABLE Address (
Address_ID INT PRIMARY KEY IDENTITY(1,1),
Street_No VARCHAR(10) NOT NULL, --VARCHAR type as you can have 17A for example
Street VARCHAR(70) NOT NULL,
City VARCHAR(50) NOT NULL,
Post_Code VARCHAR(6) NOT NULL,
State VARCHAR(10) NOT NULL,
Country VARCHAR(50) NOT NULL
)

CREATE TABLE Contact_Number (
Contact_ID INT PRIMARY KEY IDENTITY(1,1),
Home_Number VARCHAR(30),
Work_Number VARCHAR(30),
Mobile_Number VARCHAR(20),
Additional_Number_1 VARCHAR(30),
Additional_Number_2 VARCHAR(30)
)

CREATE TABLE Student (
Student_ID INT PRIMARY KEY IDENTITY(1,1),
Name_ID INT UNIQUE NOT NULL, --can uniquely identify each student member by name
Address_ID INT NOT NULL, --May live in the same house, does not have to be unique
Contact_ID INT UNIQUE NOT NULL, --Student must have contact number unique to them
FOREIGN KEY (Name_ID) REFERENCES Name(Name_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (Address_ID) REFERENCES Address(Address_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (Contact_ID) REFERENCES Contact_Number(Contact_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Staff (
Staff_ID INT PRIMARY KEY IDENTITY(1,1),
Name_ID INT UNIQUE NOT NULL, --can uniquely identify each staff member by name
Address_ID INT NOT NULL, --May live in the same house, does not have to be unique
Contact_ID INT UNIQUE NOT NULL,
FOREIGN KEY (Name_ID) REFERENCES Name(Name_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (Address_ID) REFERENCES Address(Address_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (Contact_ID) REFERENCES Contact_Number(Contact_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Admin_Staff (
Staff_ID INT PRIMARY KEY,
FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Academic_Staff (
Staff_ID INT PRIMARY KEY,
FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Course_Coordinator ( --must reference back to Academic staff table as only academic staff can be a course coordinator
Staff_ID INT PRIMARY KEY,
FOREIGN KEY (Staff_ID) REFERENCES Academic_Staff(Staff_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Program_Convenor ( --must reference back to Academic staff table as only academic staff can be a program convenor
Staff_ID INT PRIMARY KEY,
FOREIGN KEY (Staff_ID) REFERENCES Academic_Staff(Staff_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Organisation_Unit (
Organisation_ID INT PRIMARY KEY IDENTITY(1,1),
Organisation_Name VARCHAR(100) NOT NULL,
Org_Description TEXT,
Org_ContactNumber CHAR(10) UNIQUE NOT NULL --Each org unit must have a contact number that is 10 units long
)

CREATE TABLE SubOrganisation_Unit (
SubOrganisation_ID INT PRIMARY KEY IDENTITY(1,1),
Organisation_ID INT NOT NULL,
SubOrg_Name VARCHAR(100) NOT NULL,
SubOrg_Description TEXT,
SubOrg_ContactNumber CHAR(10) --Each sub org unit has a contact number that is 10 units long
FOREIGN KEY (Organisation_ID) REFERENCES Organisation_Unit(Organisation_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Organisational_Unit_Register ( --this table allows a staff member to be associated with an organisation unit, with start and end date and role played
OrgReg_ID INT PRIMARY KEY IDENTITY(1,1),
Staff_ID INT NOT NULL,
Organisation_ID INT NOT NULL,
StartDate DATE NOT NULL,
EndDate DATE,
Role_Played VARCHAR(75) NOT NULL,
FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (Organisation_ID) REFERENCES Organisation_Unit(Organisation_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Semester_Trimester (
SemTriSem_ID INT PRIMARY KEY IDENTITY(1,1),
Name VARCHAR(30) NOT NULL,
Year INT NOT NULL
)

CREATE TABLE Program (
Program_ID INT PRIMARY KEY IDENTITY,
Organisation_ID INT NOT NULL,
Program_Code CHAR(8) NOT NULL, --Must be 8 characters long and be formed as such: ABCD1234
Prog_Name VARCHAR(80) UNIQUE NOT NULL,
Total_Credits INT NOT NULL,
Prog_Level VARCHAR(30) NOT NULL, --Contains Certificate, Bachelor, masters, phd
Cert_Achieved VARCHAR(20) NOT NULL, --Bsc, PHD, Msc
FOREIGN KEY (Organisation_ID) REFERENCES Organisation_Unit(Organisation_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
CHECK (Prog_Level IN ('Certificate', 'Bachelor', 'Masters', 'PhD')),
)

CREATE TABLE Program_Convenor_Assign ( --Table used for assigning a program convenor to a program, will match a convenor code, with a program code
Program_ID INT NOT NULL,
Staff_ID INT NOT NULL,
PRIMARY KEY(Program_ID, Staff_ID),
FOREIGN KEY (Program_ID) REFERENCES Program(Program_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (Staff_ID) REFERENCES Program_Convenor(Staff_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Student_Enrolments ( --enrolling a student to a program in a particular semester or trimester
ProgramEnrol_ID INT PRIMARY KEY IDENTITY(1,1),
Student_ID INT NOT NULL,
Program_ID INT NOT NULL,
SemTriSem_ID INT NOT NULL,
StartDate DATE NOT NULL,
EndDate DATE,
Status VARCHAR(30) NOT NULL DEFAULT 'In Progress',
FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (Program_ID) REFERENCES Program(Program_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (SemTriSem_ID) REFERENCES Semester_Trimester(SemTriSem_ID) ON UPDATE CASCADE ON DELETE NO ACTION
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
Course_ID INT,
Group_ID INT,
PRIMARY KEY(Course_ID, Group_ID),
FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (Group_ID) REFERENCES PreReqCourseGroup(Group_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE CourseProgramAssign ( --this keeps track of a course assigned to a program, group PK references the pre reqs for the course
CourseProgID INT PRIMARY KEY IDENTITY(1,1),
Group_ID INT, --can be null as a course may have 0 pre reqs
Course_ID INT NOT NULL,
Program_ID INT NOT NULL,
StartDate DATE NOT NULL,
EndDate DATE,
Course_Type VARCHAR(30) NOT NULL, --can be core, directed or compulsory for example
FOREIGN KEY (Group_ID) REFERENCES PreReqCourseGroup(Group_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (Program_ID) REFERENCES Program(Program_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
CHECK (Course_Type IN ('Core', 'Directed', 'Compulsory')),
)

CREATE TABLE Major (
Course_ID INT PRIMARY KEY, 
MajorCode INT NOT NULL,
MajorName VARCHAR(80) UNIQUE NOT NULL,
Description TEXT,
Total_Credits INT NOT NULL, --total credits to complete major
Conditions VARCHAR(200) NOT NULL,
FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
)

CREATE TABLE Minor (
Course_ID INT PRIMARY KEY,
Minor_Code INT UNIQUE NOT NULL,
MinorName VARCHAR(80) UNIQUE NOT NULL,
Description TEXT,
Total_Credits INT NOT NULL, --total credits to complete minor
Conditions VARCHAR(200) NOT NULL,
FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Campus (
Campus_ID INT PRIMARY KEY IDENTITY(1,1),
Campus_Name VARCHAR(100) NOT NULL UNIQUE, --Every campus name should be unique
City VARCHAR(70) NOT NULL,
Country VARCHAR(70) NOT NULL
)

CREATE TABLE Building (
Building_ID INT PRIMARY KEY IDENTITY(1,1),
Campus_ID INT,
Building_Name VARCHAR(70) NOT NULL UNIQUE,
Location VARCHAR(50) NOT NULL, --west side, east side....
FOREIGN KEY (Campus_ID) REFERENCES Campus(Campus_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Facilities (
Facility_ID INT PRIMARY KEY IDENTITY(1,1),
Building_ID INT NOT NULL,
Room_No INT NOT NULL,
Capacity INT NOT NULL,
Type VARCHAR(100) NOT NULL, --Lab, Lecture hall........
FOREIGN KEY (Building_ID) REFERENCES Building(Building_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Course_Offering (
CourseOffering_ID INT PRIMARY KEY IDENTITY(1,1),
Course_ID INT NOT NULL,
Staff_ID INT NOT NULL, --the coordinator
SemTriSem_ID INT NOT NULL,
FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (Staff_ID) REFERENCES Course_Coordinator(Staff_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (SemTriSem_ID) REFERENCES Semester_Trimester(SemTriSem_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
)

CREATE TABLE Timetable_Info ( --the facilities outlines what campus a course offering is carried out
Timetable_ID INT PRIMARY KEY IDENTITY(1,1),
CourseOffering_ID INT NOT NULL,
Facility_ID INT NOT NULL,
Start_Time TIME,
End_Time TIME,
Date DATE,
FOREIGN KEY (Facility_ID) REFERENCES Facilities(Facility_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (CourseOffering_ID) REFERENCES Course_Offering(CourseOffering_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Course_Enrolments ( 
CourseEnrol_ID INT PRIMARY KEY IDENTITY(1,1),
Student_ID INT NOT NULL,
CourseOffering_ID INT NOT NULL,
Date_Registered DATE DEFAULT GETDATE(),
Final_Mark INT,
Final_Grade VARCHAR(2), --HD, D, C....
Course_Status BIT DEFAULT 0, --this will only change to a 1 if the student has successfully completed the course, 0 if student failed, dropped out....
FOREIGN KEY (CourseOffering_ID) REFERENCES Course_Offering(CourseOffering_ID) ON DELETE NO ACTION,
FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

--------------------------------SAMPLE DATA INPUT--------------------------------------------------
-----------------------------------------------------------------
INSERT INTO Name (First_Name, Last_Name) VALUES ('John', 'Fake');
INSERT INTO Name (First_Name, Last_Name) VALUES ('Simon', 'Fake');
INSERT INTO Name (First_Name, Last_Name) VALUES ('Paul', 'Fake');
-----------------------------------------------------------------

INSERT INTO Address (Street_No, Street, City, Post_Code, State, Country) VALUES ('12', 'Street Lane', 'City', '2307', 'NSW', 'Australia');
INSERT INTO Address (Street_No, Street, City, Post_Code, State, Country) VALUES ('34', 'Tree Street', 'City', '2307', 'NSW', 'Australia');
INSERT INTO Address (Street_No, Street, City, Post_Code, State, Country) VALUES ('49', 'Bush Way', 'City', '2307', 'NSW', 'Australia');
-----------------------------------------------------------------

INSERT INTO Contact_Number (Home_Number, Mobile_Number) VALUES ('3456 7890', '0438 239 334');
INSERT INTO Contact_Number (Home_Number, Mobile_Number) VALUES ('2356 3948', '0458 555 883');
INSERT INTO Contact_Number (Home_Number, Mobile_Number) VALUES ('9806 4498', '0478 392 130');
-----------------------------------------------------------------

INSERT INTO Student (Name_ID, Address_ID, Contact_ID) VALUES (1, 1, 1);
-----------------------------------------------------------------

INSERT INTO Staff (Name_ID, Address_ID, Contact_ID) VALUES (2, 2, 2);
INSERT INTO Staff (Name_ID, Address_ID, Contact_ID) VALUES (3, 3, 3);
-----------------------------------------------------------------

INSERT INTO Admin_Staff (Staff_ID) VALUES (1);
-----------------------------------------------------------------

INSERT INTO Academic_Staff (Staff_ID) VALUES (2);
-----------------------------------------------------------------

INSERT INTO Course_Coordinator (Staff_ID) VALUES (2);
-----------------------------------------------------------------

INSERT INTO Program_Convenor (Staff_ID) VALUES (2);
-----------------------------------------------------------------

INSERT INTO Organisation_Unit (Organisation_Name, Org_ContactNumber) VALUES ('Faculty of Electrical Engineering', 0429334589);
-----------------------------------------------------------------

INSERT INTO SubOrganisation_Unit (Organisation_ID, SubOrg_Name) VALUES (1, 'School of Computing and IT');
-----------------------------------------------------------------

INSERT INTO Organisational_Unit_Register (Staff_ID, Organisation_ID, StartDate, Role_Played) VALUES (2, 1, '2020-09-02', 'Lecturer');
-----------------------------------------------------------------

INSERT INTO Semester_Trimester (Name, Year) VALUES ('Sem1-2020', '2020');
-----------------------------------------------------------------

INSERT INTO Program (Organisation_ID, Program_Code, Prog_Name, Total_Credits, Prog_Level, Cert_Achieved) VALUES (1, 'PROG1234', 'Program', 10, 'PHD', 'PHD');
-----------------------------------------------------------------

INSERT INTO Program_Convenor_Assign (Program_ID, Staff_ID) VALUES (1, 2);
-----------------------------------------------------------------

INSERT INTO Student_Enrolments (Student_ID, Program_ID, SemTriSem_ID, StartDate) VALUES (1, 1, 1, '2020-09-02');
-----------------------------------------------------------------


INSERT INTO Course(Name, Credits, Description) VALUES ('Course 1', 120, 'A course');
INSERT INTO Course(Name, Credits, Description) VALUES ('Course 2', 100, 'B course');
INSERT INTO Course(Name, Credits, Description) VALUES ('Course 3', 40, 'C course');
INSERT INTO Course(Name, Credits, Description) VALUES ('Course 4', 110, 'D course');
INSERT INTO Course(Name, Credits, Description) VALUES ('Course 5', 30, 'E course');
-----------------------------------------------------------------


INSERT INTO PreReqCourseGroup DEFAULT VALUES;
INSERT INTO PreReqCourseGroup DEFAULT VALUES;
-----------------------------------------------------------------


INSERT INTO GroupCourseAssign(Group_ID, Course_ID) VALUES (1, 1);
INSERT INTO GroupCourseAssign(Group_ID, Course_ID) VALUES (1, 2);
INSERT INTO GroupCourseAssign(Group_ID, Course_ID) VALUES (2, 3);
-----------------------------------------------------------------

INSERT INTO CourseProgramAssign (Group_ID, Course_ID, Program_ID, StartDate, Course_Type) VALUES (NULL, 1, 1, '2020-09-02', 'core');
INSERT INTO CourseProgramAssign (Group_ID, Course_ID, Program_ID, StartDate, Course_Type) VALUES (NULL, 2, 1, '2020-09-02', 'core');
INSERT INTO CourseProgramAssign (Group_ID, Course_ID, Program_ID, StartDate, Course_Type) VALUES (1, 3, 1, '2020-09-02', 'core');
-----------------------------------------------------------------

INSERT INTO Major (Course_ID, MajorCode, MajorName, Total_Credits, Conditions) VALUES (2, 123, 'Major course', 120, 'con');
-----------------------------------------------------------------

INSERT INTO Minor (Course_ID, Minor_Code, MinorName, Total_Credits, Conditions) VALUES(1, 1001, 'Minor', 100, 'Condition');
-----------------------------------------------------------------

INSERT INTO Campus (Campus_Name, City, Country) VALUES ('Campus', 'Cityville', 'Countryville');
-----------------------------------------------------------------

INSERT INTO Building (Campus_ID, Building_Name, Location) VALUES (1, 'Big Building', 'West side');
-----------------------------------------------------------------

INSERT INTO Facilities (Building_ID, Room_No, Capacity, Type) VALUES (1, 1, 100, 'Lab');
-----------------------------------------------------------------

INSERT INTO Course_Offering(Course_ID, Staff_ID, SemTriSem_ID) VALUES (1, 2, 1);
INSERT INTO Course_Offering(Course_ID, Staff_ID, SemTriSem_ID) VALUES (2, 2, 1);
INSERT INTO Course_Offering(Course_ID, Staff_ID, SemTriSem_ID) VALUES (3, 2, 1);
INSERT INTO Course_Offering(Course_ID, Staff_ID, SemTriSem_ID) VALUES (4, 2, 1);
-----------------------------------------------------------------

INSERT INTO Timetable_Info(CourseOffering_ID, Facility_ID) VALUES (1, 1);
-----------------------------------------------------------------

INSERT INTO Course_Enrolments (Student_ID, CourseOffering_ID, Course_Status) VALUES (1, 1, 0); 
INSERT INTO Course_Enrolments (Student_ID, CourseOffering_ID, Course_Status) VALUES (1, 2, 1);
-----------------------------------------------------------------
