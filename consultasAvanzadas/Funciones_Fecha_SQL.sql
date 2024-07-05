-- Funciones de Fecha

--Seleccionar los años, dias, mes, y cuatrimestre de las ordenes
use Northwind

select GETDATE()

SELECT DATEPART (year,OrderDate ) as 'AÑO',
DATEPART (MONTH,OrderDate ) AS 'MES',
DATEPART (QUARTER,OrderDate ) AS 'TRIMESTRE',
DATEPART (WEEK,OrderDate ) AS 'SEMANA',
DATEPART (DAY,OrderDate) AS 'DIA',
DATEPART (WEEKDAY,OrderDate ) AS 'DIA DE SEMANA'
FROM ORDERS

select DATEPART (year, '2024-06-06') as 'AÑO',
DATEPART (MONTH, '2024-06-06') AS 'MES',
DATEPART (QUARTER, '2024-06-06') AS 'TRIMESTRE',
DATEPART (WEEK, '2024-06-06') AS 'SEMANA',
DATEPART (DAY,'2024-06-06') AS 'DIA',
DATEPART (WEEKDAY, '2024-06-06') AS 'DIA DE SEMANA'

--Funcion que regresa el nombre de un mes o dia
SELECT DATENAME (MONTH, GETDATE()) AS 'MES'
SET LANGUAGE SPANISH
SELECT DATENAME (MONTH,GETDATE()) AS MES, DATENAME(WEEKDAY,GETDATE()) AS 'DIA'

SELECT DATENAME (year,OrderDate ) as 'AÑO',
DATENAME (MONTH,OrderDate ) AS 'MES',
DATENAME (QUARTER,OrderDate ) AS 'TRIMESTRE',
DATENAME (WEEK,OrderDate ) AS 'SEMANA',
DATENAME (DAY,OrderDate) AS 'DIA',
DATENAME (WEEKDAY,OrderDate ) AS 'DIA DE SEMANA'
FROM ORDERS

--Funcion para obtener la diferencia entre años, meses y dias, etc
SELECT DATEDIFF (YEAR,'1983',GETDATE() ) AS 'TIEMPO DE VEJES'

--Seleccionar el  numero de dias transcurridos entre la fecha de pedido y la fecha de entrega
select DATEDIFF(DAY,OrderDate,Shippeddate) AS 'Dias Transcurridos'
from Orders
