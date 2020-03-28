if not exists(select * from sys.databases where name = 'UniDB')
    create database UniDB
GO
USE UniDB
GO
 ----RUN THIS COMMAND IF YOU WANT TO CREATE A NEW DB TO WORK ON ^^^^^

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
Name_ID INT UNIQUE, --can uniquely identify each student member by name
Address_ID INT, --May live in the same house, does not have to be unique
Contact_ID INT UNIQUE, --Student must have contact number unique to them
FOREIGN KEY (Name_ID) REFERENCES Name(Name_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (Address_ID) REFERENCES Address(Address_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (Contact_ID) REFERENCES Contact_Number(Contact_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Staff (
Staff_ID INT PRIMARY KEY IDENTITY(1,1),
Name_ID INT UNIQUE, --can uniquely identify each staff member by name
Address_ID INT, --May live in the same house, does not have to be unique
Contact_ID INT UNIQUE,
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

CREATE TABLE Course_Coordinator (
Staff_ID INT PRIMARY KEY,
FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Program_Convenor (
Staff_ID INT PRIMARY KEY,
FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Organisation_Unit (
Organisation_ID INT PRIMARY KEY IDENTITY(1,1),
Organisation_Name VARCHAR(100) NOT NULL,
Org_Description TEXT,
Org_ContactNumber CHAR(10) --Each org unit has a contact number that is 10 units long
)

CREATE TABLE SubOrganisation_Unit (
SubOrganisation_ID INT PRIMARY KEY IDENTITY(1,1),
Organisation_ID INT,
SubOrg_Name VARCHAR(100) NOT NULL,
SubOrg_Description TEXT,
SubOrg_ContactNumber CHAR(10) --Each sub org unit has a contact number that is 10 units long
FOREIGN KEY (Organisation_ID) REFERENCES Organisation_Unit(Organisation_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Organisational_Unit_Register (
OrgReg_ID INT PRIMARY KEY IDENTITY(1,1),
Staff_ID INT,
Organisation_ID INT,
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
Organisation_ID INT,
Program_Code CHAR(8) NOT NULL, --Must be 8 characters long and be formed as such: ABCD1234
Prog_Name VARCHAR(80) UNIQUE NOT NULL,
Total_Credits INT NOT NULL,
Prog_Level VARCHAR(30) NOT NULL, --Contains Certificate, Bachelor, masters, phd
Cert_Achieved VARCHAR(20) NOT NULL,
FOREIGN KEY (Organisation_ID) REFERENCES Organisation_Unit(Organisation_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Program_Convenor_Assign ( --Table used for assigning a program convenor to a program, will match a convenor code, with a program code
Program_ID INT NOT NULL,
Staff_ID INT NOT NULL,
PRIMARY KEY(Program_ID, Staff_ID),
FOREIGN KEY (Program_ID) REFERENCES Program(Program_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (Staff_ID) REFERENCES Program_Convenor(Staff_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Student_Enrolments (
ProgramEnrol_ID INT PRIMARY KEY IDENTITY(1,1),
Student_ID INT,
Program_ID INT,
SemTriSem_ID INT,
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
Group_ID INT PRIMARY KEY
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
Course_ID INT,
Program_ID INT,
Group_ID INT,
StartDate DATE NOT NULL,
EndDate DATE,
Course_Type VARCHAR(30), --can be core, directed or compulsory for example
FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (Program_ID) REFERENCES Program(Program_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (Group_ID) REFERENCES PreReqCourseGroup(Group_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Major (
Major_ID INT PRIMARY KEY IDENTITY(1,1),
Course_ID INT, --what course is it a major of?
MajorName VARCHAR(80) UNIQUE NOT NULL,
Description TEXT,
Total_Credits INT NOT NULL, --total credits to complete major
Conditions VARCHAR(200) NOT NULL,
FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
)

CREATE TABLE Minor (
Minor_ID INT PRIMARY KEY IDENTITY(1,1),
Course_ID INT, --what course is it a minor of?
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
Building_Name VARCHAR(70) NOT NULL,
Location VARCHAR(50) NOT NULL, --west side, east side....
FOREIGN KEY (Campus_ID) REFERENCES Campus(Campus_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Facilities (
Facility_ID INT PRIMARY KEY IDENTITY(1,1),
Building_ID INT,
Room_No INT NOT NULL,
Capacity INT NOT NULL,
Type VARCHAR(100) NOT NULL, --Lab, Lecture hall........
FOREIGN KEY (Building_ID) REFERENCES Building(Building_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Course_Offering (
CourseOffering_ID INT PRIMARY KEY IDENTITY(1,1),
Course_ID INT,
Staff_ID INT,
SemTriSem_ID INT,
FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (Staff_ID) REFERENCES Course_Coordinator(Staff_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (SemTriSem_ID) REFERENCES Semester_Trimester(SemTriSem_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
)

CREATE TABLE Timetable_Info ( --the facilitie outlines what campus a course offering is carried out
Timetable_ID INT PRIMARY KEY IDENTITY(1,1),
CourseOffering_ID INT,
Facility_ID INT,
Start_Time TIME,
End_Time TIME,
Date DATE,
FOREIGN KEY (Facility_ID) REFERENCES Facilities(Facility_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (CourseOffering_ID) REFERENCES Course_Offering(CourseOffering_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Course_Enrolments ( --May need to fix this table but at the moment it stores what is needed
CourseEnrol_ID INT PRIMARY KEY IDENTITY(1,1),
Student_ID INT,
CourseOffering_ID INT,
Date_Registered DATE,
Final_Mark INT,
Final_Grade VARCHAR(2), --HD, D, C....
Course_Status BIT DEFAULT 0, --this will only change to a 1 if the student has successfully completed the course, 0 if student failed, dropped out....
FOREIGN KEY (CourseOffering_ID) REFERENCES Course_Offering(CourseOffering_ID) ON DELETE NO ACTION,
FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)
