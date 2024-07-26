--Creando un Login de SQL
----Login me da acceso al servidor
use master

go

CREATE LOGIN usuario_Sistema 
with password ='P@ssw0rd'

--Creando un user para el login informatica en la BD Northwind
--Ademas lo agrego al esquema informatica

use Northwind
go

CREATE USER usuario_Sistema FOR LOGIN usuario_Sistema 

--Dar permisos de manera individual

GRANT CREATE TABLE TO usuario_Sistema