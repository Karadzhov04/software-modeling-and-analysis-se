-- Връща всички поръчки на даден потребител с ресторант и храни
CREATE PROCEDURE GetUserOrders
    @UserId INT
AS
BEGIN
    SELECT o.Id AS OrderId,
           o.OrderDate,
           r.Name AS RestaurantName,
           f.Name AS FoodName,
           ofd.Quantity,
           ofd.PriceAtTime
    FROM [Order] o
    JOIN OrderFood ofd ON o.Id = ofd.OrderId
    JOIN Food f ON ofd.FoodId = f.Id
    JOIN Restaurant r ON f.RestaurantId = r.Id
    WHERE o.UserId = @UserId
    ORDER BY o.OrderDate DESC;
END;

-- Връща броя на храните в даден ресторант
CREATE FUNCTION GetFoodCount(@RestaurantId INT)
RETURNS INT
AS
BEGIN
    DECLARE @Count INT;
    SELECT @Count = COUNT(*) FROM Food WHERE RestaurantId = @RestaurantId;
    RETURN @Count;
END;

CREATE TRIGGER trg_DefaultPaymentDate
ON Payment
AFTER INSERT
AS
BEGIN
    UPDATE p
    SET PaymentDate = GETDATE()
    FROM Payment p
    INNER JOIN inserted i ON p.Id = i.Id
    WHERE i.PaymentDate IS NULL;
END;


