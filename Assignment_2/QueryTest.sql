SELECT * FROM Dimension.City WHERE	[State Province]='Florida'

SELECT * FROM Dimension.Customer

SELECT * FROM Fact.Sale

--SELECT sum(Fact.Sale.[Total Excluding Tax]) as Sales, Fact.Sale.[City Key], Dimension.City.[City Key], year(Fact.Sale.[Invoice Date Key]) as Year, Dimension.City.[State Province]
--FROM Fact.Sale INNER JOIN Dimension.City
--ON Fact.Sale.[City Key] = Dimension.City.[City Key] and Dimension.City.[State Province] = 'Florida'
--GROUP BY year(Fact.Sale.[Invoice Date Key]), Fact.Sale.[City Key], Dimension.City.[City Key], Dimension.City.[State Province]
--ORDER BY year(Fact.Sale.[Invoice Date Key])

--SELECT  year(Fact.Sale.[Invoice Date Key]) as Year, month(Fact.Sale.[Invoice Date Key]) as Month, sum(Fact.Sale.[Total Excluding Tax]) as [Monthly Sales Amount]
--FROM Fact.Sale INNER JOIN Dimension.City
--ON Fact.Sale.[City Key] = Dimension.City.[City Key] and Dimension.City.[State Province] = 'Florida'
--GROUP BY month(Fact.Sale.[Invoice Date Key]), year(Fact.Sale.[Invoice Date Key])
--ORDER BY year(Fact.Sale.[Invoice Date Key]), month(Fact.Sale.[Invoice Date Key])

SELECT  year(Fact.Sale.[Invoice Date Key]) as Year, datename(month, Fact.Sale.[Invoice Date Key]) as Month, sum(Fact.Sale.[Total Excluding Tax]) as [Monthly Sales Amount]
FROM Fact.Sale INNER JOIN Dimension.City
ON Fact.Sale.[City Key] = Dimension.City.[City Key] and Dimension.City.[State Province] = 'Florida'
GROUP BY month(Fact.Sale.[Invoice Date Key]), datename(month, Fact.Sale.[Invoice Date Key]), year(Fact.Sale.[Invoice Date Key])
ORDER BY year(Fact.Sale.[Invoice Date Key]), month(Fact.Sale.[Invoice Date Key])


SELECT year(Fact.Sale.[Invoice Date Key]) as Year, sum(Fact.Sale.[Total Excluding Tax]) as [Yearly Sales]
FROM Fact.Sale INNER JOIN Dimension.City
ON Fact.Sale.[City Key] = Dimension.City.[City Key] and Dimension.City.[State Province] = 'Florida'
GROUP BY year(Fact.Sale.[Invoice Date Key])
ORDER BY year(Fact.Sale.[Invoice Date Key])