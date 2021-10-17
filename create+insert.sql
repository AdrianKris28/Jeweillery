USE master
GO
IF EXISTS(SELECT * FROM SYS.sysdatabases WHERE name = 'Jeweillery') 
BEGIN
	DROP DATABASE Jeweillery
END
CREATE DATABASE Jeweillery
GO
USE Jeweillery
GO
CREATE TABLE Customer(
	CustomerID		CHAR(5)		PRIMARY KEY		CHECK(CustomerID LIKE 'CU[0-9][0-9][0-9]'),
	CustomerName	VARCHAR(50)	NOT NULL,
	CustomerGender	VARCHAR(50)	CHECK(CustomerGender LIKE 'Male' OR CustomerGender LIKE 'Female')	NOT NULL,
	CustomerDOB		DATE		NOT NULL,
	CustomerEmail	VARCHAR(50)	NOT NULL,
	CustomerPhone	VARCHAR(50)	CHECK(CustomerPhone LIKE '+62%')
)
GO
CREATE TABLE Jewellery(
	JewelleryID			CHAR(5)		PRIMARY KEY		CHECK(JewelleryID LIKE 'JE[0-9][0-9][0-9]'),
	JewelleryName		VARCHAR(50)		NOT NULL,
	JewelleryMaterial	VARCHAR(50)		NOT NULL,
	JewelleryWeight		INT				NULL,
	JewelleryPrice		DECIMAL(10,2)	NOT NULL
)
GO
CREATE TABLE HeaderTransaction(
	TransactionID	CHAR(5)		PRIMARY KEY		CHECK(TransactionID LIKE 'TR[0-9][0-9][0-9]'),
	CustomerID		CHAR(5)		FOREIGN KEY REFERENCES Customer(CustomerID) ON UPDATE CASCADE ON DELETE CASCADE,
	TransactionDate	DATE		NOT NULL
)
GO
CREATE TABLE DetailTransaction(
	TransactionID	CHAR(5)	FOREIGN KEY REFERENCES HeaderTransaction(TransactionID) ON UPDATE CASCADE ON DELETE CASCADE,
	JewelleryID		CHAR(5)	FOREIGN KEY REFERENCES Jewellery(JewelleryID) ON UPDATE CASCADE ON DELETE CASCADE,
	Quantity		INT
)
GO
INSERT INTO Customer VALUES
('CU001','Veronica Zhang','Female','1995-01-09', 'veronica@gmail.com', '+6285613333118'),
('CU002','Calum Then','Male','1990-11-03', 'calum@yahoo.com', '+628111356133'),
('CU003','Thomas Angelo','Male','1992-10-22', 'thomas@gmail.com', '+6285610456345'),
('CU004','Natasya Dann','Female','1990-01-01', 'natasya@yahoo.com', '+6281119351111'),
('CU005','Feriandi Salim','Male','1996-08-22', 'feriandi@yahoo.co.id', '+6285644446676'),
('CU006','Louis Hood','Male','1999-04-24', 'louis@gmail.com', '+6281119336452'),
('CU007','Feraya Gabriella','Female','1988-02-08', 'feraya@gmail.com', '+6285119457898')
INSERT INTO Jewellery VALUES
('JE001', 'Rosy Ring', 'White Gold', 3, 2000000),
('JE002', 'Lovely Sydney Necklace', 'White Gold', 9, 5800000),
('JE003', 'Olympia Earring', 'Gold', 2, 1700000),
('JE004', 'Frankfurt Ring', 'Silver', 3, 2100000),
('JE005', 'Jasmine Bracelet', 'Gold', 7, 4900000),
('JE006', 'Swan Necklace', 'Diamond', 10, 6500000),
('JE007', 'Dahlia Ring', 'White Gold', 3, 2200000)
INSERT INTO HeaderTransaction VALUES
('TR001','CU002','2020-01-01'),
('TR002','CU004','2020-01-11'),
('TR003','CU006','2020-02-02'),
('TR004','CU007','2020-02-03'),
('TR005','CU001','2020-02-03'),
('TR006','CU003','2020-02-14'),
('TR007','CU005','2020-02-15'),
('TR008','CU007','2020-02-16'),
('TR009','CU006','2020-03-01'),
('TR010','CU002','2020-03-07'),
('TR011','CU002','2020-03-11'),
('TR012','CU004','2020-03-11'),
('TR013','CU006','2020-04-02'),
('TR014','CU007','2020-04-05'),
('TR015','CU001','2020-04-13')
INSERT INTO DetailTransaction VALUES
('TR001','JE006',1),
('TR001','JE002',2),
('TR002','JE007',1),
('TR003','JE007',5),
('TR004','JE001',1),
('TR004','JE006',7),
('TR005','JE005',1),
('TR005','JE004',2),
('TR006','JE003',3),
('TR006','JE002',4),
('TR006','JE004',1),
('TR007','JE001',1),
('TR008','JE006',1),
('TR009','JE003',2),
('TR010','JE001',1),
('TR011','JE002',3),
('TR012','JE003',8),
('TR013','JE002',10),
('TR014','JE006',1),
('TR015','JE001',2)
GO
EXEC sp_MSforeachtable 'SELECT * FROM ?'