'''
Here is the list of records that we are going to use all along the exercise:

products table:
Record 1: (name= "Cookies", price= 10)
Record 2: (name= "Candy", price= 5.2)
customers table
Record 1: (name= "Ahmed", address= "Tunisia")
Record 2: (name= "Coulibaly", address= "Senegal")
Record 3: (name= "Hasan", address= "Egypt")
orders table
Record 1: (costumerid= 1, productid= 2, quantity= 3, order_date= '2023-01-22')
Record 2: (costumerid= 2, productid= 1, quantity= 10, order_date= '2023-04-14')

'''

USE checkpoints;

INSERT INTO products
VALUES('Cookies', 10),
        ('Candy', 5.2);

INSERT INTO customers
VALUES('Ahmed', 'Tunisia'),
        ('Coulibaly', 'Senegal'),
        ('Hasan', 'Egypt');

INSERT INTO orders
VALUES (1,2,3,'2023-01-22'),
        (2,1,10,'2023-04-14');


SELECT * FROM products;
SELECT * FROM customers;
SELECT * FROM orders;



--Update the quantity of the second order, the new value should be 6.

UPDATE orders
SET quantity = 6
WHERE order_id = 2;

SELECT * FROM orders

--Delete the third customer from the customers table.

DELETE FROM customers
WHERE cust_id = 3;

SELECT * FROM customers;

--Delete the orders table content then drop the table.

DELETE FROM orders;

DROP TABLE orders;

SELECT * FROM orders;
