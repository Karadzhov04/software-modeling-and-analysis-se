CREATE TABLE [User] (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Password NVARCHAR(255) NOT NULL,
    Gender NVARCHAR(10) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Role NVARCHAR(50) NOT NULL
)

CREATE TABLE Restaurant (
    Id INT PRIMARY KEY IDENTITY(1,1),
    UserId INT NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    ImageUrl NVARCHAR(255),
    Description NVARCHAR(MAX),
    IsOpen BIT DEFAULT 1,
    FOREIGN KEY (UserId) REFERENCES [User](Id)
)

CREATE TABLE Food (
    Id INT PRIMARY KEY IDENTITY(1,1),
    RestaurantId INT NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Description NVARCHAR(MAX),
    Calories INT,
    CreatedOn DATETIME DEFAULT GETDATE(),
    ImageUrl NVARCHAR(255),
    FOREIGN KEY (RestaurantId) REFERENCES Restaurant(Id)
)

CREATE TABLE [Order] (
    Id INT PRIMARY KEY IDENTITY(1,1),
    UserId INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalPrice DECIMAL(10,2) NOT NULL,
    Address NVARCHAR(255) NOT NULL,
    Delivery BIT DEFAULT 1,
    FOREIGN KEY (UserId) REFERENCES [User](Id)
)

CREATE TABLE Payment (
    Id INT PRIMARY KEY IDENTITY(1,1),
    OrderId INT NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod NVARCHAR(50) NOT NULL,
    PaymentDate DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(20) NOT NULL,
    FOREIGN KEY (OrderId) REFERENCES [Order](Id)
)

CREATE TABLE OrderFood (
    OrderId INT NOT NULL,
    FoodId INT NOT NULL,
    Quantity INT NOT NULL,
    PriceAtTime DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (OrderId, FoodId),
    FOREIGN KEY (OrderId) REFERENCES [Order](Id),
    FOREIGN KEY (FoodId) REFERENCES Food(Id)
);

-- Потребители
INSERT INTO [User] (Name, Email, Password, Gender, DateOfBirth, Role)
VALUES 
('Иван Петров', 'ivan@clickeat.com', 'pass123', 'Male', '1995-05-12', 'Customer'),
('Мария Георгиева', 'maria@clickeat.com', 'pass456', 'Female', '1990-03-20', 'Owner'),
('Георги Димитров', 'georgi@clickeat.com', 'pass789', 'Male', '1988-07-15', 'Customer');

-- Ресторанти
INSERT INTO Restaurant (UserId, Name, ImageUrl, Description, IsOpen)
VALUES 
(2, 'Pizza Palace', NULL, 'Най-добрата пица в града', 1),
(2, 'Burger House', NULL, 'Сочни бургери и пържени картофи', 1);

-- Храни
INSERT INTO Food (RestaurantId, Name, Price, Description, Calories, ImageUrl)
VALUES 
(1, 'Маргарита', 8.50, 'Класическа пица с домати и моцарела', 700, NULL),
(1, 'Пеперони', 9.50, 'Пица с пикантно пеперони', 850, NULL),
(2, 'Чийзбургер', 6.00, 'Бургер с кашкавал и сос', 600, NULL),
(2, 'Двоен бургер', 8.00, 'Голям бургер с двойно месо', 900, NULL);

-- Поръчки
INSERT INTO [Order] (UserId, OrderDate, TotalPrice, Address, Delivery)
VALUES 
(1, GETDATE(), 0, 'ул. Софийска 10', 1),
(3, GETDATE(), 0, 'бул. Витоша 25', 1);

-- OrderFood
INSERT INTO OrderFood (OrderId, FoodId, Quantity, PriceAtTime)
VALUES 
(1, 1, 2, 8.50),
(1, 2, 1, 9.50),
(2, 3, 3, 6.00),
(2, 4, 1, 8.00);

-- Плащания
INSERT INTO Payment (OrderId, Amount, PaymentMethod, PaymentDate, Status)
VALUES 
(1, 26.50, 'Credit Card', GETDATE(), 'Completed'),
(2, 26.00, 'Cash', GETDATE(), 'Pending');

-- Потребители
INSERT INTO [User] (Name, Email, Password, Gender, DateOfBirth, Role)
VALUES 
('Николай Колев', 'nikolay@clickeat.com', 'pass321', 'Male', '1992-11-05', 'Customer'),
('Елена Тодорова', 'elena@clickeat.com', 'pass654', 'Female', '1985-06-18', 'Customer'),
('Даниела Иванова', 'daniela@clickeat.com', 'pass987', 'Female', '1998-02-22', 'Owner');

-- Ресторанти
INSERT INTO Restaurant (UserId, Name, ImageUrl, Description, IsOpen)
VALUES 
(6, 'Sushi World', NULL, 'Свежи суши и японски специалитети', 1),
(6, 'Healthy Bites', NULL, 'Здравословна храна и смутита', 1);

-- Храни
INSERT INTO Food (RestaurantId, Name, Price, Description, Calories, ImageUrl)
VALUES 
(3, 'Суши сет Класик', 12.00, 'Микс от нигири и маки', 500, NULL),
(3, 'Мисо супа', 4.50, 'Традиционна японска супа', 120, NULL),
(4, 'Зелено смути', 5.00, 'Смути с спанак, ябълка и джинджифил', 180, NULL),
(4, 'Киноа салата', 7.50, 'Салата с киноа, авокадо и чери домати', 350, NULL);

-- Поръчки
INSERT INTO [Order] (UserId, OrderDate, TotalPrice, Address, Delivery)
VALUES 
(4, GETDATE(), 0, 'ул. Пирин 12', 1),
(5, GETDATE(), 0, 'бул. България 88', 1);

-- OrderFood
INSERT INTO OrderFood (OrderId, FoodId, Quantity, PriceAtTime)
VALUES 
(3, 5, 1, 12.00),
(3, 6, 2, 4.50),
(4, 7, 1, 5.00),
(4, 8, 1, 7.50);

-- Плащания
INSERT INTO Payment (OrderId, Amount, PaymentMethod, PaymentDate, Status)
VALUES 
(3, 21.00, 'PayPal', GETDATE(), 'Completed'),
(4, 12.50, 'Cash', GETDATE(), 'Pending');


