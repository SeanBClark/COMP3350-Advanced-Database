--Run Table
DROP TABLE FactSale
DROP TABLE DimCustomer
DROP TABLE DimStaff
DROP TABLE DimHistoricalItemPrice
DROP TABLE DimItem
DROP TABLE DimReciept

CREATE TABLE DimCustomer (
	CustomerKey int Primary Key identity not null,
	CustomerID VARCHAR(3) not null,
	CustomerFirstName VARCHAR(30) NULL,
	CustomerSurname VARCHAR(30) NULL,
)

CREATE TABLE DimStaff (
	StaffKey int Primary Key identity not null,
	StaffID VARCHAR(3) not null,
	StaffFirstName VARCHAR(30) NULL,
	StaffSurname VARCHAR(30) NULL,
	StaffOffice int NULL,
	OfficeLocation VARCHAR(30) NULL,
)

CREATE TABLE DimHistoricalItemPrice (
	HistoricalPriceKey int Primary Key identity not null,
	ItemName VARCHAR(50),
	ItemPrice float,
	DateFrom DATETIME NULL,
	DateTo DATETIME NULL,
)

CREATE TABLE DimItem (

	ItemKey int Primary Key identity not null,
	ItemId int not null,
	ItemDescription varchar(100) NULL,
	ItemPrice float NULL,

)

CREATE TABLE DimReciept (
	RecieptKey int Primary Key identity not null,
	RecieptId int NOT NULL,
	SaleDate datetime NOT NULL,
	RecieptTransRowId float NOT NULL,
	ItemQuanity float NOT NULL,
	RowTotal float NOT NULL,

)

CREATE TABLE FactSale (
	SaleKey int Primary Key identity not null,
	RecieptKey int not null,
	ItemKey int not null,
	StaffKey int not null,
	CustomerKey int not null,
	TotalItemsSold float null,
	FOREIGN KEY (RecieptKey) REFERENCES DimReciept (RecieptKey),
	FOREIGN KEY (ItemKey) REFERENCES DImItem (ItemKey),
	FOREIGN KEY (StaffKey)  REFERENCES DimStaff (StaffKey),
	FOREIGN KEY (CustomerKey) REFERENCES DimCustomer (CustomerKey),
)

Insert into DimCustomer (CustomerID, CustomerFirstName, CustomerSurname)
SELECT distinct StageData.[CustomerID], StageData.[CustomerFirstName], StageData.[CustomerSurname] From StageData
WHERE CustomerID IS NOT NULL AND CustomerID <> '';

Insert into DimStaff (StaffID, StaffFirstName, StaffSurname, StaffOffice, OfficeLocation)
SELECT distinct  StageData.[StaffId], StageData.[StaffFirstName], StageData.[StaffSurname], StageData.[StaffOffice], StageData.[OfficeLocation] FROM StageData
WHERE StaffID <> '' AND StaffID IS NOT NULL;

Insert into DimHistoricalItemPrice (ItemName, ItemPrice)
SELECT distinct StageData.[ItemDescription], StageData.[ItemPrice]  FROM StageData;

--Removing NULL entities and empty fields
Insert into DimItem(ItemID, ItemDescription, itemPrice)
SELECT distinct StageData.[ItemID] ,StageData.[ItemDescription], StageData.[ItemPrice]  FROM StageData
WHERE ItemDescription <> '' AND ItemID IS NOT NULL AND ItemPrice IS NOT NULL;

Insert into DimReciept(RecieptId, SaleDate, RecieptTransRowId, ItemQuanity, RowTotal)
SELECT DISTINCT StageData.[RecieptID], StageData.[SaleDate], StageData.[RecieptTransactionRowID], StageData.[ItemQuantity], StageData.[RowTotal]
FROM StageData
WHERE RecieptID <> '' AND RecieptID IS NOT NULL AND RowTotal <> 0;

Insert into FactSale(StaffKey, RecieptKey, CustomerKey, ItemKey) 
SELECT Distinct s.StaffKey, r.RecieptKey, c.CustomerKey, i.ItemKey
FROM StageData sd
	left join DimReciept r on r.RecieptId = sd.[RecieptID]
	left join DimStaff s on s.StaffID = sd.[StaffID]
	left join DimCustomer c on c.CustomerID = sd.[CustomerID]
	left join DimItem i on i.ItemID = sd.[ItemID];


DECLARE @Staff1 int;
SET @Staff1 = (SELECT COUNT(StaffKey) FROM FactSale WHERE StaffKey = 1);
UPDATE FactSale SET TotalItemsSold = @Staff1 WHERE StaffKey = 1;

DECLARE @Staff2 int;
SET @Staff2 = (SELECT COUNT(StaffKey) FROM FactSale WHERE StaffKey = 2);
UPDATE FactSale SET TotalItemsSold = @Staff2 WHERE StaffKey = 2;

DECLARE @Staff3 int;
SET @Staff3 = (SELECT COUNT(StaffKey) FROM FactSale WHERE StaffKey = 3);
UPDATE FactSale SET TotalItemsSold = @Staff3 WHERE StaffKey = 3;

DECLARE @Staff4 int;
SET @Staff4 = (SELECT COUNT(StaffKey) FROM FactSale WHERE StaffKey = 4);
UPDATE FactSale SET TotalItemsSold = @Staff4 WHERE StaffKey = 4;

DECLARE @Staff5 int;
SET @Staff5 = (SELECT COUNT(StaffKey) FROM FactSale WHERE StaffKey = 5);
UPDATE FactSale SET TotalItemsSold = @Staff5 WHERE StaffKey = 5;

DECLARE @Staff6 int;
SET @Staff6 = (SELECT COUNT(StaffKey) FROM FactSale WHERE StaffKey = 6);
UPDATE FactSale SET TotalItemsSold = @Staff6 WHERE StaffKey = 6;

DECLARE @Staff7 int;
SET @Staff7 = (SELECT COUNT(StaffKey) FROM FactSale WHERE StaffKey = 7);
UPDATE FactSale SET TotalItemsSold = @Staff7 WHERE StaffKey = 7;

DECLARE @Staff8 int;
SET @Staff8 = (SELECT COUNT(StaffKey) FROM FactSale WHERE StaffKey = 8);
UPDATE FactSale SET TotalItemsSold = @Staff8 WHERE StaffKey = 8;

DECLARE @Staff9 int;
SET @Staff9 = (SELECT COUNT(StaffKey) FROM FactSale WHERE StaffKey = 9);
UPDATE FactSale SET TotalItemsSold = @Staff9 WHERE StaffKey = 9;

DECLARE @Staff10 int;
SET @Staff10 = (SELECT COUNT(StaffKey) FROM FactSale WHERE StaffKey = 10);
UPDATE FactSale SET TotalItemsSold = @Staff10 WHERE StaffKey = 10;

DECLARE @Staff11 int;
SET @Staff11 = (SELECT COUNT(StaffKey) FROM FactSale WHERE StaffKey = 11);
UPDATE FactSale SET TotalItemsSold = @Staff11 WHERE StaffKey = 11;

DECLARE @Staff12 int;
SET @Staff12 = (SELECT COUNT(StaffKey) FROM FactSale WHERE StaffKey = 12);
UPDATE FactSale SET TotalItemsSold = @Staff12 WHERE StaffKey = 12;

DECLARE @Staff13 int;
SET @Staff13 = (SELECT COUNT(StaffKey) FROM FactSale WHERE StaffKey = 13);
UPDATE FactSale SET TotalItemsSold = @Staff13 WHERE StaffKey = 13;

DECLARE @Staff14 int;
SET @Staff14 = (SELECT COUNT(StaffKey) FROM FactSale WHERE StaffKey = 14);
UPDATE FactSale SET TotalItemsSold = @Staff14 WHERE StaffKey = 14;

DECLARE @Staff15 int;
SET @Staff15 = (SELECT COUNT(StaffKey) FROM FactSale WHERE StaffKey = 15);
UPDATE FactSale SET TotalItemsSold = @Staff15 WHERE StaffKey = 15;

DECLARE @Staff16 int;
SET @Staff16 = (SELECT COUNT(StaffKey) FROM FactSale WHERE StaffKey = 16);
UPDATE FactSale SET TotalItemsSold = @Staff16 WHERE StaffKey = 16;

DECLARE @Staff17 int;
SET @Staff17 = (SELECT COUNT(StaffKey) FROM FactSale WHERE StaffKey = 17);
UPDATE FactSale SET TotalItemsSold = @Staff17 WHERE StaffKey = 17;

DECLARE @Staff18 int;
SET @Staff18 = (SELECT COUNT(StaffKey) FROM FactSale WHERE StaffKey = 18);
UPDATE FactSale SET TotalItemsSold = @Staff18 WHERE StaffKey = 18;

DECLARE @Staff19 int;
SET @Staff19 = (SELECT COUNT(StaffKey) FROM FactSale WHERE StaffKey = 19);
UPDATE FactSale SET TotalItemsSold = @Staff19 WHERE StaffKey = 19;

DECLARE @Staff20 int;
SET @Staff20 = (SELECT COUNT(StaffKey) FROM FactSale WHERE StaffKey = 20);
UPDATE FactSale SET TotalItemsSold = @Staff20 WHERE StaffKey = 20;

SELECT TOP 1 fs.StaffKey, s.StaffID, s.StaffFirstName, s.StaffSurname, fs.TotalItemsSold
FROM FactSale fs, DimStaff s 
WHERE fs.StaffKey = s.StaffKey
ORDER BY TotalItemsSold DESC