CREATE DATABASE IF NOT EXISTS LittleLemonDB;
USE LittleLemonDB;

CREATE TABLE Customers (
    CustomerId INT AUTO_INCREMENT,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    ContactNumber VARCHAR(20),
    Email VARCHAR(100),
    PRIMARY KEY (CustomerId)
);

CREATE TABLE Staff (
    StaffId INT AUTO_INCREMENT,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Role VARCHAR(100) NOT NULL,
    ContactNumber VARCHAR(20),
    Email VARCHAR(100),
    Salary DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (StaffId)
);

CREATE TABLE MenuItems (
    MenuItemId INT AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Type VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (MenuItemId)
);

CREATE TABLE Menus (
	MenuId INT AUTO_INCREMENT,
    MenuItemId INT,
    MenuName VARCHAR(100) NOT NULL,
    Cuisine VARCHAR(100) NOT NULL,
    PRIMARY KEY (MenuId),
    FOREIGN KEY (MenuItemId) REFERENCES MenuItems(MenuItemId)
);

CREATE TABLE Bookings (
    BookingId INT AUTO_INCREMENT,
    CustomerId INT,
    StaffId INT,
    TableNumber INT NOT NULL,
    BookingDate DATE NOT NULL,
    BookingTime TIME NOT NULL,
    PRIMARY KEY (BookingId),
    FOREIGN KEY (CustomerId) REFERENCES Customers(CustomerId),
    FOREIGN KEY (StaffId) REFERENCES Staff(StaffId)
);

CREATE TABLE Orders (
    OrderId INT AUTO_INCREMENT,
    BookingId INT,
    MenuId INT,
    Quantity INT NOT NULL,
    TotalCost DECIMAL(10, 2) NOT NULL,
    OrderDate DATE NOT NULL,
    PRIMARY KEY (OrderId),
    FOREIGN KEY (BookingId) REFERENCES Bookings(BookingId) ON DELETE CASCADE,
    FOREIGN KEY (MenuId) REFERENCES Menus(MenuId)
);

CREATE TABLE OrderDeliveryStatus (
    StatusId INT AUTO_INCREMENT,
    OrderId INT,
    DeliveryDate DATE NOT NULL,
    DeliveryTime TIME NOT NULL,
    Status VARCHAR(100) NOT NULL,
    FOREIGN KEY (OrderId) REFERENCES Orders(OrderId),
    PRIMARY KEY (StatusId)
);

INSERT INTO Customers (FirstName, LastName, ContactNumber, Email)
VALUES 
('John', 'Doe', '123-456-7890', 'john.doe@email.com'),
('Jane', 'Doe', '098-765-4321', 'jane.doe@email.com'),
('Marry', 'Doe', '321-123-7890', 'marry.doe@email.com'),
('Anna', 'Doe', '098-123-1234', 'anna.doe@email.com');

INSERT INTO Staff (FirstName, LastName, Role, ContactNumber, Email, Salary)
VALUES 
('Alice', 'Johnson', 'Manager', '321-654-9870', 'alice.johnson@email.com', 55000.00),
('Bob', 'Smith', 'Chef', '654-987-3210', 'bob.smith@email.com', 45000.00),
('Jack', 'Smith', 'Waiter', '654-987-3211', 'jack.smith@email.com', 40000.00);

