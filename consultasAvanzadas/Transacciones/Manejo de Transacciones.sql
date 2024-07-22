--Ejercicio 1: 
--Realizar una venta dentro de la base de datos Northwind
--Utilizando transacciones y Store Procedures
create or alter procedure sp_nueevaVenta
      @CustomerID nchar(5),
      @EmployeeID int,
      @OrderDate datetime,
      @RequiredDate datetime,
      @ShippedDate datetime,
      @ShipVia int,
      @Freight money = null,
      @ShipName nvarchar(40) = null,
      @ShipAddress nvarchar(60) = null,
      @ShipCity nvarchar(15) = null,
      @ShipRegion nvarchar(15) = null,
      @ShipPostalCode nvarchar(15) = null,
      @ShipCountry varchar(15),

      @ProductID int,
      @UnitPrice money,
      @Quantity smallint,
      @Discount real
as
	  begin
	  begin transaction
	  
	  begin try
	  --insertar en la tabla orders
	  INSERT INTO [dbo].[Orders]
           ([CustomerID]
           ,[EmployeeID]
           ,[OrderDate]
           ,[RequiredDate]
           ,[ShippedDate]
           ,[ShipVia]
           ,[Freight]
           ,[ShipName]
           ,[ShipAddress]
           ,[ShipCity]
           ,[ShipRegion]
           ,[ShipPostalCode]
           ,[ShipCountry])
 VALUES
           (@CustomerID, 
            @EmployeeID, 
            @OrderDate, 
            @RequiredDate, 
            @ShippedDate, 
            @ShipVia, 
            @Freight, 
            @ShipName, 
            @ShipAddress, 
            @ShipCity, 
            @ShipRegion, 
            @ShipPostalCode, 
            @ShipCountry);

			--obtener el id insertado de la orden
			declare @orderid int
			set @orderid = SCOPE_IDENTITY();

			--insertar en detalle_orden el producto
			--obtener el precio del producto a insertar
			declare @precioVenta money

			--primera forma de realizarlo
			select @precioVenta = UnitPrice from Products
			where ProductID = @ProductID
			--segunda forma 
			--set @precioVenta = (select unitprice from products where productID = 3)
			--insertar en la tabala order details
					INSERT INTO [dbo].[Order Details]
				   ([OrderID]
				   ,[ProductID]
				   ,[UnitPrice]
				   ,[Quantity]
				   ,[Discount])
			 VALUES
				   (
				   @orderid,
				   @ProductID,
				   @UnitPrice,
				   @Quantity,
				   @Discount);
				     --actualizar la tabla productos el campo unitsinstock

		   update Products
		   set UnitsInStock = UnitsInStock - @Quantity
		   where ProductID = @ProductID;
	  Commit transaction
	  end try
	  begin catch
	  rollback transaction;
	  declare @mensajeError varchar(400)
	  set @mensajeError = ERROR_MESSAGE()
	  print @mensajeError;
	  end catch


	��end;
	��

	Select*From Products
	where ProductID=9

	Select max (OrderID)
	from Orders