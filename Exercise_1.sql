use LittleLemonDB;

-- Week2
-- Task1
CREATE VIEW OrdersView AS SELECT OrderID,Quantity,Cost FROM Orders WHERE Quantity > 2;
SELECT * FROM OrdersView;

-- Task2
SELECT Orders.CustomerID,Customers.CustomerName,Orders.OrderID,Orders.Cost,
MenuItems.StarterName AS MenuName, Menuitems.CourseName 
FROM Orders,Customers,MenuItems
WHERE Orders.Cost > 150
ORDER BY CustomerID
DESC;

-- Task3
SELECT MenuItems.StarterName AS MenuName FROM MenuItems
WHERE EXISTS (SELECT Orders.Quantity FROM Orders WHERE Orders.Quantity > 2); 



