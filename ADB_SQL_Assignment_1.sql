--if not exists(select * from sys.databases where name = 'UniDB')
--    create database UniDB
--GO
--USE UniDB
--GO
DROP TABLE Organisational_Unit_Register
DROP TABLE SubOrganisation_Unit
DROP TABLE Organisation_Unit
DROP TABLE Program_Convenor
DROP TABLE Course_Coordinator
DROP TABLE Academic_Staff
DROP TABLE Admin_Staff
DROP TABLE Staff
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
Street_No INT NOT NULL,
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
Role_Played VARCHAR(75),
FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID) ON UPDATE CASCADE ON DELETE NO ACTION,
FOREIGN KEY (Organisation_ID) REFERENCES Organisation_Unit(Organisation_ID) ON UPDATE CASCADE ON DELETE NO ACTION
)


