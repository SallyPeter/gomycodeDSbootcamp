-- Implement the provided relation model using SQL ( DDL part )
-- Insert data into your tables ( DML part )

USE first_check_point;

--- Write a SQL query to retrieve the names of the customers who have placed an order for at least one widget and at least one gadget, 
--- along with the total cost of the widgets and gadgets ordered by each customer. 
--- The cost of each item should be calculated by multiplying the quantity by the price of the product.

SELECT C.customer_name, P.product_name, P.category, SUM(O.total_amount) AS "Total Amount" FROM
Customer C LEFT JOIN orders O ON C.customer_id = O.customer_id 
LEFT JOIN Product P ON O.product_id = P.product_id
GROUP BY C.customer_name, P.product_name, P.category
HAVING P.category = 'widget' OR P.category = 'gadget';


--- Write a query to retrieve the names of the customers who have placed an order for at least one widget, along with the total cost of the widgets ordered by each customer.
SELECT C.customer_name, P.category, SUM(O.total_amount) AS "Total Amount" FROM
Customer C LEFT JOIN orders O ON C.customer_id = O.customer_id 
LEFT JOIN Product P ON O.product_id = P.product_id
GROUP BY C.customer_name, P.category
HAVING P.category = 'widget';

--- Write a query to retrieve the names of the customers who have placed an order for at least one gadget, along with the total cost of the gadgets ordered by each customer.
SELECT C.customer_name, P.category, SUM(O.total_amount) AS "Total Amount" FROM
Customer C LEFT JOIN orders O ON C.customer_id = O.customer_id 
LEFT JOIN Product P ON O.product_id = P.product_id
GROUP BY C.customer_name, P.category
HAVING P.category = 'gadget';

--- Write a query to retrieve the names of the customers who have placed an order for at least one doohickey, 
--- along with the total cost of the doohickeys ordered by each customer.

SELECT C.customer_name, P.product_name, P.category, SUM(O.total_amount) AS "Total Amount" FROM
Customer C LEFT JOIN orders O ON C.customer_id = O.customer_id 
LEFT JOIN Product P ON O.product_id = P.product_id
GROUP BY C.customer_name, P.product_name, P.category
HAVING P.product_name = 'doohickey';

--- Write a query to retrieve the total number of widgets and gadgets ordered by each customer, along with the total cost of the orders.
SELECT C.customer_name, P.category, COUNT(P.product_id) AS "No. Of Products", SUM(O.total_amount) AS "Total Amount"
FROM Product P LEFT JOIN orders O ON P.product_id = O.product_id
LEFT JOIN Customer C ON O.customer_id = C.customer_id
GROUP BY C.customer_name, category
ORDER BY C.customer_name, category;

--- Write a query to retrieve the names of the products that have been ordered by at least one customer, along with the total quantity of each product ordered.
SELECT P.product_id, P.product_name, SUM(O.quantity) AS "Total Quantity"
FROM orders O LEFT JOIN Product P ON O.product_id = P.product_id
GROUP BY P.product_id, P.product_name;

--- Write a query to retrieve the names of the customers who have placed the most orders, along with the total number of orders placed by each customer.
SELECT TOP(2) C.customer_name, COUNT(O.order_id) AS "Total No. of Orders"
FROM orders O LEFT JOIN Customer C ON O.customer_id = C.customer_id
GROUP BY C.customer_name
ORDER BY COUNT(O.order_id) DESC;

--- Write a query to retrieve the names of the products that have been ordered the most, along with the total quantity of each product ordered.
SELECT TOP(3) P.product_id, P.product_name, SUM(O.quantity) AS "Total Quantity"
FROM orders O LEFT JOIN Product P ON O.product_id = P.product_id
GROUP BY P.product_id, P.product_name
ORDER BY SUM(quantity) DESC;


--- Write a query to retrieve the names of the customers who have placed an order on every day of the week, along with the total number of orders placed by each customer.
SELECT C.customer_name, COUNT(DISTINCT DATEPART(dw, O.order_date)) AS "Total Days", COUNT(O.order_id)
FROM Customer C JOIN orders O ON C.customer_id = O.customer_id
GROUP BY C.customer_name
HAVING COUNT(DISTINCT(DATEPART(dw, O.order_date))) = 7;



SELECT TOP(5) * FROM Customer;

SELECT TOP(5) * FROM Orders;

SELECT TOP(5) * FROM product;


