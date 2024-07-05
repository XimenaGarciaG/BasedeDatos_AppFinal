CREATE DATABASE Prueba_Triggers
GO
USE Prueba_Triggers

CREATE TABLE Tabla1(
ID INT NOT NULL PRIMARY KEY,
nombre VARCHAR(50) NOT NULL
);
GO
--TRIGGERS
--Crear trigger que identifica elemento que se ejecuto

--UNA INSERCCION
CREATE TRIGGER TG_Verificar_Inserccion
on Tabla1
AFTER INSERT
AS
BEGIN
	PRINT 'Se ejecuto el evento insert en l atabla'
END

INSERT INTO Tabla1
values (1,'nombre');


--UN DELETE
CREATE TRIGGER TG_Verificar_Delete2
on Tabla1
AFTER DELETE
AS
BEGIN
	PRINT 'Se ejecuto el evento delete en la tabla 1'
END

DELETE Tabla1
where ID=1


INSERT INTO Tabla1
values (1,'nombre')

--UN UPDATE
CREATE TRIGGER TG_Verificar_Update
on Tabla1
AFTER UPDATE
AS
BEGIN
	PRINT 'Se ejecuto el evento update en la tabla 1'
END


Update Tabla1
set nombre= 'Nombre nuevo'
where ID=1


---------------------------------------------------------------------

CREATE TRIGGER Verficar_Contenido_Inserted
ON Tabla1
AFTER INSERT
AS
BEGIN
--Ver los datos de la tabla inserted
	Select*From inserted
END


select*from Tabla1

Insert into Tabla1
VALUES (2,'Nombre 2');

Insert into Tabla1
VALUES (3,'Nombre 3'),(4,'Nombre 4');



--Verificar un insert en la tabla Categories
USE Northwind;

CREATE OR ALTER TRIGGER Verificar_Inserted_Categories
ON Categories
AFTER INSERT
AS
BEGIN
	SELECT CategoryID,categoryName,[Description] FROM inserted
END


INSERT INTO Categories (categoryName, [Description])
VALUES ('CategoriaNueva','Prueba de Triggers')



CREATE OR ALTER TRIGGER Verificar_Update__Categories
ON Categories
AFTER Update
AS
BEGIN
	SELECT CategoryID,categoryName,[Description] FROM inserted;
	SELECT CategoryID,categoryName,[Description] FROM deleted;
END


UPDATE Categories
SET categoryName = 'OtraCategoria',
	[Description] = 'Si esta bien'
Where CategoryID=9

SELECT*FROM Categories


DROP TRIGGER Verificar_Update__Categories
DROP TRIGGER Verificar_Update_Categories
DROP TRIGGER Verificar_Inserted__Categories


CREATE OR ALTER TRIGGER Verificar_Inserted_Deleted
ON Categories
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	IF EXISTS(SELECT 1 FROM inserted) AND NOT EXISTS (SELECT 1 FROM deleted)
	BEGIN
		PRINT('Existeb datos en la tabla Inserted, Se ejecuto un insert')
	END
	
	IF EXISTS(SELECT 1 FROM deleted) AND NOT EXISTS (SELECT 1 FROM inserted)
	BEGIN
		PRINT('Existeb datos en la tabla Delete, se realizo un delete')
	END
	ELSE IF EXISTS(SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted)
	BEGIN
		PRINT('Existen datos en ambas tablas, Se ejecuto un update')
	END
END

INSERT INTO Categories(CategoryName, [Description])
VALUES ('11','Pimpon ES UN MUÑECO')

UPDATE Categories
SET [Description]= 'Pimpon es un muñeco'
WHERE CategoryName=10
