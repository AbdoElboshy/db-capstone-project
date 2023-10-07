-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


-- -----------------------------------------------------
-- Schema LittleeLmonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleeLmonDB` DEFAULT CHARACTER SET utf8mb3 ;
USE `LittleeLmonDB` ;

-- -----------------------------------------------------
-- Table `LittleeLmonDB`.`staff_information`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleeLmonDB`.`staff_information` (
  `StaffID` INT NOT NULL AUTO_INCREMENT,
  `FullName` VARCHAR(45) NULL DEFAULT NULL,
  `E-mail` VARCHAR(45) NULL DEFAULT NULL,
  `ContactNumber` INT NULL DEFAULT NULL,
  `Role` VARCHAR(45) NULL DEFAULT NULL,
  `Salary` INT NULL DEFAULT NULL,
  PRIMARY KEY (`StaffID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `LittleeLmonDB`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleeLmonDB`.`customers` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `Customer_Name` VARCHAR(45) NULL DEFAULT NULL,
  `Contact_Number` INT NULL DEFAULT NULL,
  `Staff_information_StaffID` INT NULL DEFAULT NULL,
  `Email` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`CustomerID`),
  INDEX `fk_Customes_Staff_information1_idx` (`Staff_information_StaffID` ASC) VISIBLE,
  CONSTRAINT `fk_Customes_Staff_information1`
    FOREIGN KEY (`Staff_information_StaffID`)
    REFERENCES `LittleeLmonDB`.`staff_information` (`StaffID`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `LittleeLmonDB`.`booking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleeLmonDB`.`booking` (
  `BookingID` INT NOT NULL AUTO_INCREMENT,
  `Date` DATE NULL DEFAULT NULL,
  `TableNumber` INT NULL DEFAULT NULL,
  `Customers_CustomerID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `fk_Booking_Customers1_idx` (`Customers_CustomerID` ASC) VISIBLE,
  CONSTRAINT `fk_Booking_Customers1`
    FOREIGN KEY (`Customers_CustomerID`)
    REFERENCES `LittleeLmonDB`.`customers` (`CustomerID`))
ENGINE = InnoDB
AUTO_INCREMENT = 22
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `LittleeLmonDB`.`delivery_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleeLmonDB`.`delivery_status` (
  `DeliveryID` INT NOT NULL AUTO_INCREMENT,
  `DeliveryDate` DATE NULL DEFAULT NULL,
  `Status` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`DeliveryID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `LittleeLmonDB`.`menuitems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleeLmonDB`.`menuitems` (
  `MenuItemID` INT NOT NULL AUTO_INCREMENT,
  `CourseName` VARCHAR(45) NULL DEFAULT NULL,
  `StarterName` VARCHAR(45) NULL DEFAULT NULL,
  `DesertName` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`MenuItemID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `LittleeLmonDB`.`menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleeLmonDB`.`menus` (
  `MenuID` INT NOT NULL AUTO_INCREMENT,
  `Cuisines` VARCHAR(45) NULL DEFAULT NULL,
  `MenuName` VARCHAR(45) NULL DEFAULT NULL,
  `MenuItems_MenuItemID` INT NOT NULL,
  PRIMARY KEY (`MenuID`),
  INDEX `fk_Menus_MenuItems1_idx` (`MenuItems_MenuItemID` ASC) VISIBLE,
  CONSTRAINT `fk_Menus_MenuItems1`
    FOREIGN KEY (`MenuItems_MenuItemID`)
    REFERENCES `LittleeLmonDB`.`menuitems` (`MenuItemID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `LittleeLmonDB`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleeLmonDB`.`orders` (
  `OrderID` INT NOT NULL AUTO_INCREMENT,
  `OrderDate` DATE NULL DEFAULT NULL,
  `Quantity` INT NULL DEFAULT NULL,
  `TotalCost` DECIMAL(10,0) NULL DEFAULT NULL,
  `Customers_CustomerID` INT NOT NULL,
  `Menus_MenuID` INT NOT NULL,
  `Delivery_Status_DeliveryID` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `fk_Orders_Customers1_idx` (`Customers_CustomerID` ASC) VISIBLE,
  INDEX `fk_Orders_Menus1_idx` (`Menus_MenuID` ASC) VISIBLE,
  INDEX `fk_Orders_Delivery_Status1_idx` (`Delivery_Status_DeliveryID` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Customers1`
    FOREIGN KEY (`Customers_CustomerID`)
    REFERENCES `LittleeLmonDB`.`customers` (`CustomerID`),
  CONSTRAINT `fk_Orders_Delivery_Status1`
    FOREIGN KEY (`Delivery_Status_DeliveryID`)
    REFERENCES `LittleeLmonDB`.`delivery_status` (`DeliveryID`),
  CONSTRAINT `fk_Orders_Menus1`
    FOREIGN KEY (`Menus_MenuID`)
    REFERENCES `LittleeLmonDB`.`menus` (`MenuID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

USE `LittleeLmonDB` ;

-- -----------------------------------------------------
-- Placeholder table for view `LittleeLmonDB`.`ordersview`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleeLmonDB`.`ordersview` (`OrderID` INT, `Quantity` INT, `TotalCost` INT);

-- -----------------------------------------------------
-- procedure AddBooking
-- -----------------------------------------------------

DELIMITER $$
USE `LittleeLmonDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddBooking`(IN BookingID INT, IN CustomerID INT, IN TableNumber INT, IN BookingDate DATE)
BEGIN
INSERT INTO booking (bookingid, Customers_CustomerID, tablenumber, date) VALUES (BookingID, CustomerID, TableNumber, BookingDate); 
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddValidBooking
-- -----------------------------------------------------

DELIMITER $$
USE `LittleeLmonDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddValidBooking`(
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
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CancelBooking
-- -----------------------------------------------------

DELIMITER $$
USE `LittleeLmonDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CancelBooking`(IN booking_id int)
begin
delete from booking where BookingID = booking_id;
SELECT CONCAT("Booking ", booking_id, " cancelled") AS "Confirmation";
end$$

DELIMITER;

-- -----------------------------------------------------
-- procedure CancelOrder
-- -----------------------------------------------------

DELIMITER $$
USE `LittleeLmonDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CancelOrder`(IN orderId INT)
BEGIN
    DELETE FROM Orders WHERE OrderID = orderId;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure GetMaxQuantity
-- -----------------------------------------------------

DELIMITER $$
USE `LittleeLmonDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetMaxQuantity`()
BEGIN
select max(quantity) as 'Max Quantity in Order' from orders;
END$$
DELIMITER ;

-- -----------------------------------------------------
-- procedure CheckBooking
-- -----------------------------------------------------

DELIMITER $$
USE `LittleeLmonDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CheckBooking`(Booking_Date date, table_number int)
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
end$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure UpdateBooking
-- -----------------------------------------------------

DELIMITER $$
USE `LittleeLmonDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateBooking`(IN BookingID INT, IN BookingDate DATE)
BEGIN
UPDATE booking SET date = BookingDate WHERE bookingid = BookingID; 
SELECT CONCAT("Booking", BookingID, "updated") AS "Confirmation";
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `LittleeLmonDB`.`ordersview`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleeLmonDB`.`ordersview`;
USE `LittleeLmonDB`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `LittleeLmonDB`.`ordersview` AS select `LittleeLmonDB`.`orders`.`OrderID` AS `OrderID`,`LittleeLmonDB`.`orders`.`Quantity` AS `Quantity`,`LittleeLmonDB`.`orders`.`TotalCost` AS `TotalCost` from `LittleeLmonDB`.`orders` where (`LittleeLmonDB`.`orders`.`Quantity` > 2);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
