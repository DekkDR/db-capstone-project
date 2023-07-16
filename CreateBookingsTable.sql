CREATE TABLE IF NOT EXISTS Bookings (
BookingID INT PRIMARY KEY,
BookingDate DATE,
TableNumber INT,
CustomerID INT);

INSERT INTO Bookings (BookingID,BookingDate, TableNumber,CustomerID)
VALUES(1,'2022-10-10',5,1),
(2,'2022-11-12',3,3),
(3,'2022-10-11',2,2),
(4,'2022-10-13',2,1);

SELECT * FROM Bookings;

CREATE TABLE IF NOT EXISTS OrderStatus (
ID INT PRIMARY KEY auto_increment,
Confirmation VARCHAR(255));

SELECT * FROM OrderStatus;