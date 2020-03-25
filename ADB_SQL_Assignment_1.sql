--if not exists(select * from sys.databases where name = 'UniDB')
--    create database UniDB
--GO
--USE UniDB
--GO

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
