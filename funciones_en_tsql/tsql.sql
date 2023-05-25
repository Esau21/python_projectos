Usar funciones escalares
Completado
100 XP
3 minutos
Las funciones escalares devuelven un valor único y normalmente funcionan en una sola fila de datos. El número de valores de entrada que toman puede ser cero (por ejemplo, GETDATE), uno (por ejemplo, UPPER) o varios (por ejemplo, ROUND). Dado que las funciones escalares siempre devuelven un solo valor, se pueden usar en cualquier lugar en el que se necesite un único valor (el resultado). Se usan normalmente en cláusulas SELECT y predicados de cláusula WHERE. También se pueden usar en la cláusula SET de una instrucción UPDATE.

Las funciones escalares integradas se pueden organizar en muchas categorías, como cadena, conversión, lógica, matemática y otras. En este módulo se explican algunas funciones escalares comunes.

Estas son algunas de las consideraciones que hay que tener en cuenta al usar funciones escalares:

Determinismo: si la función devuelve el mismo valor para el mismo estado de entrada y base de datos cada vez que se llama, se dice que es determinista. Por ejemplo, ROUND(1.1, 0) siempre devuelve el valor 1.0. Muchas funciones integradas son no deterministas. Por ejemplo, GETDATE() devuelve la fecha y hora actuales. Los resultados de las funciones no deterministas no se pueden indexar, lo que afecta a la capacidad del procesador de consultas de idear un buen plan para ejecutar la consulta.
Intercalación: cuando se usan funciones que manipulan datos de caracteres, ¿qué intercalación se usará? Algunas funciones usan la intercalación (criterio de ordenación) del valor de entrada; otros usan la intercalación de la base de datos si no se proporciona ninguna intercalación de entrada.
Ejemplos de funciones escalares
En el momento de redactar la documentación de SQL Server, se enumeran más de 200 funciones escalares que abarcan varias categorías, entre las que se incluyen las siguientes:

Funciones de configuración
Funciones de conversión
Funciones de cursores
Funciones de fecha y hora
Funciones matemáticas
Funciones de metadatos
Funciones de seguridad
Funciones de cadena
Funciones del sistema
Funciones estadísticas del sistema
Funciones de texto y de imagen
No hay tiempo suficiente en este curso para describir cada función, pero en los ejemplos siguientes se muestran algunas funciones que se usan con frecuencia.

En el ejemplo hipotético siguiente se usan varias funciones de fecha y hora:

SQL

Copiar
SELECT  SalesOrderID,
    OrderDate,
        YEAR(OrderDate) AS OrderYear,
        DATENAME(mm, OrderDate) AS OrderMonth,
        DAY(OrderDate) AS OrderDay,
        DATENAME(dw, OrderDate) AS OrderWeekDay,
        DATEDIFF(yy,OrderDate, GETDATE()) AS YearsSinceOrder
FROM Sales.SalesOrderHeader;
A continuación se muestran resultados parciales:

Id.OrdenVentas

OrderDate

OrderYear

OrderMonth

OrderDay

OrderWeekDay

YearsSinceOrder

71774

2008-06-01T00:00:00

2008

Junio

1

Domingo

13

...

...

...

...

...

...

...

En el ejemplo siguiente se incluyen algunas funciones matemáticas:

SQL

Copiar
SELECT TaxAmt,
       ROUND(TaxAmt, 0) AS Rounded,
       FLOOR(TaxAmt) AS Floor,
       CEILING(TaxAmt) AS Ceiling,
       SQUARE(TaxAmt) AS Squared,
       SQRT(TaxAmt) AS Root,
       LOG(TaxAmt) AS Log,
       TaxAmt * RAND() AS Randomized
FROM Sales.SalesOrderHeader;
Resultados parciales:

TaxAmt

Redondeo

Floor

Ceiling

Cuadrado

Root

Registro

Aleatorio

70,4279

70,0000

70,0000

71,0000

4960,089098

8,392133221

4,254589491

28,64120429

...

..

...

...

...

...

...

...

En el ejemplo siguiente se usan algunas funciones de cadena:

SQL

Copiar
SELECT  CompanyName,
        UPPER(CompanyName) AS UpperCase,
        LOWER(CompanyName) AS LowerCase,
        LEN(CompanyName) AS Length,
        REVERSE(CompanyName) AS Reversed,
        CHARINDEX(' ', CompanyName) AS FirstSpace,
        LEFT(CompanyName, CHARINDEX(' ', CompanyName)) AS FirstWord,
        SUBSTRING(CompanyName, CHARINDEX(' ', CompanyName) + 1, LEN(CompanyName)) AS RestOfName
FROM Sales.Customer;
Resultados parciales:

CompanyName

UpperCase

LowerCase

Length

Reversed

FirstSpace

FirstWord

RestOfName

Una tienda de bicicletas

UNA TIENDA DE BICICLETAS

una tienda de bicicletas

12

erotS ekiB A

2

A

Tienda de bicicletas

Progressive Sports

PROGRESSIVE SPORTS

progressive sports

18

stropS evissergorP

12

progresivo

Deportes

Advanced Bike Components

ADVANCED BIKE COMPONENTS

advanced bike components

24

stnenopmoC ekiB decnavdA

9

Avanzado

Bike Components

...

...

...

...

...

...

...

...

Funciones lógicas
Otra categoría de funciones permite determinar cuál de varios valores se va a devolver. Las funciones lógicas evalúan una expresión de entrada y devuelven un valor adecuado en función del resultado.

IIF
La función IIF evalúa una expresión de entrada booleana y devuelve un valor especificado si la expresión se evalúa como True, y un valor alternativo si la expresión se evalúa como False.

Por ejemplo, observe la siguiente consulta, que evalúa el tipo de dirección de un cliente. Si el valor es "Oficina principal", la expresión devuelve "Facturación". Para todos los demás valores de tipo de dirección, la expresión devuelve "Correo".

SQL

Copiar
SELECT AddressType,
      IIF(AddressType = 'Main Office', 'Billing', 'Mailing') AS UseAddressFor
FROM Sales.CustomerAddress;
Los resultados parciales de esta consulta podrían tener este aspecto:

AddressType

UseAddressFor

Oficina principal

Facturación

Envío

Correo

...

...

CHOOSE
La función CHOOSE evalúa una expresión de entero y devuelve el valor correspondiente de una lista en función de su posición ordinal (basada en 1).

SQL

Copiar
SELECT SalesOrderID, Status,
CHOOSE(Status, 'Ordered', 'Shipped', 'Delivered') AS OrderStatus
FROM Sales.SalesOrderHeader;
Los resultados de esta consulta podrían tener un aspecto parecido al siguiente:

Id.OrdenVentas

Estado

OrderStatus

1234

3

Delivered (Entregado)

1235

2

Enviado

1236

2

Enviado

1237

1

Ordered (Realizado)

...

...

...



SELECT YEAR(SellStartDate) AS SellStartYear, ProductID, NameFROM SalesLT.ProductORDER BY SellStartYear;SELECT YEAR(SellStartDate) AS SellStartYear,       DATENAME(mm,SellStartDate) AS SellStartMonth,       DAY(SellStartDate) AS SellStartDay,       DATENAME(dw, SellStartDate) AS SellStartWeekday,       DATEDIFF(yy,SellStartDate, GETDATE()) AS YearsSold,       ProductID,       NameFROM SalesLT.ProductORDER BY SellStartYear;SELECT CONCAT(FirstName + ' ', LastName) AS FullNameFROM SalesLT.Customer;SELECT UPPER(Name) AS ProductName,       ProductNumber,       ROUND(Weight, 0) AS ApproxWeight,       LEFT(ProductNumber, 2) AS ProductType,       SUBSTRING(ProductNumber,CHARINDEX('-', ProductNumber) + 1, 4) AS ModelCode,       SUBSTRING(ProductNumber, LEN(ProductNumber) - CHARINDEX('-', REVERSE(RIGHT(ProductNumber, 3))) + 2, 2) AS SizeCodeFROM SalesLT.Product;SELECT Name, Size AS NumericSizeFROM SalesLT.ProductWHERE ISNUMERIC(Size) = 1;SELECT Name, IIF(ISNUMERIC(Size) = 1, 'Numeric', 'Non-Numeric') AS SizeTypeFROM SalesLT.Product;SELECT prd.Name AS ProductName,       cat.Name AS Category,       CHOOSE (cat.ParentProductCategoryID, 'Bikes','Components','Clothing','Accessories') AS ProductTypeFROM SalesLT.Product AS prdJOIN SalesLT.ProductCategory AS cat    ON prd.ProductCategoryID = cat.ProductCategoryID;SELECT COUNT(*) AS Products,       COUNT(DISTINCT ProductCategoryID) AS Categories,       AVG(ListPrice) AS AveragePriceFROM SalesLT.Product;SELECT COUNT(p.ProductID) AS BikeModels, AVG(p.ListPrice) AS AveragePriceFROM SalesLT.Product AS pJOIN SalesLT.ProductCategory AS c    ON p.ProductCategoryID = c.ProductCategoryIDWHERE c.Name LIKE '%Bikes';SELECT Salesperson, COUNT(CustomerID) AS CustomersFROM SalesLT.CustomerGROUP BY SalespersonORDER BY Salesperson;SELECT c.Salesperson, SUM(oh.SubTotal) AS SalesRevenueFROM SalesLT.Customer cJOIN SalesLT.SalesOrderHeader oh    ON c.CustomerID = oh.CustomerIDGROUP BY c.SalespersonORDER BY SalesRevenue DESC;SELECT c.Salesperson, ISNULL(SUM(oh.SubTotal), 0.00) AS SalesRevenueFROM SalesLT.Customer cLEFT JOIN SalesLT.SalesOrderHeader oh    ON c.CustomerID = oh.CustomerIDGROUP BY c.SalespersonORDER BY SalesRevenue DESC;SELECT Salesperson, COUNT(CustomerID) AS CustomersFROM SalesLT.CustomerWHERE COUNT(CustomerID) > 100GROUP BY SalespersonORDER BY Salesperson;SELECT Salesperson, COUNT(CustomerID) AS CustomersFROM SalesLT.CustomerGROUP BY SalespersonHAVING COUNT(CustomerID) > 100ORDER BY Salesperson;SELECT SalesOrderID,       ROUND(Freight, 2) AS FreightCostFROM SalesLT.SalesOrderHeader;SELECT SalesOrderID,       ROUND(Freight, 2) AS FreightCost,       LOWER(ShipMethod) AS ShippingMethodFROM SalesLT.SalesOrderHeader;SELECT SalesOrderID,       ROUND(Freight, 2) AS FreightCost,       LOWER(ShipMethod) AS ShippingMethod,       YEAR(ShipDate) AS ShipYear,       DATENAME(mm, ShipDate) AS ShipMonth,       DAY(ShipDate) AS ShipDayFROM SalesLT.SalesOrderHeader;SELECT p.Name,SUM(o.LineTotal) AS TotalRevenueFROM SalesLT.SalesOrderDetail AS oJOIN SalesLT.Product AS p    ON o.ProductID = p.ProductIDGROUP BY p.NameORDER BY TotalRevenue DESC;SELECT p.Name,SUM(o.LineTotal) AS TotalRevenueFROM SalesLT.SalesOrderDetail AS oJOIN SalesLT.Product AS p    ON o.ProductID = p.ProductIDWHERE p.ListPrice > 1000GROUP BY p.NameORDER BY TotalRevenue DESC;SELECT p.Name,SUM(o.LineTotal) AS TotalRevenueFROM SalesLT.SalesOrderDetail AS oJOIN SalesLT.Product AS p    ON o.ProductID = p.ProductIDWHERE p.ListPrice > 1000GROUP BY p.NameORDER BY TotalRevenue DESC;