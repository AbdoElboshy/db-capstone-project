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

-- Task 7
insert into Booking(BookingID, Date, TableNumber, Customers_CustomerID)
values
(1, '2022-10-10', 1, 3),
(2, '2022-11-12', 3, 3),
(3, '2022-10-11', 2, 2),
(4, '2022-10-13', 2, 1)

-- Task 8
delimiter //
create procedure CheckBooking(Booking_Date date, table_number int)
begin
	declare bookedTable int default 0;
	select count(bookingID) into bookedTable
    from booking
    where Date = Booking_Date and TableNumber = table_number;
    if bookedTable > 0 then 
    SELECT CONCAT( "Table ", table_number, " is already booked") AS "Booking status";
      ELSE 
      SELECT CONCAT( "Table ", table_number, " is not booked") AS "Booking status";
    END IF;
end //
delimiter ;

-- Task 9
DELIMITER //

CREATE PROCEDURE AddValidBooking(
    IN bookingDate DATE,
    IN tableNumber INT
)
BEGIN
    DECLARE existingBookingCount INT;

    -- Check if the table is already booked
    SELECT COUNT(*) INTO @existingBookingCount
    FROM booking
    WHERE Date = bookingDate AND TableNumber = tableNumber;

      -- Start a transaction
    START TRANSACTION;

    IF @existingBookingCount > 0 THEN
        -- The table is already booked, so rollback the transaction
        ROLLBACK;
		SELECT CONCAT( "Table ", tableNumber, " is already booked - booking cancelled") AS "Booking status";
    ELSE
        -- The table is available, so insert the new booking
        INSERT INTO Booking(Date, TableNumber)
        VALUES (bookingDate, tableNumber);

        -- Commit the transaction
        COMMIT;
    END IF;
END //

DELIMITER ;


-- Task 10
delimiter //
CREATE PROCEDURE AddBooking (IN BookingID INT, IN CustomerID INT, IN TableNumber INT, IN BookingDate DATE)
BEGIN
INSERT INTO booking (bookingid, Customers_CustomerID, tablenumber, date) VALUES (BookingID, CustomerID, TableNumber, BookingDate); 
END
delimiter;

-- Task 11
delimiter //
CREATE PROCEDURE UpdateBooking (IN BookingID INT, IN BookingDate DATE)
BEGIN
UPDATE booking SET date = BookingDate WHERE bookingid = BookingID; 
SELECT CONCAT("Booking ", BookingID, " updated") AS "Confirmation";
END
delimiter;

-- Task 12
delimiter //
CREATE PROCEDURE CancelBooking (IN booking_id int)
begin
delete from booking where BookingID = booking_id;
SELECT CONCAT("Booking ", booking_id, " cancelled") AS "Confirmation";
end;
delimiter;
