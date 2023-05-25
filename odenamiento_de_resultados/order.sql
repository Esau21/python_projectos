Ordenación de los resultados
Completado
100 XP
4 minutos
En el orden lógico del procesamiento de consultas, ORDER BY es la última fase de una instrucción SELECT que se va a ejecutar. ORDER BY permite controlar la ordenación de las filas a medida que se devuelven de SQL Server a la aplicación cliente. SQL Server no garantiza el orden físico de las filas de una tabla y la única manera de controlar el orden en que se devolverán las filas al cliente es con una cláusula ORDER BY. Este comportamiento es coherente con la teoría relacional.

Uso de la cláusula ORDER BY
Para indicarle a SQL Server que devuelva los resultados de la consulta en un orden determinado, agregue una cláusula ORDER BY con este formato:

SQL

Copiar
SELECT<select_list>
FROM <table_source>
ORDER BY <order_by_list> [ASC|DESC];
ORDER BY puede tomar varios tipos de elementos en su lista:

Columnas por nombre. Puede especificar los nombres de las columnas en función de las cuales se deben ordenar los resultados. Los resultados se devuelven según el orden de la primera columna y, luego, se ordenan por cada columna adicional.
Alias de columna. Como ORDER BY se procesa después de la cláusula SELECT, tiene acceso a los alias definidos en la lista SELECT.
Columnas por posición ordinal en la lista SELECT. No se recomienda usar la posición en las aplicaciones, debido a la disminución de la legibilidad y al cuidado adicional que se necesita para mantener actualizada la lista ORDER BY. Sin embargo, para las expresiones complejas de la lista SELECT, el uso del número de la posición puede ser útil durante la solución de problemas.
Las columnas no se incluyen en la lista SELECT, pero están disponibles en las tablas enumeradas de la cláusula FROM. Si la consulta usa una opción DISTINCT, las columnas de la lista ORDER BY deben incluirse en la lista SELECT.
Dirección de la ordenación
Además de especificar qué columnas se deben usar para determinar el criterio de ordenación, también puede controlar la dirección de la ordenación. Puede usar ASC para una ordenación ascendente (A-Z, 0-9) o DESC para una descendente (Z-A, 9-0). El valor predeterminado son las ordenaciones ascendentes. Cada columna puede tener especificada su propia dirección, como en el ejemplo siguiente:

SQL

Copiar
SELECT ProductCategoryID AS Category, ProductName
FROM Production.Product
ORDER BY Category ASC, Price DESC;


Limitación de los resultados ordenados
Completado
100 XP
3 minutos
La cláusula TOP es una extensión propiedad de Microsoft de la cláusula SELECT. La cláusula TOP le permitirá especificar cuántas filas se van a devolver, ya sea como un entero positivo o como un porcentaje de todas las filas calificadas. El número de filas se puede especificar como una constante o como una expresión. La cláusula TOP se usa con más frecuencia con ORDER BY, pero se puede usar con datos no ordenados.

Usar la cláusula TOP
La sintaxis simplificada de la cláusula TOP, que se usa con ORDER BY, es la siguiente:

SQL

Copiar
SELECT TOP (N) <column_list>
FROM <table_source>
WHERE <search_condition>
ORDER BY <order list> [ASC|DESC];
Por ejemplo, para recuperar solo los 10 productos más costosos de la tabla Production.Product, use la consulta siguiente:

SQL

Copiar
SELECT TOP 10 Name, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC;
El resultado podría ser similar al siguiente:

Nombre

ListPrice

Road-150 Red, 62

3578,27

Road-150 Red, 44

3578,27

Road-150 Red, 48

3578,27

Road-150 Red, 52

3578,27

Road-150 Red, 56

3578,27

Mountain-100 Silver, 38

3399,99

Mountain-100 Silver, 42

3399,99

Mountain-100 Silver, 44

3399,99

Mountain-100 Silver, 48

3399,99

Mountain-100 Black, 38

3374,99

El operador TOP depende de una cláusula ORDER BY para proporcionar una prioridad significativa a las filas seleccionadas. TOP se puede usar sin ORDER BY pero, en ese caso, no hay ninguna manera de predecir qué filas se devolverán. En este ejemplo, se podrían devolver 10 pedidos cualesquiera si no hubiese una cláusula ORDER BY.

Uso de WITH TIES
Además de especificar un número fijo de filas que se van a devolver, la palabra clave TOP también acepta la opción WITH TIES, que recuperará las filas con valores que puedan encontrarse en las primeras N filas seleccionadas.

En el ejemplo anterior, la consulta devolvió los 10 primeros productos en orden descendente de precio. Sin embargo, al agregar la opción WITH TIES a la cláusula TOP, verá que hay más filas que se pueden incluir en los 10 productos más caros:

SQL

Copiar
SELECT TOP 10 WITH TIES Name, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC;
Esta consulta modificada devuelve los resultados siguientes:

Nombre

ListPrice

Road-150 Red, 62

3578,27

Road-150 Red, 44

3578,27

Road-150 Red, 48

3578,27

Road-150 Red, 52

3578,27

Road-150 Red, 56

3578,27

Mountain-100 Silver, 38

3399,99

Mountain-100 Silver, 42

3399,99

Mountain-100 Silver, 44

3399,99

Mountain-100 Silver, 48

3399,99

Mountain-100 Black, 38

3374,99

Mountain-100 Black, 42

3374,99

Mountain-100 Black, 44

3374,99

Mountain-100 Black, 48

3374,99

La decisión de incluir WITH TIES dependerá de cuánto conozca los datos de origen, su potencial para valores únicos y los requisitos de la consulta que escribe.

Uso de PERCENT
Para devolver un porcentaje de las filas aptas, use la opción PERCENT con TOP en lugar de un número fijo.

SQL

Copiar
SELECT TOP 10 PERCENT Name, ListPrice
FROM SalesLT.Product
ORDER BY ListPrice DESC;
La opción PERCENT también se puede usar con la opción WITH TIES.

 Nota

Para el recuento de filas, TOP (N) PERCENT se redondeará hacia arriba al entero más cercano.

La opción TOP la usan muchos profesionales de SQL Server como método para recuperar solo un determinado intervalo de filas. Sin embargo, tenga en cuenta estos hechos al usar TOP:

TOP es propiedad de T-SQL.
TOP por sí solo no admite la omisión de filas.
Como TOP depende de una cláusula ORDER BY, no se puede usar un criterio de ordenación para establecer las filas filtradas por TOP y otra para determinar el orden de salida.


Resultados de la página
Completado
100 XP
3 minutos
Una extensión de la cláusula ORDER BY denominada OFFSET-FETCH permite devolver solo un intervalo de las filas seleccionadas por la consulta. Agrega la capacidad de proporcionar un punto inicial (un desplazamiento) y un valor para especificar cuántas filas desea devolver (un valor de captura). Esta extensión proporciona una técnica práctica para paginar los resultados.

Si desea devolver filas una "página" a la vez (con el número que elija para una página), deberá tener en cuenta que cada consulta con una cláusula OFFSET-FETCH se ejecuta independientemente de cualquier otra consulta. No se mantiene ningún estado del lado servidor y deberá realizar un seguimiento de su posición mediante un conjunto de resultados a través del código del lado cliente.

Sintaxis de OFFSET-FETCH
La sintaxis de la cláusula OFFSET-FETCH, que técnicamente forma parte de la cláusula ORDER BY, es la siguiente:

SQL

Copiar
OFFSET { integer_constant | offset_row_count_expression } { ROW | ROWS }
[FETCH { FIRST | NEXT } {integer_constant | fetch_row_count_expression } { ROW | ROWS } ONLY]
Uso de OFFSET-FETCH
Para usar OFFSET-FETCH, debe proporcionar un valor OFFSET inicial, que puede ser cero, y un número opcional de filas que se devolverán, como en el ejemplo siguiente:

En este ejemplo se devolverán las 10 primeras filas y, luego, se devolverán las 10 filas siguientes de datos de producto en función de ListPrice:

SQL

Copiar
SELECT ProductID, ProductName, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC 
OFFSET 0 ROWS --Skip zero rows
FETCH NEXT 10 ROWS ONLY; --Get the next 10
Para recuperar la página siguiente de datos del producto, use la cláusula OFFSET para especificar el número de filas que se van a omitir:

SQL

Copiar
SELECT ProductID, ProductName, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC 
OFFSET 10 ROWS --Skip 10 rows
FETCH NEXT 10 ROWS ONLY; --Get the next 10
En la definición de sintaxis puede ver que la cláusula OFFSET es obligatoria, pero la cláusula FETCH no lo es. Si se omite la cláusula FETCH, se devolverán todas las filas siguientes a OFFSET. También encontrará que las palabras clave ROW y ROWS son intercambiables, al igual que FIRST y NEXT, lo que permite una sintaxis más natural.

Para garantizar la precisión de los resultados, especialmente cuando se mueve de página a página de datos, es importante construir una cláusula ORDER BY que proporcione una ordenación única y un resultado determinista. Debido a la forma en que funciona el optimizador de consultas de SQL Server, es técnicamente posible que una fila aparezca en más de una página, a menos que el intervalo de filas sea determinista.



Eliminación de duplicados
Completado
100 XP
3 minutos
Aunque las filas de una tabla siempre deben ser únicas, al seleccionar solo un subconjunto de las columnas, es posible que las filas de resultados no sean únicas aunque las filas originales sí lo sean. Por ejemplo, puede tener una tabla de proveedores con un requisito de que la ciudad y el estado (o provincia) sean únicos para que nunca haya más de un proveedor en una ciudad. Sin embargo, si solo quiere ver las ciudades y los países o regiones donde se encuentran los proveedores, es posible que los resultados devueltos no sean únicos. Supongamos que escribe la consulta siguiente:

SQL

Copiar
SELECT City, CountryRegion
FROM Production.Supplier
ORDER BY CountryRegion, City;
Esta consulta puede devolver resultados similares a los siguientes:

City

CountryRegion

Aurora

Canadá

Barrie

Canadá

Brampton

Canadá

Brossard

Canadá

Brossard

Canadá

Burnaby

Canadá

Burnaby

Canadá

Burnaby

Canadá

Calgary

Canadá

Calgary

Canadá

...

...

De manera predeterminada, la cláusula SELECT incluye una palabra clave ALL implícita que da como resultado este comportamiento:

SQL

Copiar
SELECT ALL City, CountryRegion
FROM Production.Supplier
ORDER BY CountryRegion, City;
T-SQL también admite una alternativa a la palabra clave DISTINCT, que quita las filas de resultados duplicadas:

SQL

Copiar
SELECT DISTINCT City, CountryRegion
FROM Production.Supplier
ORDER BY CountryRegion, City;
Cuando se usa DISTINCT, el ejemplo devuelve solo una de cada combinación única de valores de la lista SELECT:

City

CountryRegion

Aurora

Canadá

Barrie

Canadá

Brampton

Canadá

Brossard

Canadá

Burnaby

Canadá

Calgary

Canadá

...

...



Filtrado de los datos con predicados
Completado
100 XP
3 minutos
Las instrucciones SELECT más simples con solo las cláusulas SELECT y FROM evaluarán cada fila de una tabla. Con el uso de una cláusula WHERE, se definen condiciones que determinan qué filas se procesarán y potencialmente reducirán el conjunto de resultados.

La estructura de la cláusula WHERE
La cláusula WHERE está compuesta de una o varias condiciones de búsqueda, cada una de las cuales debe evaluarse como TRUE, FALSE o “unknown” para cada fila de la tabla. Solo se devolverán las filas cuando la cláusula WHERE se evalúe como TRUE. Las condiciones individuales actúan como filtros en los datos y se conocen como “predicados”. Cada predicado incluye una condición que se prueba, por lo general mediante los operadores básicos de comparación:

= (es igual a)
<> (no es igual a)
> (mayor que)
>= (mayor o igual que)
< (menor que)
<= (menor o igual que)
Por ejemplo, la consulta siguiente devuelve todos los productos con un valor ProductCategoryID de 2:

SQL

Copiar
SELECT ProductCategoryID AS Category, ProductName
FROM Production.Product
WHERE ProductCategoryID = 2;
De manera similar, la consulta siguiente devuelve todos los productos con un valor ListPrice menor que 10,00:

SQL

Copiar
SELECT ProductCategoryID AS Category, ProductName
FROM Production.Product
WHERE ListPrice < 10.00;
IS NULL/IS NOT NULL
También puede filtrar fácilmente para permitir o excluir los valores “unknown” o NULL mediante IS NULL o IS NOT NULL.

SQL

Copiar
SELECT ProductCategoryID AS Category, ProductName
FROM Production.Product
WHERE ProductName IS NOT NULL;
Varias condiciones
Se pueden combinar varios predicados con los operadores AND y OR, y con paréntesis. Sin embargo, SQL Server solo procesará dos condiciones a la vez. Todas las condiciones deben ser TRUE al conectar varias condiciones con el operador AND. Cuando se usa el operador OR para conectar dos condiciones, una o ambas pueden ser TRUE para el conjunto de resultados.

Por ejemplo, la consulta siguiente devuelve un producto de la categoría 2 que cuesta menos de 10,00:

SQL

Copiar
SELECT ProductCategoryID AS Category, ProductName
FROM Production.Product
WHERE ProductCategoryID = 2
    AND ListPrice < 10.00;
Los operadores AND se procesan antes que los operadores OR, a menos que se utilicen paréntesis. Para el procedimiento recomendado, use paréntesis al usar más de dos predicados. La siguiente consulta devuelve productos de la categoría 2 OR (O) 3 AND (Y) cuesta menos de 10,00:

SQL

Copiar
SELECT ProductCategoryID AS Category, ProductName
FROM Production.Product
WHERE (ProductCategoryID = 2 OR ProductCategoryID = 3)
    AND (ListPrice < 10.00);
Operadores de comparación
Transact-SQL incluye operadores de comparación adicionales que pueden ayudar a simplificar la cláusula WHERE.

IN
El operador IN es un acceso directo para varias condiciones de igualdad para la misma columna conectada con OR. No hay ningún problema con el uso de varias condiciones OR en una consulta, como en el ejemplo siguiente:

SQL

Copiar
SELECT ProductCategoryID AS Category, ProductName
FROM Production.Product
WHERE ProductCategoryID = 2
    OR ProductCategoryID = 3
    OR ProductCategoryID = 4;
Sin embargo, el uso de IN es claro y conciso, y el rendimiento de la consulta no se verá afectado.

SQL

Copiar
SELECT ProductCategoryID AS Category, ProductName
FROM Production.Product
WHERE ProductCategoryID IN (2, 3, 4);
BETWEEN
BETWEEN es otro acceso directo que se puede usar al filtrar para un límite superior e inferior del valor, en lugar de usar dos condiciones con el operador AND. Las dos consultas siguientes son equivalentes:

SQL

Copiar
SELECT ProductCategoryID AS Category, ProductName
FROM Production.Product
WHERE ListPrice >= 1.00
    AND ListPrice <= 10.00;
SQL

Copiar
SELECT ProductCategoryID AS Category, ProductName
FROM Production.Product
WHERE ListPrice BETWEEN 1.00 AND 10.00;
El operador BETWEEN usa valores de límite inclusivos. Los productos con un precio de 1,00 o 10,00 se incluirán en los resultados. BETWEEN también es útil al consultar campos de fecha. Por ejemplo, la siguiente consulta incluirá todos los nombres de producto modificados entre el 1 de enero de 2012 y el 31 de diciembre de 2012:

SQL

Copiar
SELECT ProductName, ModifiedDate
FROM Production.Product
WHERE ModifiedDate BETWEEN '2012-01-01' AND '2012-12-31';
ProductName

ModifiedDate

Mountain Bike Socks, M

2012-01-01 00:00:00.000

HL Mountain Frame - Silver, 42

2012-03-05 00:00:00.000

HL Mountain Frame - Silver, 38

2012-08-29 00:00:00.000

Mountain-100 Silver, 38

2012-12-31 00:00:00.000

Sin embargo, dado que no se especifica un intervalo de tiempo, no se devuelve ningún resultado después de 2012-12-31 00:00:00.000. Para incluir con precisión la fecha y hora, es necesario incluir la hora en el predicado:

SQL

Copiar
SELECT ProductName, ListPrice, ModifiedDate
FROM Production.Product
WHERE ModifiedDate BETWEEN '2012-01-01 00:00:00.000' AND '2012-12-31 23:59:59.999';
Los operadores de comparación básicos, como Greater Than (>) y Equals (=) también son precisos cuando solo se filtran por fecha:

SQL

Copiar
SELECT ProductName, ListPrice, ModifiedDate
FROM Production.Product
WHERE ModifiedDate >= '2012-01-01' 
    AND ModifiedDate < '2013-01-01';
LIKE
El operador de comparación final solo se puede usar para los datos de caracteres y nos permite usar caracteres comodín y patrones de expresiones regulares. Los caracteres comodín nos permiten especificar cadenas parciales. Por ejemplo, podría usar la consulta siguiente para devolver todos los productos con nombres que contengan la palabra "mountain":

SQL

Copiar
SELECT Name, ListPrice
FROM SalesLT.Product
WHERE Name LIKE '%mountain%';
El carácter comodín % representa cualquier cadena de 0 caracteres o más, por lo que los resultados incluyen productos con la palabra "mountain" en cualquier parte del nombre, como se muestra a continuación:

Nombre

ListPrice

Mountain Bike Socks, M

9,50

Mountain Bike Socks, L

9,50

HL Mountain Frame - Silver, 42

1364,0

HL Mountain Frame - Black, 42

1349,60

HL Mountain Frame - Silver, 38

1364,50

Mountain-100 Silver, 38

3399,99

Puede usar el carácter comodín _ (guión bajo) para representar un carácter único, como este:

SQL

Copiar
SELECT ProductName, ListPrice
FROM SalesLT.Product
WHERE ProductName LIKE 'Mountain Bike Socks, _';
Los siguientes resultados solo incluyen productos que comienzan por “Mountain Bike Socks”, y un solo carácter después de:

ProductName

ListPrice

Mountain Bike Socks, M

9,50

Mountain Bike Socks, L

9,50

También puede definir patrones complejos para las cadenas que desea buscar. Por ejemplo, la siguiente consulta busca productos con un nombre que comience por “Mountain-”, seguido de:

tres caracteres entre 0 y 9
un espacio
cualquier cadena
una coma
un espacio
dos caracteres entre 0 y 9
SQL

Copiar
SELECT ProductName, ListPrice
FROM SalesLT.Product
WHERE ProductName LIKE 'Mountain-[0-9][0-9][0-9] %, [0-9][0-9]';
Los resultados de esta consulta podrían tener un aspecto parecido al siguiente:

ProductName

ListPrice

Mountain-100 Silver, 38

3399,99

Mountain-100 Silver, 42

3399,99

Mountain-100 Black, 38

3399,99

Mountain-100 Black, 42

3399,99

Mountain-200 Silver, 38

2319,99

Mountain-200 Silver, 42

2319,99

Mountain-200 Black, 38

2319,99

Mountain-200 Black, 42

2319,99