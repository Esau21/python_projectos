Comprender las subconsultas
Completado
100 XP
3 minutos
Una subconsulta es una instrucción SELECT anidada dentro de otra consulta. La posibilidad de anidar una consulta dentro de otra mejorará su capacidad de crear consultas eficaces en T-SQL. En general, las subconsultas se evalúan una vez y proporcionan sus resultados a la consulta externa.

Trabajar con subconsultas
Una subconsulta es una instrucción SELECT anidada o incrustada en otra consulta. La consulta anidada, que es la subconsulta, se conoce como consulta interna. La consulta que contiene la consulta anidada es la consulta externa.

El propósito de una subconsulta es devolver resultados a la consulta externa. La forma de los resultados determinará si la subconsulta es una subconsulta escalar o multivalor:

Las subconsultas escalares devuelven un solo valor. Las consultas externas deben procesar un único resultado.
Las subconsultas multivalor devuelven un resultado muy similar a una tabla de una sola columna. Las consultas externas deben poder procesar varios valores.
Además de la elección entre subconsultas escalares y multivalor, las subconsultas pueden ser independientes o pueden correlacionarse con la consulta externa:

Las subconsultas independientes se pueden escribir como consultas independientes, sin dependencias de la consulta externa. Una subconsulta independiente se procesa una vez, cuando la consulta externa se ejecuta y pasa sus resultados a esa consulta externa.
Las subconsultas correlacionadas hacen referencia a una o varias columnas de la consulta externa y, por tanto, dependen de ella. Las subconsultas correlacionadas no se pueden ejecutar por separado desde la consulta externa.

<================>

Usar subconsultas escalares o multivalor
Completado
100 XP
3 minutos
Una subconsulta escalar es una instrucción SELECT interna dentro de una consulta externa, escrita para devolver un solo valor. Las subconsultas escalares se pueden usar en cualquier lugar de una instrucción T-SQL externa en la que se permita una expresión de un solo valor, como en una cláusula SELECT, una cláusula WHERE, una cláusula HAVING o incluso una cláusula FROM. También se pueden usar en instrucciones de modificación de datos, como UPDATE o DELETE.

Las subconsultas multivalor, como sugiere el nombre, pueden devolver más de una fila. Sin embargo, todavía devuelven una sola columna.

Subconsultas escalares
Imaginemos que desea recuperar los detalles del último pedido que se ha realizado, suponiendo que es el que tiene el valor SalesOrderID más alto.

Para buscar el valor SalesOrderID más alto, puede usar la consulta siguiente:

SQL

Copiar
SELECT MAX(SalesOrderID)
FROM Sales.SalesOrderHeader
Esta consulta devuelve un valor único que indica el valor más alto de OrderID en la tabla SalesOrderHeader.

Para obtener los detalles de este pedido, es posible que tenga que filtrar la tabla SalesOrderDetails en función del valor devuelto por la consulta anterior. Puede realizar esta tarea anidando la consulta para recuperar el valor máximo de SalesOrderID dentro de la cláusula WHERE de una consulta que recupera los detalles del pedido.

SQL

Copiar
SELECT SalesOrderID, ProductID, OrderQty
FROM Sales.SalesOrderDetail
WHERE SalesOrderID = 
   (SELECT MAX(SalesOrderID)
    FROM Sales.SalesOrderHeader);
Para escribir una subconsulta escalar, tenga en cuenta las siguientes directrices:

Para indicar una consulta como subconsulta, escríbala entre paréntesis.
Se admiten varios niveles de subconsultas en Transact-SQL. En este módulo, solo se considerarán las consultas de dos niveles (una consulta interna dentro de una consulta externa), pero se admiten hasta 32 niveles.
Si la subconsulta no devuelve filas (un conjunto vacío), el resultado de la subconsulta es NULL. Si es posible en su escenario que no se devuelva ninguna fila, debe asegurarse de que la consulta externa puede controlar correctamente un valor NULL, además de otros resultados esperados.
Por lo general, la consulta interna debe devolver una sola columna. La selección de varias columnas en una subconsulta casi siempre es un error. La única excepción es si la subconsulta se indica con la palabra clave EXISTS.
Una subconsulta escalar se puede usar en cualquier lugar de una consulta donde se espera un valor, incluida la lista SELECT. Por ejemplo, podríamos ampliar la consulta que recuperó los detalles del pedido más reciente para incluir la cantidad media de elementos que se pide, de modo que podamos comparar la cantidad pedida en el pedido más reciente con la media de todos los pedidos.

SQL

Copiar
SELECT SalesOrderID, ProductID, OrderQty,
    (SELECT AVG(OrderQty)
     FROM SalesLT.SalesOrderDetail) AS AvgQty
FROM SalesLT.SalesOrderDetail
WHERE SalesOrderID = 
    (SELECT MAX(SalesOrderID)
     FROM SalesLT.SalesOrderHeader);
Subconsultas multivalor
Una subconsulta multivalor es adecuada para devolver resultados mediante el operador IN. En el ejemplo hipotético siguiente se devuelven los valores CustomerID y SalesOrderID de todos los pedidos realizados por los clientes de Canadá.

SQL

Copiar
SELECT CustomerID, SalesOrderID
FROM Sales.SalesOrderHeader
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Sales.Customer
    WHERE CountryRegion = 'Canada');
En este ejemplo, si ejecutara solo la consulta interna, se devolvería una columna de valores CustomerID, con una fila para cada cliente de Canadá.

En muchos casos, las subconsultas multivalor se pueden escribir fácilmente mediante combinaciones. Por ejemplo, esta es una consulta que usa una combinación para devolver los mismos resultados del ejemplo anterior:

SQL

Copiar
SELECT c.CustomerID, o.SalesOrderID
FROM Sales.Customer AS c
JOIN Sales.SalesOrderHeader AS o
    ON c.CustomerID = o.CustomerID
WHERE c. CountryRegion = 'Canada';
¿Cómo se decide si se escribe una consulta que implica varias tablas como JOIN o con una subconsulta? A veces, solo depende de con qué se siente más cómodo. La mayoría de las consultas anidadas que se convierten fácilmente en JOIN realmente se convertirán en JOIN de forma interna. En el caso de estas consultas, no hay ninguna diferencia real al escribir la consulta de una manera frente a otra.

Una restricción que debe tener en cuenta es que cuando se usa una consulta anidada, los resultados devueltos al cliente solo pueden incluir columnas de la consulta externa. Por lo tanto, si tiene que devolver columnas de ambas tablas, debe escribir la consulta mediante JOIN.

Por último, hay situaciones en las que la consulta interna necesita realizar operaciones mucho más complicadas que las recuperaciones simples de nuestros ejemplos. La reescritura de subconsultas complejas mediante JOIN puede ser difícil. Para muchos desarrolladores de SQL, las subconsultas funcionan mejor para un procesamiento complicado, ya que le permite dividir el procesamiento en pasos más pequeños.

<===============================================>

Usar subconsultas independientes o correlacionadas
Completado
100 XP
3 minutos
Anteriormente, examinamos las subconsultas independientes en las que la consulta interna es independiente de la consulta externa, se ejecuta una vez y devuelve sus resultados a la consulta externa. T-SQL también admite las subconsultas correlacionadas, en las que la consulta interna hace referencia a la columna de la consulta externa y conceptualmente se ejecuta una vez por fila.

Trabajar con subconsultas correlacionadas
Al igual que las subconsultas independientes, las subconsultas correlacionadas son instrucciones SELECT anidadas dentro de una consulta externa. Las subconsultas correlacionadas también pueden ser subconsultas escalares o multivalor. Normalmente se usan cuando la consulta interna necesita hacer referencia a un valor en la consulta externa.

Sin embargo, a diferencia de las subconsultas independientes, hay algunas consideraciones especiales cuando se usan subconsultas correlacionadas:

Las subconsultas correlacionadas no se pueden ejecutar por separado desde la consulta externa. Esta restricción complica las pruebas y la depuración.
A diferencia de las subconsultas independientes, que se procesan una vez, las subconsultas correlacionadas se ejecutarán varias veces. Lógicamente, la consulta externa se ejecuta primero y, para cada fila devuelta, se procesa la consulta interna.
En el ejemplo siguiente se usa una subconsulta correlacionada para devolver el pedido más reciente de cada cliente. La subconsulta hace referencia a la consulta externa y hace referencia a su valor CustomerID en su cláusula WHERE. Para cada fila de la consulta externa, la subconsulta busca el identificador de pedido máximo del cliente al que se hace referencia en esa fila y la consulta externa comprueba si la fila que se está analizando es la fila con ese identificador de pedido.

SQL

Copiar
SELECT SalesOrderID, CustomerID, OrderDate
FROM SalesLT.SalesOrderHeader AS o1
WHERE SalesOrderID =
    (SELECT MAX(SalesOrderID)
     FROM SalesLT.SalesOrderHeader AS o2
     WHERE o2.CustomerID = o1.CustomerID)
ORDER BY CustomerID, OrderDate;
Escritura de subconsultas correlacionadas
Para escribir subconsultas correlacionadas, tenga en cuenta las siguientes directrices:

Escriba la consulta externa para aceptar el resultado devuelto adecuado de la consulta interna. Si la consulta interna es escalar, puede usar operadores de igualdad y comparación, como =, <, > y <>, en la cláusula WHERE. Si la consulta interna puede devolver varios valores, use un predicado IN. Cree un plan para controlar los resultados NULL.
Identifique la columna de la consulta externa a la que hará referencia la subconsulta correlacionada. Declare un alias para la tabla que es el origen de la columna en la consulta externa.
Identifique la columna de la tabla interna que se comparará con la columna de la tabla externa. Cree un alias para la tabla de origen, como hizo para la consulta externa.
Escriba la consulta interna para recuperar valores de su origen, en función del valor de entrada de la consulta externa. Por ejemplo, use la columna externa en la cláusula WHERE de la consulta interna.
La correlación entre las consultas interna y externa se produce cuando la consulta interna hace referencia al valor externo para su comparación. Es esta correlación la que proporciona a la subconsulta su nombre.

Trabajar con EXISTS
Además de recuperar valores de una subconsulta, T-SQL proporciona un mecanismo para comprobar si se devolverían resultados de una consulta. El predicado EXISTS determina si existen filas que cumplan una condición especificada, pero en lugar de devolverlas, devuelve TRUE o FALSE. Esta técnica es útil para validar los datos sin incurrir en la sobrecarga de recuperar y procesar los resultados.

Cuando una subconsulta está relacionada con la consulta externa mediante el predicado EXISTS, SQL Server controla los resultados de la subconsulta de una manera especial. En lugar de recuperar un valor escalar o una lista multivalor de la subconsulta, EXISTS simplemente comprueba si hay filas en el resultado.

Conceptualmente, un predicado EXISTS es equivalente a la recuperación de los resultados, el recuento de las filas devueltas y la comparación del recuento con cero. Compare las consultas siguientes, que devolverán detalles sobre los clientes que han realizado pedidos:

La primera consulta de ejemplo usa COUNT en una subconsulta:

SQL

Copiar
SELECT CustomerID, CompanyName, EmailAddress 
FROM Sales.Customer AS c 
WHERE
(SELECT COUNT(*) 
  FROM Sales.SalesOrderHeader AS o
  WHERE o.CustomerID = c.CustomerID) > 0;
La segunda consulta, que devuelve los mismos resultados, usa EXISTS:

SQL

Copiar
SELECT CustomerID, CompanyName, EmailAddress 
FROM Sales.Customer AS c 
WHERE EXISTS
(SELECT * 
  FROM Sales.SalesOrderHeader AS o
  WHERE o.CustomerID = c.CustomerID);
En el primer ejemplo, la subconsulta debe contar todas las repeticiones de cada custid que se encuentre en la tabla Sales.SalesOrderHeader y comparar los resultados del recuento con cero, simplemente para indicar que el cliente ha realizado pedidos.

En la segunda consulta, EXISTS devolverá TRUE para un custid en cuanto se haya encontrado un pedido pertinente en la tabla Sales.SalesOrderHeader. No es necesario realizar una contabilidad de cuentas completa de cada repetición. Tenga en cuenta también que, con el formulario EXISTS, la subconsulta no está restringida a la devolución de una sola columna. Aquí, aparece SELECT *. Las columnas devueltas son irrelevantes porque solo estamos comprobando si se devuelve alguna fila, no qué valores hay en esas filas.

Desde la perspectiva del procesamiento lógico, los dos formularios de consulta son equivalentes. Desde una perspectiva de rendimiento, el motor de base de datos puede tratar las consultas de forma diferente a medida que las optimiza para su ejecución. Considere la posibilidad de probar cada una de ellos para su propio uso.

 Nota

Si va a convertir una subconsulta mediante COUNT(*) en una con EXISTS, asegúrese de que la subconsulta usa SELECT * y no SELECT COUNT(*). SELECT COUNT(*) siempre devuelve una fila, de modo que EXISTS siempre devolverá TRUE.

Otra aplicación útil de EXISTS es la negación de la subconsulta con NOT, como en el ejemplo siguiente, que devolverá cualquier cliente que nunca haya realizado un pedido:

SQL

Copiar
SELECT CustomerID, CompanyName, EmailAddress 
FROM SalesLT.Customer AS c 
WHERE NOT EXISTS
  (SELECT * 
   FROM SalesLT.SalesOrderHeader AS o
   WHERE o.CustomerID = c.CustomerID);
SQL Server tendrá que devolver datos sobre los pedidos relacionados para los clientes que hayan realizado pedidos. Si se encuentra un custid en la tabla Sales.SalesOrderHeader, NOT EXISTS se evalúa como FALSE y la evaluación se completa rápidamente.

Para escribir consultas que usan EXISTS con subconsultas, tenga en cuenta las siguientes directrices:

La palabra clave EXISTS sigue directamente a WHERE. Ningún nombre de columna (u otra expresión) la precede, a menos que también se utilice NOT.
En la subconsulta, use SELECT *. La subconsulta no devuelve ninguna fila, por lo que no es necesario especificar ninguna columna.
