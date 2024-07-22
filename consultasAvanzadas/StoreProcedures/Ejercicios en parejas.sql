
---------------------------Ejercicio 1)-------------------------------
CREATE TABLE PriceHistory (
    HistoryID INT IDENTITY(1,1) PRIMARY KEY,
    ProductoID INT NOT NULL,
    PrecioAnt MONEY NOT NULL,
    PrecioNuevo MONEY NOT NULL,
    ChangeDate DATE NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (ProductoID) REFERENCES Products(ProductID)
);

select*from PriceHistory 
select * from [Order Details]
select * from Products



CREATE OR ALTER PROC Ejercicio_1

    @ProductoID INT,
    @PrecioNuevo MONEY
AS
BEGIN
   
    BEGIN TRANSACTION;


    DECLARE @PrecioAnt MONEY;

	SELECT @PrecioAnt = UnitPrice
    FROM Products
    WHERE ProductID = @ProductoID;

    IF @PrecioAnt IS NOT NULL
    BEGIN

        UPDATE Products
        SET UnitPrice = @PrecioNuevo
        WHERE ProductID = @ProductoID;

        INSERT INTO PriceHistory (ProductoID, PrecioAnt, PrecioNuevo, ChangeDate)
        VALUES (@ProductoID, @PrecioAnt, @PrecioNuevo, GETDATE());

       
        COMMIT TRANSACTION;
    END
    ELSE
    BEGIN
       
        ROLLBACK TRANSACTION;
    END
END;

exec Ejercicio_1 @ProductoID=1, @PrecioNuevo=25.00;
Select*from PriceHistory;


---------------------------Ejercicio 2)-------------------------------
CREATE OR ALTER PROCEDURE Echo
    @OrderID int
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
 
       UPDATE Pro
        SET Pro.UnitsInStock = Pro.UnitsInStock + ord.Quantity
        FROM Products as Pro
        INNER JOIN [Order Details] as ord ON Pro.ProductID = ord.ProductID
        WHERE ord.OrderID = @OrderID;
       
        DELETE FROM [Order Details]
        WHERE OrderID = @OrderID;


        DELETE FROM Orders
        WHERE OrderID = @OrderID;

        COMMIT TRANSACTION;

	  END TRY
		  BEGIN CATCH
			  ROLLBACK TRANSACTION;
			  DECLARE @ErrorMessage NVARCHAR(100);
			  SET @ErrorMessage = ERROR_MESSAGE();
			  PRINT @ErrorMessage;
		  END CATCH;
END

exec Echo @OrderID = 10249
