--Crear un store procedure que calcule el area de un circulo


create or alter Procedure SP_Calcular_Area_Circulo
@radio float, --parametro entrada
@area float output --parametro salida
as
begin
	set @area = PI() * @radio * @radio
end;

go

Declare @resultado float
exec SP_Calcular_Area_Circulo @radio=22.3, @area=@resultado output

print 'El valor del area es: '+cast(@resultado as varchar)
go


--Crerar un store procedure que imprima a los empleados
CREATE OR ALTER PROCEDURE SP_Obtener_Informacion_Empleado
@employeeID int=-1,
@lastName varchar(20) output,
@nombre varchar(10) output
AS
BEGIN
	IF @employeeID <> -1
	BEGIN
		SELECT @nombre=FirstName,@lastName=LastName 
		FROM Employees
		where EmployeeID=@employeeID
	END
	ELSE
	BEGIN
		PRINT('El valor del empleado no es valido')
	END
END



DECLARE @firstname as nvarchar(10),
@lastname nvarchar(20)

exec SP_Obtener_Informacion_Empleado @employeeID=1,
@nombre=@firstname output, @lastName=@lastname output

Print('El nombre es: '+@firstname)
Print('El apellido es: '+@lastname)
---------------------------------------------------------------------------
--Verificar si el empleado existe

create or alter proc sp_obtener_informacion_empleado2
@employeeid int = -1,
@apellido nvarchar(20) output,
@nombre as nvarchar(10) output
AS
begin

   DECLARE @existe int
   set @existe=(select count(*) from Employees where EmployeeID =@employeeid)
   -- select @existe = count(*) from Employees where EmployeeID =@employeeid
   

   IF @existe > 0
   begin
    Select @nombre = FirstName, @apellido=lastname
    from Employees
    where EmployeeID = @employeeid
   end
   else
   begin
   if @existe = 0
   begin
      print 'El id del empleado no existe'
   end
  end
end

-------------------------------------------------------------

declare @firstname as nvarchar(10),
@lastname nvarchar(20)

exec sp_obtener_informacion_empleado2
@nombre=@firstname output, @apellido = @lastname output

print ('El nombre es: ' + @firstname)
print ('El apellido es: ' + @lastname)


Select SUM(od.UnitPrice * od.Quantity) as total
from [Order Details] as od
inner join Orders as o
on o.OrderID = od.OrderID
where CustomerID='ALFKI' and
O.OrderDate BETWEEN '1997-07-04' and '1997-12-31';


SELECT*FROM Orders

--Realizar un store procedure que guarde en una variable de salida el total 
--de compras que ah realizado un cliente dado en un rango de fechas
CREATE OR ALTER PROC SP_Obtener_VentasPorCliente
@customerID nchar(5),
@fechainicial date,
@fechafinal date,
@total decimal(10,2)OUTPUT
AS 
BEGIN
Select SUM(od.UnitPrice * od.Quantity) as total
from [Order Details] as od
inner join Orders as o
on o.OrderID = od.OrderID
where CustomerID=@customerID and
O.OrderDate BETWEEN @fechainicial and @fechafinal
END