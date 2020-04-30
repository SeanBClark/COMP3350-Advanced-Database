--3 Most Popular Items in each of the stores
--Store 1
SELECT DISTINCT TOP 3 fs.OfficeKey, o.OfficeLocation, i.ItemDescription, fs.ItemKey, COUNT(fs.ItemKey) as ItemsSold
FROM FactSale fs, DimItem i, DimOffice o
WHERE fs.ItemKey = i.ItemKey AND fs.OfficeKey = 1 AND o.OfficeKey = fs.OfficeKey
GROUP BY fs.ItemKey, i.ItemDescription, fs.OfficeKey, o.OfficeLocation
ORDER BY ItemsSold DESC

--Store 2
SELECT DISTINCT TOP 3 fs.OfficeKey, o.OfficeLocation, i.ItemDescription, fs.ItemKey, COUNT(fs.ItemKey) as ItemsSold
FROM FactSale fs, DimItem i, DimOffice o
WHERE fs.ItemKey = i.ItemKey AND fs.OfficeKey = 2 AND o.OfficeKey = fs.OfficeKey
GROUP BY fs.ItemKey, i.ItemDescription, fs.OfficeKey, o.OfficeLocation
ORDER BY ItemsSold DESC

--Store 3
SELECT DISTINCT TOP 3 fs.OfficeKey, o.OfficeLocation, i.ItemDescription, fs.ItemKey, COUNT(fs.ItemKey) as ItemsSold
FROM FactSale fs, DimItem i, DimOffice o
WHERE fs.ItemKey = i.ItemKey AND fs.OfficeKey = 3 AND o.OfficeKey = fs.OfficeKey
GROUP BY fs.ItemKey, i.ItemDescription, fs.OfficeKey, o.OfficeLocation
ORDER BY ItemsSold DESC

--Store 4
SELECT DISTINCT TOP 3 fs.OfficeKey, o.OfficeLocation, i.ItemDescription, fs.ItemKey, COUNT(fs.ItemKey) as ItemsSold
FROM FactSale fs, DimItem i, DimOffice o
WHERE fs.ItemKey = i.ItemKey AND fs.OfficeKey = 4 AND o.OfficeKey = fs.OfficeKey
GROUP BY fs.ItemKey, i.ItemDescription, fs.OfficeKey, o.OfficeLocation
ORDER BY ItemsSold DESC

--Store 5
SELECT DISTINCT TOP 3 fs.OfficeKey, o.OfficeLocation, i.ItemDescription, fs.ItemKey, COUNT(fs.ItemKey) as ItemsSold
FROM FactSale fs, DimItem i, DimOffice o
WHERE fs.ItemKey = i.ItemKey AND fs.OfficeKey = 5 AND o.OfficeKey = fs.OfficeKey
GROUP BY fs.ItemKey, i.ItemDescription, fs.OfficeKey, o.OfficeLocation
ORDER BY ItemsSold DESC

--Store 6
SELECT DISTINCT TOP 3 fs.OfficeKey, o.OfficeLocation, i.ItemDescription, fs.ItemKey, COUNT(fs.ItemKey) as ItemsSold
FROM FactSale fs, DimItem i, DimOffice o
WHERE fs.ItemKey = i.ItemKey AND fs.OfficeKey = 6 AND o.OfficeKey = fs.OfficeKey
GROUP BY fs.ItemKey, i.ItemDescription, fs.OfficeKey, o.OfficeLocation
ORDER BY ItemsSold DESC

--Store 7
SELECT DISTINCT TOP 3 fs.OfficeKey, o.OfficeLocation, i.ItemDescription, fs.ItemKey, COUNT(fs.ItemKey) as ItemsSold
FROM FactSale fs, DimItem i, DimOffice o
WHERE fs.ItemKey = i.ItemKey AND fs.OfficeKey = 7 AND o.OfficeKey = fs.OfficeKey
GROUP BY fs.ItemKey, i.ItemDescription, fs.OfficeKey, o.OfficeLocation
ORDER BY ItemsSold DESC

--Store 8
SELECT DISTINCT TOP 3 fs.OfficeKey, o.OfficeLocation, i.ItemDescription, fs.ItemKey, COUNT(fs.ItemKey) as ItemsSold
FROM FactSale fs, DimItem i, DimOffice o
WHERE fs.ItemKey = i.ItemKey AND fs.OfficeKey = 8 AND o.OfficeKey = fs.OfficeKey
GROUP BY fs.ItemKey, i.ItemDescription, fs.OfficeKey, o.OfficeLocation
ORDER BY ItemsSold DESC

--Store 9
SELECT DISTINCT TOP 3 fs.OfficeKey, o.OfficeLocation, i.ItemDescription, fs.ItemKey, COUNT(fs.ItemKey) as ItemsSold
FROM FactSale fs, DimItem i, DimOffice o
WHERE fs.ItemKey = i.ItemKey AND fs.OfficeKey = 9 AND o.OfficeKey = fs.OfficeKey
GROUP BY fs.ItemKey, i.ItemDescription, fs.OfficeKey, o.OfficeLocation
ORDER BY ItemsSold DESC

--Store 10
SELECT DISTINCT TOP 3 fs.OfficeKey, o.OfficeLocation, i.ItemDescription, fs.ItemKey, COUNT(fs.ItemKey) as ItemsSold
FROM FactSale fs, DimItem i, DimOffice o
WHERE fs.ItemKey = i.ItemKey AND fs.OfficeKey = 10 AND o.OfficeKey = fs.OfficeKey
GROUP BY fs.ItemKey, i.ItemDescription, fs.OfficeKey, o.OfficeLocation
ORDER BY ItemsSold DESC