USE LittleLemonDB;

-- Creating stored procedure
-- Task1
DELIMITER // 

CREATE PROCEDURE GetMaxQuantity()
BEGIN
SELECT MAX(Quantity) as MaxQuantity FROM Orders;
END //

DELIMITER ;
CALL GetMaxQuantity();

-- Task2 Creating prepared statement
PREPARE GetOrderDetail FROM "SELECT OrderID,Quantity,Cost FROM Orders WHERE OrderID = ?"; 
SET @id = '03-132-2890';
Execute GetOrderDetail using @id;

-- Task3
DELIMITER // 

CREATE PROCEDURE CancelOrder(IN order_id VARCHAR(255))
BEGIN
SET @order_id_out = order_id;
DELETE FROM Orders WHERE OrderID = order_id;
INSERT INTO OrderStatus (Confirmation) VALUES (CONCAT("Order ",@order_id_out," is cancelled"));
END //

DELIMITER ;
CALL CancelOrder("00-669-6040");

SELECT * FROM OrderStatus;
SELECT * FROM Orders WHERE OrderID = '00-669-6040';

DROP PROCEDURE CancelOrder;
