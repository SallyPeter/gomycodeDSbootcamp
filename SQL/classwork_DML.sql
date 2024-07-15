-- Data Manipulation Language
-- INSERT
-- UPDATE 
-- DELETE


-- Switch to the DB
USE shambhus;

-- Preview the tables
SELECT * FROM customer;
SELECT * FROM restaurant;
SELECT * FROM menu_item;
SELECT * FROM orders;
SELECT * FROM payment;


--Insert into tables

INSERT INTO customer 
VALUES ('David', 'Macks', 'davidmacks@email.com', '08011122233', 'GMC Lekki'),
       ('Sally', 'Peter', 'sallypeter@email.com', '08066766766', 'Jakande'),
       ('Madam','Vanessa', 'madamvanessa@email.com','09087656752', 'VI, Lagos'),
       ('David', 'Mark', 'david110@gmail.com', '07032116743', 'Lekki Phase 1'),
       ('Precious', 'John', 'prejayon@live.com', '08032134543', 'Oniru, VI')
;

SELECT * FROM customer;

INSERT INTO restaurant
VALUES ('Chicken Republic', 'Fast Food', 'Oniru, VI', '09034523876'),
       ('KFC', 'Fast Food','Lekki Phase 1', '08065783421'),
       ('Majek''s Kitchen', 'Finger Foods', 'Chisco, Lekki','07033356542')
;
SELECT * FROM restaurant;

INSERT INTO menu_item
VALUES (001, 'Chips','Fried Crispy potatoes', 1200.00),
       (001, 'Wings', '5 peices of grilled chicken wings', 2000.00),
       (001, 'Burger', 'Tasty King sized burger', 5000.00),
       (001, 'Drumsticks', '2 peices grilled Chicken drumsticks', 2500.00),
       (002, 'Moi Moi','Tasty beans pudding', 950.00),
       (002, 'Grilled Chicken', '1 peice of grilled chicken', 2000.00),
       (002, 'Chips', 'Fried Potatoes', 1800.00),
       (002, 'Full Chicken', '1 full peice of grilled Chicken drumsticks', 7400.00),
       (003, 'Puff Puff','10 peices of puff puff', 1500.00),
       (003, 'Akara', '5 peices of bean cake', 1500.00),
       (003, 'Agege Bread', '', 1000.00),
       (003, 'Shawarma', '', 3500.00)
;
SELECT * FROM menu_item;


INSERT INTO orders (customer_id, item_id, delivery_address, delivery_status, quantity, order_date)
VALUES (001, 002, 'The Wings Complex', 'Delivered', 3, '2024-06-25'),
       (002, 003, 'GMC Lekki', 'Delivered', 2, '2024-06-25'),
       (002, 001, 'GMC Lekki', 'Delivered', 1, '2024-06-25'),
       (001, 012, 'Ikeja', 'Delivered', 1, '2024-06-25'),
       (004, 003, 'Lekki Phase 1', 'Delivered', 2, '2024-06-26'),
       (002, 001, 'GMC Lekki', 'Delivered', 5, '2024-06-26'),
       (005, 005, 'The Wings Complex', 'Delivered', 7, '2024-06-27'),
       (001, 003, 'The Wings Complex', 'Delivered', 3, '2024-06-27'),
       (002, 004, 'GMC Lekki', 'Delivered', 8, '2024-06-27'),
       (004, 001, 'KPMG Complex', 'Delivered', 2, '2024-06-30'),
       (003, 011, 'Ajah', 'Delivered', 1, '2024-07-01')
;

INSERT INTO orders (customer_id, item_id, delivery_address, delivery_status, quantity, order_date)
VALUES (003, 002, 'Ajah', 'Pending', 2, '2024-07-08'),
       (003, 011, 'Ajah', 'Pending', 3, '2024-07-08'),
       (003, 002, 'Ajah', 'Pending', 5, '2024-07-08'),
       (002, 003, 'GMC Lekki', 'Pending', 2, '2024-07-09'),
       (003, 006, 'Ikoyi', 'Pending', 2, '2024-07-09'),
       (001, 010, 'The Wings Complex', 'Pending', 1, '2024-07-10'),
       (004, 012, 'KPMG Complex', 'Pending', 2, '2024-07-10'),
       (003, 003, 'Ikoyi', 'Pending', 15, '2024-06-25'),
       (005, 006, 'The Wings Complex', 'Pending', 5, '2024-06-25')
;

INSERT INTO orders (customer_id,item_id,delivery_address,delivery_status, quantity)
VALUES (001, 001, 'The Wings Complex', 'Pending', 1)
;


-- Additional code to alter and update some columns as well as try out a couple other things.

ALTER TABLE orders 
DROP COLUMN total_amount;

ALTER TABLE orders 
ADD quantity INT NOT NULL;

SELECT * FROM orders;

ALTER TABLE orders
DROP COLUMN order_date;

ALTER TABLE orders
ADD order_date DATETIME;

ALTER TABLE payment
DROP COLUMN payment_date;

ALTER TABLE payment
ADD payment_date DATETIME;


-- wrong way of adding to an existing column!!!
'''

INSERT INTO orders (order_date)
VALUES ('12/06/2024')
WHERE(order_id = 11);

Correct method below:
'''
UPDATE orders
SET order_date = '2024-12-06'
WHERE order_id = 1;

---


-- dropping a foreign key
SELECT name 
FROM sys.foreign_keys 
WHERE parent_object_id = OBJECT_ID('orders');

ALTER TABLE orders
DROP CONSTRAINT FK__orders__restaura__412EB0B6;

ALTER TABLE orders
DROP COLUMN restaurant_id;

ALTER TABLE orders
ADD item_id INT FOREIGN KEY REFERENCES menu_item 

---

INSERT INTO orders (customer_id, item_id, delivery_address, delivery_status, quantity, order_date)
VALUES (001, 001, 'The Wings Complex', 'Delivered', 3, '2024-06-25');

SELECT * FROM orders;

DELETE FROM orders;

SELECT * FROM payment;


ALTER TABLE payment
ADD payment_id INT IDENTITY(1,1);

-- This part automatically calculates the amount and time of payment. 

INSERT INTO payment (order_id, amount, payment_date)
SELECT 
    o.order_id,
    o.quantity * m.price AS amount,
    DATEADD(MINUTE, 15, o.order_date) AS payment_date
FROM 
    orders o
JOIN 
    menu_item m ON o.item_id = m.item_id
WHERE 
    o.order_id IN (SELECT DISTINCT order_id FROM orders);


-- Automatically populate the payment table depending on the values in the order table.
-- This can be useful in a case where one wants a record to be automatically added to a record when maybe a payment id (teller number) is provided.

INSERT INTO payment (order_id, amount, payment_date, payment_method)
SELECT 
    o.order_id,
    o.quantity * m.price AS amount,
    DATEADD(MINUTE, 15, o.order_date) AS payment_date,
    (
        SELECT TOP 1 payment_method
        FROM (
            VALUES ('Bank transfer'), ('USSD'), ('Cash'), ('Card')
        ) AS pm(payment_method)
        ORDER BY NEWID()  -- Randomly select one payment method
    ) AS payment_method
FROM 
    orders o
JOIN 
    menu_item m ON o.item_id = m.item_id
WHERE 
    o.order_id IN (SELECT DISTINCT order_id FROM orders);


--The code block above wor for adding the records as expected except that the payment method was the same althrough.
-- Below are other tries to achieve the randomization of the payment method but didn't work sha. If you find a way around it... I'd be glad to learn how you did it.

INSERT INTO payment (order_id, amount, payment_date, payment_method)
SELECT 
    o.order_id,
    o.quantity * m.price AS amount,
    DATEADD(MINUTE, 15, o.order_date) AS payment_date,
    pm.payment_method
FROM 
    orders o
JOIN 
    menu_item m ON o.item_id = m.item_id
CROSS APPLY (
    SELECT TOP 1 payment_method
    FROM (
        VALUES ('Bank transfer'), ('USSD'), ('Cash'), ('Card')
    ) AS pm(payment_method)
    ORDER BY NEWID()
) AS pm;


DROP TABLE payment;


CREATE TABLE payment (
    payment_id INT PRIMARY KEY IDENTITY(1, 1),
    order_id  INT FOREIGN KEY REFERENCES orders,
    amount DECIMAL(8,2),
    payment_date DATETIME,
    payment_method VARCHAR(50) CHECK (payment_method IN ('Bank transfer','USSD', 'Cash', 'Card'))
);

SELECT * FROM payment;


INSERT INTO payment (payment_method)
SELECT TOP 10 rndm.name
  FROM sys.all_objects a1
 CROSS
  JOIN (VALUES ('Bank transfer'), ('USSD'), 
                ('Cash'), ('Card')) rndm(name)
 ORDER BY CHECKSUM(NEWID());


INSERT INTO payment (order_id, amount, payment_date, payment_method)
SELECT 
    o.order_id,
    o.quantity * m.price AS amount,
    DATEADD(MINUTE, 15, o.order_date) AS payment_date,
    (
        SELECT TOP 1 payment_method
        FROM (
            VALUES ('Bank transfer'), ('USSD'), ('Cash'), ('Card')
        ) AS pm(payment_method)
        ORDER BY NEWID()  -- Randomly select one payment method
    ) AS payment_method
FROM 
    orders o
JOIN 
    menu_item m ON o.item_id = m.item_id
WHERE 
    o.order_id IN (SELECT DISTINCT order_id FROM orders);



-- Assuming payment_id is the primary key or a unique identifier in the payment table
-- Update payment_method for rows where payment_id is between 1 and 10

UPDATE p
SET p.payment_method = rndm.name
FROM payment p
JOIN (
    SELECT TOP 23 payment_id, rndm.name
    FROM payment
    CROSS JOIN (
        VALUES ('Bank transfer'), ('USSD'), ('Cash'), ('Card')
    ) rndm(name)
    WHERE payment_id BETWEEN 1 AND 23
    ORDER BY payment_id  -- Ensure consistent order for deterministic results
) AS rndm ON p.payment_id = rndm.payment_id;

SELECT * FROM payment;


