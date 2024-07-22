--DATA QUERY CHECKPOINT 
CREATE DATABASE first_check_point;
USE first_check_point

create Table Customer (
    customer_id INT PRIMARY KEY,
    customer_name varchar (30) NOT NULL,
    customer_Tel varchar (30) not NULL
);
create Table Product (
    product_id int PRIMARY KEY,
    product_name varchar (30) not NULL,
    category varchar(30) not null, 
    price DECIMAL not NULL
);

create TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE not NULL,
    quantity INT not NULL,
    total_amount DECIMAL not null,
	FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
	FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

insert into Customer (customer_id, customer_name, customer_Tel)
values
(001, 'Ahmed', '08063769015'), 
(002, 'Coulibaly', '09059235546'), 
(003, 'Hasan', '08125344322'),
(004, 'Ifepe', '08093766015'), 
(005, 'Chukwuma', '09069273546'), 
(006, 'Okwudili', '09145354372');

insert into Product (product_id, product_name, category, price)
values (001, 'Spy watch', 'gadget', 100), (002, 'Doohickey', 'widget', 5.2), 
(003, 'Smart watch', 'gadget', 155.5), (004, 'Pencil', 'widget', 10.5),
(005, 'Smart phone', 'gadget', 310), (006, 'Pen', 'widget', 6.4),
(007, 'Smart TV', 'gadget', 1000), (008, 'Cardboard', 'widget', 11.0);

insert into orders
values(001, 001, 002, '2023-01-22', 3, 0), (002, 002, 001, '2023-01-22', 04, 0),
(003, 001, 003, '2023-01-22', 5, 0), (004, 002, 004, '2023-01-22', 14, 0), 
(005, 001, 002, '2023-01-22', 3, 0), (006, 002, 001, '2023-01-22', 04, 0),
(007, 001, 003, '2023-01-22', 5, 0), (034, 003, 004, '2023-01-22', 14, 0),
(008, 001, 003, '2023-01-23', 5, 0), (033, 002, 004, '2023-01-23', 14, 0), 
(009, 001, 002, '2023-01-23', 3, 0), (032, 002, 001, '2023-01-23', 04, 0),
(013, 001, 003, '2023-01-23', 5, 0), (035, 005, 004, '2023-01-23', 14, 0),
(011, 001, 003, '2023-01-24', 5, 0), (036, 002, 004, '2023-01-24', 14, 0), 
(010, 001, 002, '2023-01-24', 3, 0), (037, 002, 001, '2023-01-24', 04, 0),
(012, 001, 003, '2023-01-24', 5, 0), (038, 002, 004, '2023-01-24', 14, 0),
(014, 001, 003, '2023-01-25', 5, 0), (039, 002, 004, '2023-01-25', 14, 0), 
(015, 001, 002, '2023-01-27', 3, 0), (040, 002, 001, '2023-01-25', 04, 0),
(016, 001, 003, '2023-01-26', 5, 0), (044, 002, 004, '2023-01-26', 14, 0),
(017, 001, 003, '2023-01-29', 5, 0), (041, 002, 004, '2023-01-26', 14, 0), 
(018, 001, 002, '2023-01-28', 3, 0), (042, 002, 001, '2023-01-27', 04, 0),
(019, 001, 003, '2023-01-30', 5, 0), (043, 002, 004, '2023-01-27', 14, 0),
(020, 001, 003, '2023-01-21', 5, 0), (045, 006, 004, '2023-01-28', 14, 0), 
(021, 001, 002, '2023-01-21', 3, 0), (046, 006, 001, '2023-01-29', 04, 0),
(023, 001, 003, '2023-01-13', 5, 0), (047, 006, 004, '2023-01-13', 14, 0),
(022, 001, 003, '2023-01-14', 5, 0), (048, 002, 004, '2023-01-14', 14, 0), 
(024, 001, 002, '2023-01-14', 3, 0), (049, 002, 008, '2023-01-14', 04, 0),
(025, 001, 003, '2023-01-15', 5, 0), (050, 006, 008, '2023-01-18', 14, 0),
(026, 001, 003, '2023-01-16', 5, 0), (054, 002, 008, '2023-01-11', 14, 0), 
(027, 001, 002, '2023-01-17', 3, 0), (051, 006, 007, '2023-01-17', 04, 0),
(028, 001, 003, '2023-01-18', 5, 0), (052, 002, 007, '2023-01-11', 14, 0),
(029, 001, 006, '2023-01-19', 5, 0), (053, 002, 007, '2023-01-17', 14, 0), 
(030, 001, 007, '2023-01-20', 3, 0), (055, 006, 006, '2023-01-18', 04, 0),
(031, 001, 008, '2023-01-20', 5, 0), (056, 002, 006, '2023-01-19', 14, 0);
update orders
set total_amount = quantity*100 
where product_id = 001; 

update orders
set total_amount = quantity*5.2 
where product_id = 002; 
update orders
set total_amount = quantity*155.5
where product_id = 003; 
update orders
set total_amount = quantity*10.5 
where product_id = 004; 
update orders
set total_amount = quantity*310 
where product_id = 005; 
update orders
set total_amount = quantity*6.4 
where product_id = 006; 
update orders
set total_amount = quantity*1000
where product_id = 007; 
update orders
set total_amount = quantity*11
where product_id = 008;
