
USE master;

CREATE DATABASE checkpoints;

USE checkpoints;



CREATE TABLE customers(
    cust_id INT PRIMARY KEY IDENTITY(1,1),
    cust_name VARCHAR(50),
    cust_add VARCHAR(150) 
);

CREATE TABLE products(
    prod_id INT PRIMARY KEY IDENTITY(1,1),
    prod_name VARCHAR(50),
    prod_price DECIMAL(8,2) CHECK(prod_price > 0)
);
 
CREATE TABLE orders(
    order_id INT PRIMARY KEY IDENTITY(1,1),
    cust_id INT FOREIGN KEY REFERENCES customers,
    prod_id INT FOREIGN KEY REFERENCES products,
    quantity INT,
    order_date DATE
);

