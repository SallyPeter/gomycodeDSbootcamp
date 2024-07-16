
USE shambhus;

-- fetch the columns first_name and last_name from the customer table
SELECT first_name, last_name
FROM customer;

-- Concatenation and Aliases

SELECT first_name +' '+ last_name as 'Full Name'
FROM customer;

-- Using the Where clause (Ideally used as a filter)

SELECT delivery_address, delivery_status
FROM orders
WHERE delivery_status = 'Pending';

SELECT delivery_address, delivery_status
FROM orders
WHERE delivery_status = 'Pending' AND delivery_address ='The Wings Complex';

SELECT *
FROM orders
WHERE order_date BETWEEN '2024-06-25' AND '2024-06-26';

-- Using the Distinct function
SELECT DISTINCT(order_date) FROM orders;

-- Wildcards %(1 or more character) and _(1 character)

SELECT * FROM customer
WHERE first_name LIKE '%l%'; --returns all records where the first name contains letter l

SELECT * FROM customer
WHERE first_name LIKE '%v%'; --returns all records where the first name contains letter v

SELECT * FROM customer
WHERE first_name LIKE 'S___y'; --returns all records where the first name starts with S, ends with y and has 3 letters between

SELECT * FROM customer
WHERE first_name LIKE '_a___'; --returns all records where the first name is a 5 letter word with the second letter as a


-- Using IN

SELECT * FROM customer
WHERE first_name IN ('David', 'Sally');

-- Order By clause

SELECT * FROM orders
ORDER BY quantity DESC;

SELECT TOP(3) * FROM orders
ORDER BY quantity DESC;


SELECT * FROM orders
WHERE quantity BETWEEN 3 AND 7
ORDER BY quantity ASC;

-- N/B: Conditions (where) must come before the ordering/sort

-- Default order is Ascending

SELECT * FROM customer
ORDER BY first_name;

-- Group By clause

SELECT DISTINCT(delivery_address) FROM orders;

SELECT DISTINCT(delivery_address) FROM orders
ORDER BY delivery_address;

SELECT delivery_address, COUNT(order_id) AS 'Number of Orders'
FROM orders
GROUP BY delivery_address

SELECT delivery_address, COUNT(order_id) AS 'Number of Orders'
FROM orders
GROUP BY delivery_address
ORDER BY COUNT(order_id) DESC;

SELECT delivery_address, COUNT(order_id) AS 'Number of Orders'
FROM orders
GROUP BY delivery_address
HAVING COUNT(order_id) >= 3
ORDER BY COUNT(order_id) DESC;

SELECT delivery_address, COUNT(order_id) AS 'Number of Orders'
FROM (SELECT * FROM orders WHERE quantity > 4) AS T
GROUP BY delivery_address
ORDER BY COUNT(order_id) DESC;


SELECT * FROM orders
WHERE delivery_address = 'GMC Lekki';

-- Find the average number of orders by delivery status

SELECT delivery_status, AVG(order_id) AS 'Average No. of Orders' FROM orders
GROUP BY delivery_status;

