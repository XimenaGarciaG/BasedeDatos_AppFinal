
--Crear base de datos para demostrar el uso de LEFT JOIN
Create DATABASE Prueba_Joins;

--Utilizamos la BD
USE Prueba_Joins;

--Crear tabla categorias

Create table Categorias
(
    categoriaID int not null IDENTITY(1,1),
    nombre VARCHAR(50) not null default 'No categoria',
    CONSTRAINT pk_categoria
primary KEY(categoriaID)
);
--Crear tabla producto
create table producto
(
    productID int not null IDENTITY(1,1),
    nombre varchar (50) not null,
    existencia int not null,
    precio money not null,
    categoriaID int,
    constraint pk_producto
    PRIMARY KEY(productID),
    CONSTRAINT unico_nombre
    UNIQUE (nombre),
    constraint fk_producto_categoria
    foreign key (categoriaID)
    REFERENCES categorias(categoriaID)
);

Insert Into Categorias(nombre)
values ('LB'),
    ('Lacteos'),
    ('Ropa'),
    ('Bebidas'),
    ('CarnesFrias')

--Agregar registros a la tabla producto
Select*from categorias

Insert into producto (nombre,existencia,precio,categoriaID)
values ('Refrigerador',3,1000.0,1),
        ('Estufa',3,900.0,1),
        ('Crema',2,10.5,2),
        ('Yogurt',3,13.45,2)
SELECT*FROM producto

Select*from producto as p
inner join categorias as c
on p.categoriaID = c.categoriaID;

--Consulta utilizando un LEFT JOIN
--Seleccionar todas las categorias que no tienen asignados productos
Select*from categorias as c
LEFT join producto as p
on p.categoriaID = c.categoriaID
where p.productID is not null

--
Select*from Producto as p
RIGHT join categorias as c
on p.categoriaID = c.categoriaID

Select*from Producto as p
LEFT join categorias as c
on p.categoriaID = c.categoriaID

Select*from Producto as p
FULL join categorias as c
on p.categoriaID = c.categoriaID

--EJERCICIO

--Crear una bd llamada Ejercicio_JOINS, crear una tabla llamada Empleados
CREATE DATABASE Ejercicio_JOINS;
use Ejercicio_JOINS;

--tomando como en cuenta la de Northwind no tomar todos
SELECT*FROM Northwind.dbo.Employees; 


Select top 0 EmployeeID as 'EmpleadoID',
CONCAT(FirstName,' ',LastName) as 'NombreCompleto',
Title as 'Titulo',
hiredate as 'FechaContratacion'
into Ejercicio_JOINS.dbo.Empleados
From Northwind.dbo.Employees;



--llenar la tabla con una consulta
insert into Ejercicio_JOINS.dbo.Empleados('NombreCompleto','Titulo','FechaContratacion')
Select 
    CONCAT(FirstName,' ',LastName) as 'NombreCompleto',
    Title as 'Titulo',
    hiredate as 'FechaContratacion'
from Northwind.dbo.employees;

select top 0*
into Ejercicio_JOINS.dbo.Dimempleados
from Ejercicio_JOINS.dbo.Empleados

--Agregar nuevos datos a la tabla empleados 2
--Actualizar los datos con los nuevos registros, los cuales se llenaran en una tabla llamada dis_Product







