select * from orders;
select * from menuitems;

-- Create virtual table
CREATE VIEW OrdersView AS SELECT OrderID,Quantity,BillAmount
FROM orders 
WHERE Quantity > 1;

SELECT * FROM OrdersView;

