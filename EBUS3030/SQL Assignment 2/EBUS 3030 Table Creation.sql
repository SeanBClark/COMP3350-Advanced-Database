DROP TABLE FactSale
DROP TABLE DimCustomer
DROP TABLE DimStaff
DROP TABLE DimOffice
DROP TABLE DimHistoricalItemPrice
DROP TABLE DimItem
DROP TABLE DimReciept

CREATE TABLE DimCustomer (
	CustomerKey INT PRIMARY KEY IDENTITY NOT NULL,
	CustomerID VARCHAR(5) NOT NULL,
	CustomerFirstName VARCHAR(30) NULL,
	CustomerSurname VARCHAR(30) NULL,
)

CREATE TABLE DimOffice (
	OfficeKey INT PRIMARY KEY IDENTITY NOT NULL,
	OfficeLocation VARCHAR(30) NOT NULL	
)

CREATE TABLE DimStaff (
	StaffKey INT PRIMARY KEY IDENTITY NOT NULL,
	StaffID VARCHAR(5) not null,
	StaffOffice int NULL,
	StaffFirstName VARCHAR(30) NULL,
	StaffSurname VARCHAR(30) NULL,
)

CREATE TABLE DimHistoricalItemPrice (
	HistoricalPriceKey INT PRIMARY KEY IDENTITY NOT NULL,
	ItemName VARCHAR(50) NULL,
	ItemPrice float NULL,
	DateFrom DATETIME NULL,
	DateTo DATETIME NULL,
)

CREATE TABLE DimItem (

	ItemKey INT PRIMARY KEY IDENTITY NOT NULL,
	ItemId int NOT NULL,
	ItemDescription varchar(100) NULL,
	ItemPrice float NULL,

)

CREATE TABLE DimReciept (
	RecieptKey INT PRIMARY KEY IDENTITY NOT NULL,
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
	OfficeKey int not null,
	CustomerKey int not null,
	FOREIGN KEY (RecieptKey) REFERENCES DimReciept (RecieptKey),
	FOREIGN KEY (ItemKey) REFERENCES DImItem (ItemKey),
	FOREIGN KEY (StaffKey)  REFERENCES DimStaff (StaffKey),
	FOREIGN KEY (OfficeKey)  REFERENCES DimOffice (OfficeKey),
	FOREIGN KEY (CustomerKey) REFERENCES DimCustomer (CustomerKey),
)

INSERT INTO DimCustomer (CustomerID, CustomerFirstName, CustomerSurname)
SELECT DISTINCT StageData.[CustomerID], StageData.[CustomerFirstName], StageData.[CustomerSurname] 
FROM StageData
WHERE CustomerID IS NOT NULL AND CustomerID <> '';

INSERT INTO DimOffice(OfficeLocation)
SELECT DISTINCT StageData.[OfficeLocation]
FROM StageData
WHERE OfficeLocation IS NOT NULL AND OfficeLocation <> '';

INSERT INTO DimStaff (StaffID, StaffFirstName, StaffSurname, StaffOffice)
SELECT distinct  StageData.[StaffId] ,StageData.[StaffFirstName], StageData.[StaffSurname], StageData.[StaffOffice]
FROM StageData
WHERE StaffID <> '' AND StaffID IS NOT NULL;

INSERT INTO DimItem(ItemID, ItemDescription, itemPrice)
SELECT DISTINCT StageData.[ItemID] ,StageData.[ItemDescription], StageData.[ItemPrice]  FROM StageData
WHERE ItemDescription <> '' AND ItemID IS NOT NULL AND ItemPrice IS NOT NULL;

INSERT INTO DimReciept(RecieptId, SaleDate, RecieptTransRowId, ItemQuanity, RowTotal)
SELECT DISTINCT StageData.[RecieptID], StageData.[SaleDate], StageData.[RecieptTransactionRowID], StageData.[ItemQuantity], StageData.[RowTotal]
FROM StageData
WHERE RecieptID <> '' AND RecieptID IS NOT NULL AND RowTotal <> 0;

Insert into FactSale(StaffKey, RecieptKey, CustomerKey, ItemKey, OfficeKey) 
SELECT Distinct s.StaffKey, r.RecieptKey, c.CustomerKey, i.ItemKey, o.OfficeKey
FROM StageData sd
	left join DimReciept r on r.RecieptId = sd.[RecieptID]
	left join DimStaff s on s.StaffID = sd.[StaffID]
	left join DimCustomer c on c.CustomerID = sd.[CustomerID]
	left join DimItem i on i.ItemID = sd.[ItemID]
	left join DimOffice o on o.OfficeKey = sd.[Staffoffice]