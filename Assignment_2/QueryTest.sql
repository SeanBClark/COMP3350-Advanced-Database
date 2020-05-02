SELECT * FROM Dimension.City WHERE	[State Province]='Florida'

SELECT * FROM Dimension.Customer

SELECT * FROM Fact.Sale

select * from Dimension.Date;

select * from fact.Purchase

select * from Dimension.[Transaction Type]

select * from Dimension.Employee

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

--SELECT  year(Fact.Sale.[Invoice Date Key]) as Year, datename(month, Fact.Sale.[Invoice Date Key]) as Month, sum(Fact.Sale.[Total Excluding Tax]) as [Monthly Sales Amount]
--FROM Fact.Sale INNER JOIN Dimension.City
--ON Fact.Sale.[City Key] = Dimension.City.[City Key] and Dimension.City.[State Province] = 'Florida'
--GROUP BY month(Fact.Sale.[Invoice Date Key]), datename(month, Fact.Sale.[Invoice Date Key]), year(Fact.Sale.[Invoice Date Key])
--ORDER BY year(Fact.Sale.[Invoice Date Key]), month(Fact.Sale.[Invoice Date Key])


--SELECT year(Fact.Sale.[Invoice Date Key]) as Year, sum(Fact.Sale.[Total Excluding Tax]) as [Yearly Sales]
--FROM Fact.Sale INNER JOIN Dimension.City
--ON Fact.Sale.[City Key] = Dimension.City.[City Key] and Dimension.City.[State Province] = 'Florida'
--GROUP BY year(Fact.Sale.[Invoice Date Key])
--ORDER BY year(Fact.Sale.[Invoice Date Key])

select top 10 count(Fact.Sale.Quantity) as SaleCount, Fact.Sale.Description from Fact.Sale group by Fact.Sale.Description order by count(Fact.Sale.Quantity) desc;

select top 10 count(Fact.Sale.Quantity) as SaleCount, Fact.Sale.Description from Fact.Sale group by Fact.Sale.Description order by count(Fact.Sale.Quantity) asc;

select top 10 count(Fact.Sale.[Customer Key]) as [Top Sales], Dimension.Customer.[Customer Key], Dimension.Customer.Customer from Fact.Sale 
	inner join Dimension.Customer on Fact.Sale.[Customer Key] = Dimension.Customer.[Customer Key] 
	where Dimension.Customer.Customer != 'Unknown' 
	group by Dimension.Customer.[Customer Key], Dimension.Customer.Customer
	order by count(Fact.Sale.[Customer Key]) desc;

select top 10 count(Fact.Sale.[Customer Key]) as [Least Sales], Dimension.Customer.[Customer Key], Dimension.Customer.Customer from Fact.Sale 
	inner join Dimension.Customer on Fact.Sale.[Customer Key] = Dimension.Customer.[Customer Key] 
	where Dimension.Customer.Customer != 'Unknown' 
	group by Dimension.Customer.[Customer Key], Dimension.Customer.Customer
	order by count(Fact.Sale.[Customer Key]) asc;



SELECT * FROM Fact.Sale

select top 10 count(Fact.Sale.Profit) as [Most Profitable], Fact.Sale.Description from Fact.Sale group by Fact.Sale.Description order by count(Fact.Sale.Profit) desc;