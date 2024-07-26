--MERGE INTO <target table> AS TGT
--USING <SOURCE TABLE> AS SRC  
--  ON <merge predicate>
--WHEN MATCHED [AND <predicate>] -- two clauses allowed:  
--  THEN <action> -- one with UPDATE one with DELETE
--WHEN NOT MATCHED [BY TARGET] [AND <predicate>] -- one clause allowed:  
--  THEN INSERT... –- if indicated, action must be INSERT
--WHEN NOT MATCHED BY SOURCE [AND <predicate>] -- two clauses allowed:  
--  THEN <action>; -- one with UPDATE one with DELETE

Create DataBase Escuelita;
go

Use Escuelita;
go

CREATE TABLE StudentsC1(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);
CREATE TABLE StudentsC2(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);
go

INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(3,'Rogelio Rojas',0)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(4,'Mariana Rosas',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(5,'Roman Zavaleta',1)



INSERT INTO StudentsC2(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero Rendón',1)
INSERT INTO StudentsC2(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora Ríos',0)
INSERT INTO StudentsC2(StudentID, StudentName, StudentStatus) VALUES(6,'Mario Gonzalez Pae',1)
INSERT INTO StudentsC2(StudentID, StudentName, StudentStatus) VALUES(7,'Alberto García Morales',1)


Select*From StudentsC1
Select*From StudentsC2

--Seleccionar datos que no existen en la tabla C2
Select*From StudentsC1 as c1
Left join StudentsC2 as c2
ON c1.StudentID = c2.StudentID
Where c2.StudentID IS NULL


Select*From StudentsC1 as c1
Inner join StudentsC2 as c2
ON c1.StudentID = c2.StudentID


--Crear un Store Procediure que inserte y actualize la tabla StudentC2 mediante
--los datos de estudensC1 utilizando consultas LeftJoin e InnerJoin
GO 

CREATE OR ALTER PROCEDURE SPU_Carga_Incremental_Students
AS
BEGIN
 BEGIN TRANSACTION;
	
	BEGIN TRY
	--Se insertan estudiantes nuevos
	INSERT INTO StudentsC2(StudentID,StudentName,StudentStatus)

		Select c1.StudentID,c1.StudentName,c1.StudentStatus From StudentsC1 as c1
		Left join StudentsC2 as c2
		ON c1.StudentID = c2.StudentID
		Where c2.StudentID IS NULL
	--Se actualizan los datos diferentes que allan cambiado en StudentC1
		Update c2
		SET c2.StudentName=c1.StudentName, c2.StudentStatus=c1.StudentStatus
		From StudentsC1 as c1
		Inner join StudentsC2 as c2
		ON c1.StudentID = c2.StudentID

		COMMIT TRANSACTION

	END TRY
	BEGIN CATCH
		DECLARE @MensajeError nvarchar(max)
		SET @MensajeError = ERROR_MESSAGE()
		PRINT @MensajeError
	END CATCH

END;

EXEC SPU_Carga_Incremental_Students

TRUNCATE TABLE StudentsC1
TRUNCATE TABLE StudentsC2
GO
----Crear un Store Procediure que inserte y actualize la tabla StudentC2 mediante
--los datos de estudensC1 utilizando merge
CREATE OR ALTER PROCEDURE SPU_Carga_Incremental_Students_Merge
AS
BEGIN
 BEGIN TRANSACTION;
	
	BEGIN TRY
		MERGE INTO StudentsC2 as tgt--DESTINO
		USING (
		Select StudentID,StudentName,StudentStatus From StudentsC1 --FUENTE
		)AS src
		ON (tgt.StudentID=src.StudentID)
		--Para UPDATES
		WHEN MATCHED THEN 
		UPDATE
		SET tgt.StudentName=src.StudentName, 
			tgt.StudentStatus=src.StudentStatus
		--Para INSERT
		WHEN NOT MATCHED THEN
		INSERT (StudentID,StudentName,StudentStatus)
		VALUES (src.StudentID, src.StudentName, src.StudentStatus);


		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		DECLARE @MensajeError nvarchar(max)
		SET @MensajeError = ERROR_MESSAGE()
		PRINT @MensajeError
	END CATCH

END;


Exec SPU_Carga_Incremental