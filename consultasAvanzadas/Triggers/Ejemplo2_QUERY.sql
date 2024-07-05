--Crear un trigger en la BD  PruebaTriggers, para la tabla
--empleados, este trigger debe evitat que se inserten o
--modifiquen salarios mayores a 50000

Use Prueba_Triggers
go

CREATE TABLE Empleado(
ID INT NOT NULL PRIMARY KEY,
Nombre VARCHAR(50) NOT NULL,
Salario MONEY NOT NULL

);



CREATE OR ALTER TRIGGER Verificar_Salario
ON Empleado
AFTER INSERT
AS
BEGIN
	IF EXISTS(SELECT 1 FROM inserted) AND NOT EXISTS (SELECT 1 FROM deleted)
	BEGIN
		DECLARE @SalarioNuevo money
		SET @SalarioNuevo = (SELECT Salario from inserted)

		IF @SalarioNuevo > 50000
		BEGIN 
			RAISERROR('El salario es mayor a 50000 y no esta permitido',16,1);
			ROLLBACK TRANSACTION;

		END
	END
END
