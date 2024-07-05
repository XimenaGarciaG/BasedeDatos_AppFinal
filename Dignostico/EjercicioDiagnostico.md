# Requerimientos
Una empresa encargada de las ventas de diferentes productos desea crear una base de datos que controles los proveedores, clientes, empleados, categorías de producto y órdenes de compra. Para los proveedores se necesita almacenar un numero de control, nombre de la empresa, dirección (numero, calle, colonia, estado), cp,teléfono, página web, teléfono de contacto o contactos del proveedor, nombre del contacto, email del contacto. Para los empleados se desea almacenar un numero de nómina, nombre completo del empleado, rfc, curp, salario (El salario máximo es de 65000), para las ordenes de compra se necesita almacenar la fecha de creación de la orden, el empleado que la realizo, al cliente que se le vende, la fecha de entrega y los diferentes productos que contiene. El producto debe almacenar un numero de control y una descripción única, status, existencia y un precio. La categoría debe tener un identificador y nombre único de categoría. La compra siempre debe tener un precio de venta que se obtiene del precio unitario del producto y una cantidad vendida.
# Diagrama E-R
![Diagrama Entidad-Relacion](./IMG/DiagramaEntidadRelacion)

# Diagrama Relacional
![Diagrama Relacional](./IMG/Diagrama_Relacional)

# Creacion de BD con lenguaje SQL-LDD
```sql
CREATE TABLE CLIENTEE(
Cliente_ID int not null identity(1,1),
rfc varchar(20) not null,
curp varchar(18)not null,
nombres varchar(50)not null,
apellido_1 varchar(50)not null,
apellido_2 varchar(50)not null,
constraint pk_cliente
primary key (Cliente_ID),
constraint unico_rfc
unique(rfc),
constraint unico_curp
unique(curp)
);

CREATE TABLE ContactoProveedor(
Contacto_ID int not null identity(1,1),
Proveedor_ID int not null,
nombres varchar(50)not null,
apellido_1 varchar(50)not null,
apellido_2 varchar(50)not null,
constraint pk_contacto
primary key (Contacto_ID),
);

alter TABLE ContactoProveedor
add constraint fk_Proveedor_ContactoP
foreign key (Proveedor_ID)
REFERENCES Proveedor (Proveedor_ID)

CREATE TABLE Proveedor(
Proveedor_ID int not null identity(1,1),
nombreEmpresa varchar(50)not null,
rfc varchar(20) not null,
calle varchar(30) not null,
colonia varchar(30) not null,
cp varchar(10)not null,
paginaWeb varchar(80),
constraint pk_proveedor
primary key (Proveedor_ID),
constraint unico_empresa
unique(nombreEmpresa),
constraint unico_rfc2
unique(rfc),
);

CREATE TABLE EMPLEADO(
Empleado_ID int not null identity(1,1),
nombres varchar(50)not null,
apellido_1 varchar(50)not null,
apellido_2 varchar(50)not null,
rfc varchar(20) not null,
curp varchar(18)not null,
numExterno int,
calle varchar(50),
salario money not null,
numNomina int not null,
constraint pk_empleado
primary key (Empleado_ID),
constraint unico_rfc_Empleado
unique (rfc),
constraint unico_Curp_Empleado
unique (curp),
constraint chk_salario
check (salario>=0.0 and salario<=100000),
--Donde el (salario BETWEN entre 0.0 and 100000)--
constraint unico_nomina_empleado
unique (numNomina)
);

CREATE TABLE TelefonoProveedor(
Telefono_ID int not null identity(1,1),
NoTelefono varchar(30)not null,
Proveedor_ID int not null,
constraint pk_telefono_proveedor
primary key (Telefono_ID,Proveedor_ID),
constraint fk_telProveedor_Proveedor
foreign key (Proveedor_ID)
REFERENCES Proveedor (Proveedor_ID)
on delete cascade
on update cascade
);

CREATE TABLE PRODUCTO(
Num_Control int not null identity(1,1),
descripcion varchar(50)not null,
precio money not null,
[status] int not null,
existencia int not null,
Proveedor_ID int not null,
constraint pk_producto_NumControl
primary key (Num_Control),
constraint unico_descripcion
unique(descripcion),
constraint chk_precio
--precio>=1 y precio<=20000--
check (precio between 1 and 20000),
constraint chk_status
--status en (0,1)--
check([status]=1 or [status]=0),
constraint chk_existencia
check(existencia>0),
constraint fk_Producto_Proveedor
foreign key (Proveedor_ID)
REFERENCES Proveedor (Proveedor_ID)
);
CREATE TABLE ORDEN_COMPRA(
num_Orden int not null identity (1,1),
fecha_orden date not null, 
fecha_entrega date not null,
Cliente_ID int not null,
Empleado_ID int not null,
constraint pk_OrdenCompra
primary key(num_Orden),
constraint fk_OrdenCompra_Cliente
foreign key (Cliente_ID)
references CLIENTEE (Cliente_ID),
constraint fk_OrdenComora_Empleado
foreign key (Empleado_ID)
references EMPLEADO(Empleado_ID)
);

CREATE TABLE Detalle_Compra(
Producto_ID int not null,
num_Orden int not null,
cantidad int not null,
precioCompra money not null
constraint pk_DetalleCompra
primary key(Producto_ID, num_Orden),
constraint fk_OrdenCompra_Producto
foreign key (Producto_ID)
References PRODUCTO(Num_Control),
constraint fk_OrdenCompra_Compra
foreign key (num_Orden)
references ORDEN_COMPRA (num_Orden)
);

CREATE TABLE CLIENTEE(
Cliente_ID int not null identity(1,1),
rfc varchar(20) not null,
curp varchar(18)not null,
nombres varchar(50)not null,
apellido_1 varchar(50)not null,
apellido_2 varchar(50)not null,
constraint pk_cliente
primary key (Cliente_ID),
constraint unico_rfc
unique(rfc),
constraint unico_curp
unique(curp)
);

CREATE TABLE ContactoProveedor(
Contacto_ID int not null identity(1,1),
Proveedor_ID int not null,
nombres varchar(50)not null,
apellido_1 varchar(50)not null,
apellido_2 varchar(50)not null,
constraint pk_contacto
primary key (Contacto_ID),
);

alter TABLE ContactoProveedor
add constraint fk_Proveedor_ContactoP
foreign key (Proveedor_ID)
REFERENCES Proveedor (Proveedor_ID)

CREATE TABLE Proveedor(
Proveedor_ID int not null identity(1,1),
nombreEmpresa varchar(50)not null,
rfc varchar(20) not null,
calle varchar(30) not null,
colonia varchar(30) not null,
cp varchar(10)not null,
paginaWeb varchar(80),
constraint pk_proveedor
primary key (Proveedor_ID),
constraint unico_empresa
unique(nombreEmpresa),
constraint unico_rfc2
unique(rfc),
);

CREATE TABLE EMPLEADO(
Empleado_ID int not null identity(1,1),
nombres varchar(50)not null,
apellido_1 varchar(50)not null,
apellido_2 varchar(50)not null,
rfc varchar(20) not null,
curp varchar(18)not null,
numExterno int,
calle varchar(50),
salario money not null,
numNomina int not null,
constraint pk_empleado
primary key (Empleado_ID),
constraint unico_rfc_Empleado
unique (rfc),
constraint unico_Curp_Empleado
unique (curp),
constraint chk_salario
check (salario>=0.0 and salario<=100000),
--Donde el (salario BETWEN entre 0.0 and 100000)--
constraint unico_nomina_empleado
unique (numNomina)
);

CREATE TABLE TelefonoProveedor(
Telefono_ID int not null identity(1,1),
NoTelefono varchar(30)not null,
Proveedor_ID int not null,
constraint pk_telefono_proveedor
primary key (Telefono_ID,Proveedor_ID),
constraint fk_telProveedor_Proveedor
foreign key (Proveedor_ID)
REFERENCES Proveedor (Proveedor_ID)
on delete cascade
on update cascade
);

CREATE TABLE PRODUCTO(
Num_Control int not null identity(1,1),
descripcion varchar(50)not null,
precio money not null,
[status] int not null,
existencia int not null,
Proveedor_ID int not null,
constraint pk_producto_NumControl
primary key (Num_Control),
constraint unico_descripcion
unique(descripcion),
constraint chk_precio
--precio>=1 y precio<=20000--
check (precio between 1 and 20000),
constraint chk_status
--status en (0,1)--
check([status]=1 or [status]=0),
constraint chk_existencia
check(existencia>0),
constraint fk_Producto_Proveedor
foreign key (Proveedor_ID)
REFERENCES Proveedor (Proveedor_ID)
);
CREATE TABLE ORDEN_COMPRA(
num_Orden int not null identity (1,1),
fecha_orden date not null, 
fecha_entrega date not null,
Cliente_ID int not null,
Empleado_ID int not null,
constraint pk_OrdenCompra
primary key(num_Orden),
constraint fk_OrdenCompra_Cliente
foreign key (Cliente_ID)
references CLIENTEE (Cliente_ID),
constraint fk_OrdenComora_Empleado
foreign key (Empleado_ID)
references EMPLEADO(Empleado_ID)
);

CREATE TABLE Detalle_Compra(
Producto_ID int not null,
num_Orden int not null,
cantidad int not null,
precioCompra money not null
constraint pk_DetalleCompra
primary key(Producto_ID, num_Orden),
constraint fk_OrdenCompra_Producto
foreign key (Producto_ID)
References PRODUCTO(Num_Control),
constraint fk_OrdenCompra_Compra
foreign key (num_Orden)
references ORDEN_COMPRA (num_Orden)
);
```

``` sql
# Llenar base de datos con lenguaje_SQL-lMD

use [BDventas]
select*from [Northwind].dbo.Customers;
go
SELECT*FROM CLIENTEE;
GO
--Inserta varios clientes en la tabla cliente--
insert into CLIENTEE(rfc,curp,nombres,apellido_1,apellido_2)
values ('ftrd029273554r','JAGT09HJDHR7','Diana ','martinez','Gomez'),

('jshd198yhgsfdf','GA367484EUR0','Juana ortega','Larios','Garcia'),

('hyete675845j8j','JAGT09HHSTE9','Maria de la Luz ','Marcos','Gonzalez'),

('powue98yhgsfdf','JSUE89POEUR0','Juan meza','Martinez','larios'),

('ftrd1983jahsg6','JAG24356DTR7','Diego ','Garcia','Tovar'),

('qyque1526gsfdf','GAG74654PUR0','Lilieth','Corona','Tovar')


select*from CLIENTEE

--Elimina los datos de la tabla cliente
delete CLIENTEE
go
delete from CLIENTEE
go

--Comando para reiniciar el identity en una tabla
DBCC CHECKIDENT (CLIENTEE,RESEED,0)


--CREA UNA TABLA A PARTIR DE UNA COSULTA--
select top 0 EmployeeID as 'Empleado_ID', --El "as" funciona para escribirle un alias a las variables de las tablas--
LastName as 'Apellido',
FirstName as 'Nombre',
BirthDate as 'Fecha_Nacimiento',
HireDate as 'FechaContratacion',
[Address] as 'Direccion',
City as 'Ciudad',Region,
PostalCode as 'CP',
Country as 'Pais' into Empleado_2 from Northwind.dbo.Employees

--Elimina la tabla Empleado_2
drop table Empleado_2;
go

--Seleccionar datos a partir de una consulta
select*from Empleado_2

--Altera uan tabla para crear una primary key--
alter table Empleado_2
add constraint pk_Empleado2
primary key ([Empleado_ID])
go


--Insertar datos a traves de una consulta
insert into Empleado_2 (Empleado_ID,Apellido,Nombre,Fecha_Nacimiento,FechaContratacion,Direccion,Ciudad,Region,CP,Pais)

select EmployeeID as 'Empleado_ID',
LastName as 'Apellido',
FirstName as 'Nombre',
BirthDate as 'Fecha_Nacimiento',
HireDate as 'FechaContratacion',
[Address] as 'Direccion',
City as 'Ciudad',Region,
PostalCode as 'CP',
Country as 'Pais' from Northwind.dbo.Employees


select top 5* from Northwind.dbo.[Order Details]
order by OrderID desc
select*from EMPLEADO
insert into EMPLEADO(nombres,apellido_1,apellido_2,curp,rfc,
numExterno,calle,salario,numNomina)
values ('Alan','Santiago','Molina','ASMGF345677','HAGDT3574',
'23','Calle del infierno',67890.9,12345),
('Yamilet','Mejia','Rangel','YMR6384GAGD0','63374BBHS',
NULL,'Calle del Amo',56000.9,23456),
('Mises','Santiago','Isidro','MSI7364GSFD6','73ÑPOL546',
NULL,'Calle de la gordura',20000.0,34567);

insert into ORDEN_COMPRA
values(GETDATE(),'2024-06-10',2,3),
	  (GETDATE(),'2024-07.11',3,4)

--Selecciona la fecha actual del sistema 
select GETDATE()

select*from ORDEN_COMPRA

--Para tabla Producto
select*from PRODUCTO

insert into PRODUCTO(Num_Control,descripcion,precio,
[status],existencia,Proveedor_ID)
select ProductID,ProductName,UnitPrice,Discontinued,UnitsInStock,SupplierID 
from Northwind.dbo.Products
where UnitsInStock=0


--Para tabla Proveedor
select*from Proveedor
select*from Northwind.dbo.Suppliers
insert into Proveedor
select supplierID,CompanyName,PostalCode,'calle soledad',City,2345 as cp,
'www.prueba.com.mx' as 'pagina web' 
from Northwind.dbo.Suppliers

--
select*from ORDEN_COMPRA

insert into Detalle_Compra
values (1,3,30,(select precio from PRODUCTO where Num_Control=1))
--Seleccionar las ordenes de compra del producto1

select *,(cantidad*precioCompra) as importe
from Detalle_Compra
where Producto_ID=1

--Seleccionar el total a pagar de las ordenes del producto 1

select SUM(cantidad*precioCompra)as 'total'
from Detalle_Compra
where Producto_ID=1