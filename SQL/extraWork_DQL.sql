USE shop;



-- WRITE A QUERY TO FIND THE TOP 5 CUSTOMERS BY TOTAL SPENDING ON ORDERS. DISPLAY THE CUSTOMER ID, CUSTOMER NAME AND TOTAL SPENDING

SELECT TOP(5) O.CustomerId, C.FirstName, C.LastName, SUM(O.TotalAmount) AS "Total Amount"
FROM Customer C LEFT JOIN [Order] O ON C.Id = O.CustomerId
GROUP BY O.CustomerId, C.FirstName, C.LastName
ORDER BY SUM(O.TotalAmount) DESC;

-- WRITE A QUERY TO FIND THE TOP 5 MOST ORDERED PRODUCTS BY TOTAL QUANTITY. DISPLAY THE PRODUCT ID, PRODUCT NAME, AND TOTAL QUANTITY ORDERED

SELECT TOP(5) P.Id, P.ProductName, SUM(O.Quantity) AS "Total Quantity"
FROM OrderItem O LEFT JOIN Product P ON O.ProductId = P.Id
GROUP BY P.Id, P.ProductName
ORDER BY SUM(Quantity) DESC;


-- WRITE A QUERY TO CALCULATE THE TOTAL SALES FOR EACH MONTH IN THE FIRST YEAR. DISPLAY THE MONTH AND TOTAL SALES

----- ALL MONTHS IN THE FIRST DISTINCT YEAR IN THE DATA -----

SELECT YEAR(OrderDate) AS "Year", MONTH(OrderDate) AS "Month", SUM(TotalAmount) AS "Total Sales" FROM [Order]
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
HAVING YEAR(OrderDate) = (SELECT TOP(1) YEAR(OrderDate) FROM [Order])
ORDER BY MONTH(OrderDate);

----- ALL MONTHS IN THE FIRST 12 MONTHS -----

SELECT TOP(12) YEAR(OrderDate) AS "Year", MONTH(OrderDate) AS "Month", SUM(TotalAmount) AS "Total Sales" FROM [Order]
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY YEAR(OrderDate), MONTH(OrderDate);

--  Write a query to find the total number of products supplied by each supplier. Display the supplier ID, supplier name, and the total number of products.

----- ANSWER AS QUESTION ASKED -----

SELECT S.Id, S.CompanyName, COUNT(P.Id) AS "Total No. Of Products" 
FROM Supplier S LEFT JOIN Product P ON S.Id = P.SupplierId
GROUP BY S.Id, S.CompanyName
ORDER BY S.CompanyName, COUNT(P.Id);

----- ADDED THE DISCONTINUED COLUMN. LEARNT ABOUT CAST -----

SELECT S.Id, S.CompanyName, COUNT(P.Id) AS "Total No. Of Products", 
        SUM(CAST(P.IsDiscontinued AS INT)) AS "No. Of Discontd. Products" 
FROM Supplier S LEFT JOIN Product P ON S.Id = P.SupplierId
GROUP BY S.Id, S.CompanyName
ORDER BY S.CompanyName, COUNT(P.Id);

--  Write a query to determine the average number of orders placed by customers per month. Display the customer ID, customer name, and the average number of orders per month.

----- COUNT OF ORDERS PER MONTH PER CUSTOMER -----

SELECT YEAR(O.OrderDate) AS "Year", MONTH(O.OrderDate) AS "Month", O.CustomerId, C.FirstName, C.LastName, COUNT(O.Id) AS "No_of_Orders_Per_Month"  
FROM [Order] O LEFT JOIN Customer C ON O.CustomerId = C.Id
GROUP BY YEAR(O.OrderDate), MONTH(O.OrderDate), O.CustomerId, C.FirstName, C.LastName
ORDER BY YEAR(O.OrderDate), MONTH(O.OrderDate), O.CustomerId, C.FirstName, C.LastName;

----- AVERAGE NUMBER OF ORDERS PLACED BY A CUSTOMER PER MONTH (TAKES NOTE OF ALL ORDERS PER MONTH FOR EACH CUSTOMER) -----

SELECT CustomerId, FirstName, LastName, AVG(No_of_Orders_Per_Month) AS "AVG_Order_Per_Month" 
FROM (
        SELECT YEAR(O.OrderDate) AS "Year", MONTH(O.OrderDate) AS "Month", O.CustomerId, C.FirstName, C.LastName, COUNT(O.Id) AS "No_of_Orders_Per_Month"  
        FROM [Order] O LEFT JOIN Customer C ON O.CustomerId = C.Id
        GROUP BY YEAR(O.OrderDate), MONTH(O.OrderDate), O.CustomerId, C.FirstName, C.LastName
    ) SUB
GROUP BY CustomerId, FirstName, LastName
ORDER BY AVG(No_of_Orders_Per_Month);

-- Write a query to find orders with a total value greater than 1000. Display the order ID, customer ID, and total order value.

SELECT Id, CustomerId, TotalAmount FROM [Order]
WHERE TotalAmount > 1000.00;

-- Write a query to calculate the total sales for each Product supplier. Display the Supplier name and total sales

----- ANSWER TO THE QUESTION: TOTAL SALES PER SUPPLIER -----

SELECT S.Id, S.CompanyName, SUM(O.UnitPrice * O.Quantity) AS "Total Sales" FROM 
OrderItem O INNER JOIN Product P ON O.ProductId = P.Id
INNER JOIN Supplier S ON S.Id = P.SupplierId
GROUP BY S.Id, S.CompanyName
ORDER BY S.Id, S.CompanyName;

----- ANSWER WITH A TWEAK: TOTAL SALES PER SUPPLIER PER PRODUCT -----

SELECT S.Id, S.CompanyName, P.ProductName, SUM(O.UnitPrice * O.Quantity) AS "Total Sales" FROM 
OrderItem O INNER JOIN Product P ON O.ProductId = P.Id
INNER JOIN Supplier S ON S.Id = P.SupplierId
GROUP BY S.Id, S.CompanyName, P.ProductName
ORDER BY S.Id, S.CompanyName, P.ProductName;

--  Write a query to find customers who have not placed any orders in the last six months from the last date on the database. Display the customer ID, customer name, 
-- and the date of their last order.


--  Write a query to calculate the average order value (total sales per order) for each customer. Display the customer ID, customer name, and average order value.

SELECT C.Id, C.FirstName + ' ' + C.LastName AS "Full Name", AVG(O.TotalAmount) AS 'Total Amount'
FROM Customer C LEFT JOIN [Order] O ON C.Id = O.CustomerId
GROUP BY C.Id, C.FirstName, C.LastName;


-- Write a query to find the average quantity of each product ordered per order item. Display the product ID, product name, and average quantity ordered.

----- "AVERAGE QUANTITY PER PRODUCT PER ORDER" ASSUMING AN ORDER CAN CONTAIN DIFFERENT QUANTITIES OF SAME PRODUCT -----

SELECT OrderId, ProductId, AVG(Quantity) "Average Quantity" FROM OrderItem
GROUP BY OrderId, ProductId
ORDER BY OrderId, ProductId;

----- QUANTITY PER PRODUCT PER ORDER -----

SELECT OrderId, ProductId, Quantity FROM OrderItem
ORDER BY OrderId, ProductId;

----- AVERAGE QUANTITY OF EACH ORDERED PRODUCT -----
SELECT ProductId, AVG(Quantity) "Average Quantity" FROM OrderItem
GROUP BY ProductId
ORDER BY ProductId;

-- Write a query to calculate the total revenue generated from products supplied by each supplier. Display the supplier ID, supplier name, and total revenue. JOIN REQUIRED

----- ALREADY DID THIS... JUST CHANGED SALES TO REVENUE -----

SELECT S.Id, S.CompanyName, P.ProductName, SUM(O.UnitPrice * O.Quantity) AS "Total Revenue" FROM 
OrderItem O INNER JOIN Product P ON O.ProductId = P.Id
INNER JOIN Supplier S ON S.Id = P.SupplierId
GROUP BY S.Id, S.CompanyName, P.ProductName
ORDER BY S.Id, S.CompanyName, P.ProductName;

-- Write a query to find customers who place orders more than twice a month on average. Display the customer ID, customer name, and average orders per month.

SELECT CustomerId, AVG(Id_Count) AS 'AVG. No. Of Orders' 
FROM (
    SELECT CustomerId, YEAR(OrderDate) AS 'Year', MONTH(OrderDate) AS 'Month', COUNT(Id) AS Id_Count FROM [Order]
    GROUP BY CustomerId, YEAR(OrderDate), MONTH(OrderDate)
) SUB 
GROUP BY CustomerId;

-- Write a query to find the products with the highest variance in order item prices. Display the product ID, product name, and price variance.
----- GOT THIS SOLUTION FROM CHAT GPT THOUGH...
WITH PriceVariances AS (
    SELECT 
        P.Id AS ProductId,
        P.ProductName,
        VAR(OI.UnitPrice) AS PriceVariance
    FROM 
        Product P
    JOIN 
        OrderItem OI ON P.Id = OI.ProductId
    GROUP BY 
        P.Id, P.ProductName
)
SELECT TOP(5)
    ProductId,
    ProductName,
    PriceVariance
FROM 
    PriceVariances
ORDER BY 
    PriceVariance DESC;

-- Write a query to find the distribution of the number of orders placed by customers. Display the number of orders and the count of customers who placed that many orders.


-- Write a query to determine the time of day when most orders are placed. Display the hour of the day and the total number of orders.

SELECT DATEPART(hour, OrderDate), COUNT(Id) FROM [Order]
GROUP BY DATEPART(hour, OrderDate)
ORDER BY DATEPART(hour, OrderDate);



SELECT TOP(5) * FROM Customer;

SELECT TOP(5) * FROM [Order];

SELECT TOP(5) * FROM OrderItem;

SELECT TOP(5) * FROM Product;

SELECT TOP(5) * FROM Supplier;
