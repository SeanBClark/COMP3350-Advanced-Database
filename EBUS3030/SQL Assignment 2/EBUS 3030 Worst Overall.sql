--Worst performing items in the company as a whole
SELECT Distinct i.ItemDescription, fs.ItemKey, COUNT(fs.ItemKey) as ItemsSold
FROM FactSale fs, DimItem i
WHERE fs.ItemKey = i.ItemKey
GROUP BY fs.ItemKey, i.ItemDescription
ORDER BY ItemsSold