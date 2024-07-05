Create DATABASE Repaso_Joins;

CREATE TABLE PROVEEDOR(
    Provid INT NOT NULL IDENTITY(1,1),
    Nombre VARCHAR(58)NOT NULL,
    Lim_Credito MONEY NOT NULL,
    CONSTRAINT PK_Proveedor
    PRIMARY KEY (Provid)
)

CREATE TABLE PRODUCTO(
    Prodid INT NOT NULL IDENTITY(1,1),
    Nombre VARCHAR(100)NOT NULL,
    Existencia INT NOT NULL,
    Precio MONEY NOT NULL,
    Proveedor INT,
    CONSTRAINT Pk_Producto
    PRIMARY KEY (Prodid),
    CONSTRAINT Fk_Producto_Proveedor
    FOREIGN KEY (PROVEEDOR)
    REFERENCES PROVEEDOR(Provid)
);

INSERT INTO PROVEEDOR (Nombre,Lim_Credito)
values ('Proveedor 1','100000'),
('Proveedor 2','200000'),
('Proveedor 3','300000'),
('Proveedor 4','400000'),
('Proveedor 5','500000');

INSERT INTO PRODUCTO (Nombre,Existencia,Precio,Proveedor)
VALUES ('Producto 1',34,6,1),
('Producto 2',54,10,1),
('Producto 3',36,15,2),
('Producto 4',24,25,3);

Select*from PROVEEDOR;
SELECT*from PRODUCTO;


select pr.Nombre as 'NombreProducto', pr.Precio as 'Precio',
pr.Existencia as 'Existencia', p.Nombre as 'Proveedor'
from PROVEEDOR as p
INNER JOIN PRODUCTO AS pr
on p.Provid = pr.Proveedor;

--Consulta LEFT JOOIN
--Mostrar los proveedores y sus peoductos
select pr.prodid, pr.Nombre as 'NombreProducto', pr.Precio as 'Precio',
pr.Existencia as 'Existencia', p.Nombre as 'Proveedor'
from PROVEEDOR as p
LEFT JOIN PRODUCTO AS pr
on p.Provid = pr.Proveedor;

--Consulta con RIGTH JOIN
select pr.Nombre as 'NombreProducto', pr.Precio as 'Precio',
pr.Existencia as 'Existencia', p.Nombre as 'Proveedor'
from PROVEEDOR as p
RIGHT JOIN PRODUCTO AS pr
on p.Provid = pr.Proveedor;

select pr.Nombre as 'NombreProducto', pr.Precio as 'Precio',
pr.Existencia as 'Existencia', p.Nombre as 'Proveedor'
from PROVEEDOR as p
FULL JOIN PRODUCTO AS pr
on p.Provid = pr.Proveedor;


--Seleccionar todos los proveedores que no tienen asignado productos
select P.Provid AS 'NumeroProveedor', p.Nombre as 'Proveedor', pr.Prodid
from PROVEEDOR as p
LEFT JOIN PRODUCTO AS pr
on p.Provid = pr.Proveedor
WHERE PR.Prodid IS NULL

--Seleccionar todos los productos que no tienen proveedor 
select pr.Nombre, pr.Precio,pr.Existencia
from PROVEEDOR as p
LEFT JOIN PRODUCTO AS pr
on p.Provid = pr.Proveedor
WHERE PR.Prodid IS NULL





