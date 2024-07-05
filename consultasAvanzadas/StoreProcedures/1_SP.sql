DECLARE @X int
SET @X=10
PRINT 'El valor de x es:'+ CAST(@X as varchar)
if @X>=0
BEGIN
    PRINT 'EL NUMERO ES POSITIVO'
END
ELSE
BEGIN
    PRINT 'EL NUMERO ES NEGATIVO'
END


DECLARE @I as INT
set @I=1
WHILE(@I <=10)
BEGIN
    PRINT CAST (@I AS VARCHAR)
    SET @I=@I+1
END

--CREAR UN SP
CREATE PROCEDURE Procedure_ciclo
AS
BEGIN
    DECLARE @I as INT
    set @I=1
    WHILE(@I <=10)
BEGIN
        PRINT 'El primer valor es' + CAST (@I AS VARCHAR)
        SET @I=@I+1
    END
END

-- EJECUTAR SP
DECLARE @II INT =1
WHILE @II <=2
BEGIN
    EXEC Procedure_ciclo
    SET @II =@II+1
END

--RETO
CREATE PROCEDURE Procedure_Ciclo_SUMA
AS
BEGIN
    DECLARE @I as INT
    set @I=1
    DECLARE @II as INT
    SET @II=5
    WHILE(@I <=10)
BEGIN
        PRINT 'La suma es: ' + CAST (@I AS VARCHAR)
        SET @I=@I+@II
    END
END

--EJECUTAR
DECLARE @III INT =1
WHILE @III <=2
BEGIN
    EXEC Procedure_Ciclo_Reto
    SET @III =@III+1
END
