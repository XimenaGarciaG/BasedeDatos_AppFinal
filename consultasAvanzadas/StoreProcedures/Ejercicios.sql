CREATE PROCEDURE Ejercicio_Ventas
@Año INT
AS BEGIN
SELECT o.OrderDate as 'Fecha de Orden',
c.CompanyName AS 'Nombre Cliente',
YEAR(o.OrderDate) as 'Año',
SUM(od.Quantity * od.UnitPrice) AS 'Total Vendido'
FROM 
Orders as o
inner JOIN [Order Details] od 
ON o.OrderID = od.OrderID
inner JOIN Customers as c 
ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) = @Año
Order  by c.CompanyName, o.OrderDate
END;

EXEC Ejercicio_Ventas @Año = 1997;





select*from Customers;
select*from Orders;