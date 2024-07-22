USE shop;

SELECT TOP(5) * FROM Customer;

SELECT TOP(5) * FROM [Order];

SELECT TOP(5) * FROM OrderItem;

SELECT TOP(5) * FROM Product;

SELECT TOP(5) * FROM Supplier;



-- How many customers do we have in UK, Spain and Switzerland individually

SELECT Country, COUNT(Id) AS 'No. of Customers' FROM Customer
GROUP BY Country
HAVING Country IN ('UK', 'Spain', 'Switzerland');

-- What customer has placed the highest number of orders

SELECT TOP(1) CustomerId, COUNT(Id) AS 'No. of Orders' FROM [Order]
GROUP BY CustomerId
ORDER BY COUNT(Id) DESC;

-- OR

SELECT TOP(1) o.CustomerId, COUNT(o.Id) AS 'No. of Orders', c.FirstName, c.LastName 
FROM [Order] AS o LEFT JOIN Customer AS c ON o.CustomerId = c.Id
GROUP BY o.CustomerId, c.FirstName, c.LastName 
ORDER BY COUNT(o.Id) DESC;

-- What is the total amount of money the above customer has spent in our organization

SELECT TOP(1) CustomerId, COUNT(Id) AS 'No. of Orders', SUM(TotalAmount) AS 'Total Amount Spent' from [Order]
GROUP BY CustomerId
ORDER BY COUNT(Id) DESC;

-- What is our yearly revenue?

SELECT YEAR(OrderDate) AS 'YEAR', SUM(TotalAmount) AS 'Yearly Revenue' FROM [Order]
GROUP BY YEAR(OrderDate);

-- In what country's city is "Karkki Oy" Company based and what is their contact details

SELECT Country, City, Phone AS 'Contact Details' FROM Supplier
WHERE CompanyName = 'Karkki Oy';

--What products have been discontinued?

SELECT ProductName FROM Product
WHERE IsDiscontinued = 1;

-- What order has the highest Total amount

SELECT TOP(1) * FROM [ORDER]
ORDER BY TotalAmount DESC;

