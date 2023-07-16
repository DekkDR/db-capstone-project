USE LittleLemonDB;

-- Task1
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

-- DROP TABLE Bookings;

-- Task2

CREATE TABLE IF NOT EXISTS BookingStatus (
ID INT PRIMARY KEY auto_increment,
BookingDate DATE,
TableNumber INT,
BookingStatus VARCHAR(255));

-- DROP TABLE BookingStatus;

CREATE TRIGGER UpdateBookingStatus
	AFTER INSERT 
    ON Bookings FOR EACH ROW
	INSERT INTO BookingStatus(BookingDate,TableNumber,BookingStatus) 
    VALUES(NEW.BookingDate,NEW.TableNumber,CONCAT("Table ",NEW.TableNumber," is already booked"));  

-- DROP TRIGGER IF EXISTS UpdateBookingStatus;

SELECT * FROM BookingStatus;

DELIMITER // 

CREATE PROCEDURE CheckBooking(IN booking_date DATE, IN table_number INT)
BEGIN
SELECT BookingStatus FROM BookingStatus WHERE BookingDate = booking_date AND TableNumber = table_number;
END //

DELIMITER ;
CALL CheckBooking("2022-11-12",3);

-- DROP PROCEDURE CheckBooking;

-- Task3
DELIMITER // 

CREATE PROCEDURE AddValidBooking(IN booking_date DATE, IN table_number INT)
BEGIN
	SET @b_date = booking_date;
    SET @t_number = table_number;
	START TRANSACTION;
    INSERT INTO Bookings(BookingID,BookingDate,TableNumber,CustomerID) VALUES(6,@b_date,@t_number,5);
	IF EXISTS(SELECT * FROM Bookings WHERE BookingDate = @b_date AND TableNumber = @t_number) THEN
		ROLLBACK;
        INSERT INTO BookingStatus(BookingDate,TableNumber,BookingStatus) 
		VALUES(@b_date,@t_number,CONCAT("Table ",TableNumber," is already booked - booking cancelled"));
	ELSE
		COMMIT;
	END IF;
END //
DELIMITER ;

CALL AddValidBooking("2022-12-17", 6);

-- DROP PROCEDURE AddValidBooking;
-- INSERT INTO Bookings(BookingID,BookingDate,TableNumber,CustomerID) VALUES(5,"2022-12-17", 6,5);
SELECT BookingStatus FROM BookingStatus WHERE BookingDate = "2022-12-17" AND TableNumber = 6;


