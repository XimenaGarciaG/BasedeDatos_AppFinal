--Crear un store procedure que lea los datos de cualquier tabla

Create or Alter Proc ALL_CONSULT
@tabla nvarchar(50)
AS
BEGIN
	DECLARE @query nvarchar(50)
	SET @query='Select*From ' +QUOTENAME (@tabla);
	--Exec( @query);
	exec sp_executesql @query;
END;

EXEC ALL_CONSULT Categories;


--

