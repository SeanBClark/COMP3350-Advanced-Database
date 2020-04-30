SELECT DISTINCT fs.OfficeKey, o.OfficeLocation, COUNT(fs.OfficeKey) AS AmountOfItemsSold, ROUND(SUM(r.RowTotal), 2) as AmountEarned
FROM FactSale fs, DimOffice o, DimReciept r
WHERE fs.OfficeKey = o.OfficeKey AND fs.RecieptKey = r.RecieptKey
Group by fs.OfficeKey, o.OfficeLocation
ORDER BY AmountOfItemsSold DESC