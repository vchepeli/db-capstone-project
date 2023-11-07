USE LittleLemondb;
-- MaxQuantity
DROP PROCEDURE IF EXISTS MaxQuantity;
DELIMITER //
CREATE PROCEDURE MaxQuantity()
BEGIN
	SELECT MAX(Quantity) AS MaxQuantity
	FROM Orders;
END//
DELIMITER ;

-- CancelOrder
DROP PROCEDURE IF EXISTS CancelOrder;
DELIMITER //
CREATE PROCEDURE CancelOrder(orderId INT)
BEGIN
	DELETE
	FROM Orders
	WHERE OrderID = orderId;

	SELECT CONCAT('Order ', orderId, ' cancelled') AS Status;
END//
DELIMITER ;

-- ManageBooking
DROP PROCEDURE IF EXISTS ManageBooking;

DELIMITER //
CREATE PROCEDURE ManageBooking(IN bookDate DATE, IN bookTime TIME, IN tableNo INT, IN custId INT)
BEGIN
  DECLARE status VARCHAR(100);

  START TRANSACTION;

  -- Check if the booking already exists
  IF NOT EXISTS (SELECT * FROM Bookings WHERE BookingDate = bookDate AND BookTime = bookTime AND TableNumber = tableNo) THEN
    -- If not exists, then insert the new booking
    INSERT INTO Bookings(BookingDate, BookingTime, TableNumber, CustomerId)
    VALUES (bookDate, bookTime, tableNo, custId);
    
    SET status = CONCAT('Table ', tableNo, ' is successfully booked.');
    
    COMMIT;
  ELSE
    -- If exists, then set the status to booked
    SET status = CONCAT('Table ', tableNo, ' is already booked - booking cancelled.');
    
    ROLLBACK;
  END IF;
  
  SELECT status AS Status;
END //
DELIMITER ;


CALL ManageBooking('2023-11-01', '22:30', 2, 1);

-- AddBooking
DROP PROCEDURE IF EXISTS AddBooking;
DELIMITER //
CREATE PROCEDURE AddBooking(IN customerId INT, IN bookDate DATE, IN bookTime TIME, IN tableNo INT)
BEGIN
	INSERT INTO bookings(BookingDate, BookingTime, TableNumber, CustomerId)
	VALUES (bookDate, bookTime, tableNo, customerId);

	SELECT 'Booking Added' AS Status;
END//
DELIMITER ;

CALL AddBooking(1, '2023-11-01', '22:30', 3);

-- UpdateBooking
DROP PROCEDURE IF EXISTS UpdateBooking;
DELIMITER //
CREATE PROCEDURE UpdateBooking(IN bookId INT, IN bookDate DATE, IN bookTime TIME)
BEGIN
	UPDATE bookings
	SET BookingDate = bookDate, BookingTime = bookTime
	WHERE BookingId = bookId;
	SELECT CONCAT('Booking ', bookId, ' Updated') AS Status;
END//
DELIMITER ;

CALL UpdateBooking(1, '2023-11-01', '18:30');

-- CancelBooking
DROP PROCEDURE IF EXISTS CancelBooking;
DELIMITER //
CREATE PROCEDURE CancelBooking(IN bookId INT)
BEGIN
	DELETE
	FROM bookings
	WHERE BookingId = bookId;

	SELECT CONCAT('Booking ', bookId, ' Cancelled') AS Status;
END//
DELIMITER ;

CALL CancelBooking(1);