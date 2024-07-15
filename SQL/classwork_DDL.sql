-- Create a database called Shambhus
CREATE DATABASE shambhus;

-- Change directory to database Shambhus
USE shambhus;

-- To delete a database
DROP DATABASE shambhus;

-- To chane database name
ALTER DATABASE shambhus MODIFY NAME = shhhambhus;

ALTER DATABASE shhhambhus MODIFY NAME = shambhus;

-- creating tables from entity relational diagrams

CREATE TABLE customer(
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone_no VARCHAR(11) UNIQUE,
    contact_address VARCHAR(100) NOT NULL
);


CREATE TABLE restaurant(
    restaurant_id INT PRIMARY KEY IDENTITY(1,1),
    restaurant_name VARCHAR(100) UNIQUE,
    cuisine_type VARCHAR(100) NOT NULL,
    restaurant_address VARCHAR(100) NOT NULL,
    contact_number VARCHAR(11) NOT NULL
);


CREATE TABLE menu_item(
    item_id INT PRIMARY KEY IDENTITY(1,1),
    restaurant_id INT FOREIGN KEY REFERENCES restaurant,
    item_name VARCHAR(100) NOT NULL,
    item_description VARCHAR(250),
    price DECIMAL(8, 2),
);


CREATE TABLE orders(
    order_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT FOREIGN KEY REFERENCES customer,
    restaurant_id INT FOREIGN KEY REFERENCES restaurant,
    order_date TIMESTAMP,
    total_amount DECIMAL(6,2),
    delivery_address VARCHAR(100),
    delivery_status VARCHAR(100) CHECK(delivery_status IN ('Pending', 'Delivered'))
);

CREATE TABLE payment(
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT FOREIGN KEY REFERENCES orders,
    payment_date TIMESTAMP,
    amount DECIMAL(8,2),
    payment_method VARCHAR(100) CHECK(payment_method IN ('Cash', 'Transfer', 'Card', 'USSD'))
);


-- selecting the tables
SELECT * FROM customer;
SELECT * FROM restaurant;
SELECT * FROM menu_item;
SELECT * FROM orders;
SELECT * FROM payment;

-- selectin particular columns from tables
SELECT customer_id, first_name, last_name FROM customer;

-- Altering Tables
EXEC sp_rename 'customer.customer_id', 'customer_id', 'COLUMN';


