USE LittleLemonDB;

CREATE TABLE IF NOT EXISTS BookingConfirm (
ID INT PRIMARY KEY auto_increment,
BookingDate DATE,
TableNumber INT,
Confirmation VARCHAR(255));

-- DROP TABLE BookingConfirm;

-- Creating trigger to add a confirmation status to BookingConfirm table for INSERT, UPDATE and DELETE event.
CREATE TRIGGER AddBookingConfirm
	AFTER INSERT 
    ON Bookings FOR EACH ROW
	INSERT INTO BookingConfirm(BookingDate,TableNumber,Confirmation) 
    VALUES(NEW.BookingDate,NEW.TableNumber,"New booking added");  

-- DROP TRIGGER IF EXISTS AddBookingConfirm;

CREATE TRIGGER UpdateBookingConfirm
	AFTER UPDATE 
    ON Bookings FOR EACH ROW
	INSERT INTO BookingConfirm(BookingDate,TableNumber,Confirmation) 
    VALUES(NEW.BookingDate,OLD.TableNumber,CONCAT("Booking ",OLD.BookingID," updated"));  

-- DROP TRIGGER IF EXISTS UpdateBookingConfirm;

CREATE TRIGGER DeleteBookingConfirm
	AFTER DELETE 
    ON Bookings FOR EACH ROW
	INSERT INTO BookingConfirm(BookingDate,TableNumber,Confirmation) 
    VALUES(OLD.BookingDate,OLD.TableNumber,CONCAT("Booking ",OLD.BookingID," cancelled"));  

-- DROP TRIGGER IF EXISTS DeleteBookingConfirm;


-- Task1
DELIMITER // 

CREATE PROCEDURE AddBooking(IN bookingID INT, IN customerID INT, IN table_number INT, IN booking_date DATE)
BEGIN
	SET @b_date = booking_date;
    SET @t_number = table_number;
    SET @c_id = customerID;
    SET @b_id = bookingID;
    INSERT INTO Bookings(BookingID,BookingDate,TableNumber,CustomerID) 
		VALUES(@b_id ,@b_date, @t_number, @c_id);
END //
DELIMITER ;

CALL AddBooking(6,4,9,"2022-12-30");

-- DROP PROCEDURE AddValidBooking;

-- Task2
DELIMITER // 
CREATE PROCEDURE UpdateBooking(IN bookingID INT, IN booking_date DATE)
BEGIN
DECLARE b_id INT;
SET @b_date = booking_date;
SELECT bookingID INTO b_id;
UPDATE Bookings SET BookingDate = @b_date WHERE BookingID = b_id;
END //
DELIMITER ;

CALL UpdateBooking(6,"2022-12-20");

-- DROP PROCEDURE UpdateBooking;

-- Task3
DELIMITER // 
CREATE PROCEDURE CancelBooking(IN bookingID INT)
BEGIN
    SET @b_id = bookingID;
    DELETE FROM Bookings WHERE BookingID = @b_id;
END //
DELIMITER ;

CALL CancelBooking(6);

-- DROP PROCEDURE CancelBooking;


-- select Confirmation from BookingConfirm WHERE ID = 25;
-- select * from BookingConfirm;
-- delete from BookingConfirm;
-- select * from Bookings;