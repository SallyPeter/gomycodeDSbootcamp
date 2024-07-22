CREATE DATABASE wine
USE wine

CREATE TABLE WINE
(Wine_id VARCHAR (30) PRIMARY KEY,
Category VARCHAR (50) NOT NULL,
Year DATE NOT NULL,
Degree INT);

INSERT INTO WINE (Wine_id,Category,Year,Degree)
VALUES 
('W001','Red wine','2023-05-02','09'),
('W002','Red wine','2023-04-02','14'),
('W003','Black wine','2023-02-03','22'),
('W004','Blue wine','2023-07-23','10'),
('W005','Black wine','2023-08-25','09'),
('W006','Black wine','2023-07-13','20'),
('W012','Blue wine','2023-07-06','11'),
('W008','Black wine','2023-06-11','10'),
('W009','Blue wine','2023-07-04','12'),
('W010','Red wine','2023-06-10','13');

CREATE TABLE Producers
(Prod_num VARCHAR(20) PRIMARY KEY,
First_name VARCHAR(20) NOT NULL,
Last_name VARCHAR (20) NOT NULL,
Region VARCHAR(20) NOT NULL);

INSERT INTO Producers (Prod_num,First_name,Last_name,Region)
VALUES
('P020','Bunusa','Ombugadu','Awonge'),
('P021','Echuku','Kasuwa','Shinge'),
('P022','Anna','Angbalaga','Lagos'),
('P023','Atari','Ebuga','Sousse'),
('P024','Innocent','Agabi','Nasarawa Eggon'),
('P025','Olusha','Bala','Awonge'),
('P026','Precious','Dasen','Railway Axis'),
('P027','Nicholas','Yunana','Ikoyi'),
('P029','Dolapo','Musbau','Sousse'),
('P030','Kenneth','Eze','Benue');


CREATE TABLE Harvest
(Harvest_id VARCHAR (20) PRIMARY KEY,
Wine_id VARCHAR (30) NOT NULL,
Prod_num VARCHAR (20) NOT NULL,
Units INT NOT NULL,
FOREIGN KEY (Wine_id) REFERENCES wine (Wine_id),
FOREIGN KEY (prod_num)REFERENCES Producers (Prod_num));

INSERT INTO Harvest
(Harvest_id,Wine_id,Prod_num,Units)
VALUES
('Harv001','W002','P020','230'),
('Harv002','W003','P023','365'),
('Harv003','W005','P025','450'),
('Harv004','W004','P026','200'),
('Harv005','W001','P029','310'),
('Harv006','W006','P030','120'),
('Harv007','W008','P024','280'),
('Harv008','W009','P021','314'),
('Harv009','W012','P022','417'),
('Harv010','W009','P027','166');
