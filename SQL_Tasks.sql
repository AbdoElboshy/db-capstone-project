-- Task 1
CREATE VIEW OrdersView AS
SELECT OrderID, Quantity, TotalCost
FROM orders
WHERE Quantity > 2;

-- Task 2
select customers.CustomerID, customers.Customer_Name,orders.OrderID, orders.TotalCost, menus.MenuName, menuitems.CourseName
from customers inner join orders
on customers.CustomerID = orders.OrderID
inner join menus on orders.Menus_MenuID = menus.MenuID
inner join menuitems on menuitems.MenuItemID = menus.MenuItems_MenuItemID where TotalCost > 150 order by TotalCost asc;

-- Task 3
SELECT MenuName from menus where MenuID=any (select MenuID from orders where Quantity>2);

-- Task 4
DELIMITER //  
create procedure GetMaxQuantity()
select max(quantity) as 'Max Quantity in Order' from orders
DELIMITER;

-- Task 5
PREPARE GetOrderDetail FROM
'select orderID, Quantity, TotalCost from orders where Customers_CustomerID = ?';
SET @id = 1;
EXECUTE GetOrderDetail USING @id;

-- Task 6
DELIMITER //
CREATE PROCEDURE CancelOrder(IN orderId INT)
BEGIN
    DELETE FROM Orders WHERE OrderID = orderId;
END //
DELIMITER ;




