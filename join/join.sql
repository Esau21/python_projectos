Descripción de los conceptos y la sintaxis de las combinaciones
Completado
100 XP
3 minutos
El método más fundamental y común para combinar datos de varias tablas consiste en usar una operación JOIN. Algunas usuarios creen que JOIN es una cláusula independiente en una instrucción SELECT, pero otros la consideran parte de la cláusula FROM. En este módulo, se considerará principalmente parte de la cláusula FROM. En este módulo, se describirá cómo la cláusula FROM de una instrucción SELECT de T-SQL crea tablas virtuales intermedias que se consumirán en fases posteriores de la consulta.

La cláusula FROM y las tablas virtuales
Si conoce el orden lógico de las operaciones que se realizan cuando SQL Server procesa una consulta, sabe que la cláusula FROM de una instrucción SELECT es la primera que se procesa. Esta cláusula determina qué tabla o tablas serán el origen de las filas de la consulta. FROM puede hacer referencia a una sola tabla o reunir varias tablas como origen de datos para la consulta. Puede pensar en la cláusula FROM como lo que crea y rellena una tabla virtual. Esta tabla virtual contendrá la salida de la cláusula FROM y la usarán las cláusulas de la instrucción SELECT que se apliquen más adelante, como la cláusula WHERE. A medida que agrega funcionalidad adicional a una cláusula FROM, como operadores de combinación, será útil pensar que los elementos de la cláusula FROM agregan o quitan filas de la tabla virtual.

La tabla virtual creada por una cláusula FROM es solo una entidad lógica. En SQL Server, no se crea ninguna tabla física, ni persistente ni temporal, para contener los resultados de la cláusula FROM, ya que se pasa a la cláusula WHERE u otros elementos de la consulta.

La tabla virtual creada por la cláusula FROM contiene datos de todas las tablas combinadas. Puede ser útil pensar en los resultados como conjuntos y conceptualizar los resultados de la combinación como un diagrama de Venn.

A Venn diagram showing the set of an Employee table joined to a SalesOrder table

A lo largo de su historia, el lenguaje T-SQL se ha expandido para reflejar los cambios en los estándares del American National Standards Institute (ANSI) para el lenguaje SQL. Uno de los puntos más importantes donde se aprecian estos cambios es en la sintaxis de las combinaciones de una cláusula FROM. En el estándar ANSI SQL-89, las combinaciones se especifican mediante la inclusión de varias tablas en la cláusula FROM en una lista separada por comas. Cualquier filtrado para determinar qué filas se incluyen se realiza en la cláusula WHERE, de la siguiente manera:

SQL

Copiar
SELECT p.ProductID, m.Name AS Model, p.Name AS Product
FROM SalesLT.Product AS p, SalesLT.ProductModel AS m
WHERE p.ProductModelID = m.ProductModelID;
Esta sintaxis sigue siendo compatible con SQL Server, pero debido a la complejidad de representar los filtros para combinaciones complejas, no se recomienda. Además, si se omite accidentalmente una cláusula WHERE, las combinaciones de estilo ANSI SQL-89 pueden convertirse fácilmente en productos cartesianos y devolver un número excesivo de filas de resultados, lo que genera problemas de rendimiento y posiblemente resultados incorrectos.

Al aprender a escribir consultas de varias tablas en T-SQL, es importante comprender el concepto de productos cartesianos. En matemáticas, un producto cartesiano es el producto de dos conjuntos. El producto de un conjunto de dos elementos y otro de seis es un conjunto de 12 elementos (6 x 2). Cada uno de los elementos de un conjunto se combina con los del otro. En el ejemplo siguiente, hay un conjunto de nombres con dos elementos y un conjunto de productos con tres. El producto cartesiano combina cada nombre con cada producto, lo que genera seis elementos.

Cartesian product

En las bases de datos, un producto cartesiano es el resultado de combinar cada una de las fila de una tabla con las de otra. El producto de una tabla con 10 filas y otra con 100 es un conjunto de resultados con 1000 filas. El resultado subyacente de una operación JOIN es un producto cartesiano, pero para la mayoría de las consultas de T-SQL, un producto cartesiano no es el resultado deseado. En T-SQL, un producto cartesiano se produce cuando dos tablas de entrada se combinan sin tener en cuenta ninguna relación entre ellas. Sin información sobre las relaciones, el procesador de consultas de SQL Server devolverá todas las combinaciones de filas posibles. Aunque este resultado puede tener algunas aplicaciones prácticas, como la generación de datos de prueba, no suele ser útil y puede tener graves implicaciones en el rendimiento.

Con la aparición del estándar ANSI SQL-92, se ha agregado compatibilidad con las palabras clave JOIN y ON. T-SQL también admite esta sintaxis. Las combinaciones se representan en la cláusula FROM mediante el operador JOIN adecuado. La relación lógica entre las tablas, que se convierte en un predicado de filtro, se especifica en la cláusula ON.

En el ejemplo siguiente se vuelve a formular la consulta anterior con la sintaxis más reciente:

SQL

Copiar
SELECT p.ProductID, m.Name AS Model, p.Name AS Product
FROM SalesLT.Product AS p
JOIN SalesLT.ProductModel AS m
    ON p.ProductModelID = m.ProductModelID;
 Nota

La sintaxis de ANSI SQL-92 dificulta la creación de productos cartesianos accidentales. Una vez que se ha agregado la palabra clave JOIN, se producirá un error de sintaxis si falta una cláusula ON, a menos que JOIN se especifique como CROSS JOIN.

Uso de combinaciones internas
Completado
100 XP
6 minutos
El tipo más frecuente de operación JOIN en las consultas T-SQL es INNER JOIN. Las combinaciones internas se usan para resolver muchos problemas empresariales comunes, especialmente en entornos de base de datos muy normalizados. Para recuperar datos que se han almacenado en varias tablas, a menudo tendrá que combinarlos mediante consultas INNER JOIN. INNER JOIN comienza su fase de procesamiento lógico como un producto cartesiano y después se filtra para quitar las filas que no coinciden con el predicado.

Procesamiento de INNER JOIN
Ahora se examinarán los pasos por los que SQL Server procesará lógicamente una consulta JOIN. En el ejemplo hipotético siguiente se agregan números de línea para mayor claridad:

SQL

Copiar
1) SELECT emp.FirstName, ord.Amount
2) FROM HR.Employee AS emp 
3) JOIN Sales.SalesOrder AS ord
4)      ON emp.EmployeeID = ord.EmployeeID;
Como debería saber, la cláusula FROM se procesará antes que la cláusula SELECT. Se realizará el seguimiento del procesamiento, empezando por la línea 2:

La cláusula FROM especifica HR.Employee como una de las tablas de entrada, y le asigna el alias emp.
El operador JOIN de la línea 3 refleja el uso de INNER JOIN (el tipo predeterminado en T-SQL) y especifica Sales.SalesOrder como la otra tabla de entrada, que tiene un alias de ord.
SQL Server realizará una combinación cartesiana lógica en estas tablas y pasará los resultados como una tabla virtual al paso siguiente. (Es posible que el procesamiento físico de la consulta no realice realmente la operación del producto cartesiano, en función de las decisiones del optimizador. Pero puede resultar útil imaginar el producto cartesiano que se está creando).
Con la cláusula ON, SQL Server filtrará la tabla virtual y solo mantendrá aquellas filas en las que un valor EmployeeID de la tabla emp coincida con un valor EmployeeID de la tabla ord.
Las filas restantes se dejan en la tabla virtual y se entregan al paso siguiente en la instrucción SELECT. En este ejemplo, la tabla virtual se procesa a continuación mediante la cláusula SELECT y las dos columnas especificadas se devuelven a la aplicación cliente.
El resultado de la consulta completada es una lista de empleados y las cantidades de sus pedidos. Los empleados que no tienen ningún pedido asociado se han filtrado por la cláusula ON, al igual que los pedidos que tienen un valor EmployeeID que no se corresponde con una entrada en la tabla HR.Employee.

A Venn diagram showing the matching members of the Employee and SalesOrder sets

Sintaxis de INNER JOIN
INNER JOIN es el tipo predeterminado de operación JOIN y la palabra clave INNER opcional está implícita en la cláusula JOIN. Al mezclar tipos de combinación, puede ser útil especificar el tipo de combinación de forma explícita, como se muestra en este ejemplo hipotético:

SQL

Copiar
SELECT emp.FirstName, ord.Amount
FROM HR.Employee AS emp 
INNER JOIN Sales.SalesOrder AS ord
    ON emp.EmployeeID = ord.EmployeeID;
Al escribir consultas mediante combinaciones internas, tenga en cuenta las instrucciones siguientes:

Se prefieren alias de tabla, no solo para la lista SELECT, sino también para escribir la cláusula ON.
Las combinaciones internas se pueden realizar en una sola columna coincidente, como OrderID, o bien en varios atributos coincidentes, como la combinación de OrderID y ProductID. Las combinaciones que especifican varias columnas coincidentes se denominan combinaciones compuestas.
El orden de enumeración de las tablas en la cláusula FROM de una operación INNER JOIN no es importante para el optimizador de SQL Server. Conceptualmente, las combinaciones se evaluarán de izquierda a derecha.
Use la palabra clave JOIN una vez para cada par de tablas combinadas de la lista FROM. Para una consulta de dos tablas, especifique una combinación. Para una consulta de tres tablas, usará JOIN dos veces; una vez entre las dos primeras tablas y una segunda entre la salida de JOIN entre las dos primeras tablas y la tercera.
Ejemplos de INNER JOIN
En el ejemplo hipotético siguiente se realiza una combinación en una sola columna coincidente, lo que relaciona ProductModelID de la tabla Production.Product con ProductModelID de la tabla Production.ProductModel:

SQL

Copiar
SELECT p.ProductID, m.Name AS Model, p.Name AS Product
FROM Production.Product AS p
INNER JOIN Production.ProductModel AS m
    ON p.ProductModelID = m.ProductModelID
ORDER BY p.ProductID;
En el ejemplo siguiente se muestra cómo se puede extender una combinación interna para incluir más de dos tablas. La tabla Sales.SalesOrderDetail se une a la salida de JOIN entre Production.Product y Production.ProductModel. Cada instancia de JOIN/ON realiza sus propias operaciones de rellenado y filtrado de la tabla de salida virtual. El optimizador de consultas de SQL Server determina el orden en el que se realizarán las combinaciones y el filtrado.

SQL

Copiar
SELECT od.SalesOrderID, m.Name AS Model, p.Name AS ProductName, od.OrderQty
FROM Production.Product AS p
INNER JOIN Production.ProductModel AS m
    ON p.ProductModelID = m.ProductModelID
INNER JOIN Sales.SalesOrderDetail AS od
    ON p.ProductID = od.ProductID
ORDER BY od.SalesOrderID;


Uso de combinaciones externas
Completado
100 XP
6 minutos
Aunque no es tan común como las combinaciones internas, el uso de combinaciones externas en una consulta de varias tablas puede proporcionar una vista alternativa de los datos empresariales. Como sucede con las combinaciones internas, expresará una relación lógica entre las tablas. Pero no solo recuperará las filas con atributos coincidentes, sino también todas las filas presentes en una tablas o las dos, independientemente de si hay o no una coincidencia en la otra tabla.

Anteriormente, ha aprendido a usar INNER JOIN para buscar filas coincidentes entre dos tablas. Como ha visto, el procesador de consultas genera los resultados de una consulta INNER JOIN filtrando las filas que no cumplen las condiciones expresadas en el predicado de la cláusula ON. El resultado es que solo se devuelven las filas con una fila coincidente en la otra tabla. Con OUTER JOIN, puede optar por mostrar todas las filas que tienen filas coincidentes entre las tablas, además de todas las filas que no tienen ninguna coincidencia en la otra tabla. Ahora se verá un ejemplo y, después, se examinará el proceso.

En primer lugar, examine la consulta siguiente, escrita con INNER JOIN:

SQL

Copiar
SELECT emp.FirstName, ord.Amount
FROM HR.Employee AS emp
INNER JOIN Sales.SalesOrder AS ord
    ON emp.EmployeeID = ord.EmployeeID;
Estas filas representan una coincidencia entre HR.Employee y Sales.SalesOrder. En los resultados solo aparecerán los valores EmployeeID que están en ambas tablas.

A Venn diagram showing the matching members of the Employee and SalesOrder sets

Ahora, se examinará la siguiente consulta, escrita como LEFT OUTER JOIN:

SQL

Copiar
SELECT emp.FirstName, ord.Amount
FROM HR.Employee AS emp
LEFT OUTER JOIN Sales.SalesOrder AS ord
    ON emp.EmployeeID = ord.EmployeeID;
En este ejemplo se usa un operador LEFT OUTER JOIN, que indica al procesador de consultas que conserve todas las filas de la tabla de la izquierda (HR.Employee) y muestre los valores Amount para las filas coincidentes en Sales.SalesOrder. Pero se devuelven todos los empleados, independientemente de si han realizado o no un pedido de ventas. En lugar del valor Amount, la consulta devolverá NULL para los empleados sin pedidos de ventas correspondientes.

A Venn diagram showing the outer join results of the Employee and SalesOrder sets

Sintaxis de OUTER JOIN
Las combinaciones externas se expresan mediante las palabras clave LEFT, RIGHT o FULL, que se colocan por delante de OUTER JOIN. El propósito de la palabra clave es indicar qué tabla (en qué lado de la palabra clave JOIN) se debe conservar y mostrar todas sus filas, haya coincidencias o no.

Al usar LEFT, RIGHT o FULL para definir una combinación, puede omitir la palabra clave OUTER como se muestra aquí:

SQL

Copiar
SELECT emp.FirstName, ord.Amount
FROM HR.Employee AS emp
LEFT JOIN Sales.SalesOrder AS ord
    ON emp.EmployeeID = ord.EmployeeID;
Pero como sucede con la palabra clave INNER, a menudo resulta útil escribir código que indique de forma explícita el tipo de combinación que se usa.

Al escribir consultas mediante OUTER JOIN, tenga en cuenta las instrucciones siguientes:

Como ha visto, se prefieren alias de tabla, no solo para la lista SELECT, sino también para la cláusula ON.
Como sucede con INNER JOIN, se puede realizar una operación OUTER JOIN en una sola columna coincidente o en varios atributos coincidentes.
A diferencia de INNER JOIN, el orden en el que las tablas se enumeran y se unen en la cláusula FROM sí importa con OUTER JOIN, ya que determinará si elige LEFT o RIGHT para la combinación.
Las combinaciones de varias tablas son más complejas cuando se usa OUTER JOIN. La presencia de valores NULL en los resultados de OUTER JOIN puede provocar problemas si los resultados intermedios se combinan a una tercera tabla. El predicado de la segunda combinación puede filtrar las filas con valores NULL.
Para mostrar solo las filas en las que no existe ninguna coincidencia, agregue una prueba de NULL en una cláusula WHERE después de un predicado OUTER JOIN.
FULL OUTER JOIN rara vez se usa. Devuelve todas las filas coincidentes entre las dos tablas, más todas las filas de la primera tabla sin coincidencia en la segunda, además de todas las filas de la segunda sin coincidencia en la primera.
No hay ninguna manera de predecir el orden en que se devolverán las filas sin una cláusula ORDER BY. No hay ninguna manera de saber si primero se devolverán las filas coincidentes o las no coincidentes.


Uso de combinaciones cruzadas
Completado
100 XP
3 minutos
Una combinación cruzada es simplemente un producto cartesiano de las dos tablas. Con la sintaxis ANSI SQL-89, puede excluir el filtro que conecta las dos tablas para crear una combinación cruzada. Con la sintaxis ANSI-92, es un poco más difícil, lo que es positivo porque, en general, una combinación cruzada no es algo que normalmente le interesará. Con la sintaxis ANSI-92, es muy poco probable que termine con una combinación cruzada accidentalmente.

Para crear de forma explícita un producto cartesiano, use el operador CROSS JOIN.

Esta operación crea un conjunto de resultados con todas las combinaciones posibles de las filas de entrada:

SQL

Copiar
SELECT <select_list>
FROM table1 AS t1
CROSS JOIN table2 AS t2;
Aunque este resultado no suele ser una salida deseada, hay algunas aplicaciones prácticas para escribir una operación CROSS JOIN explícita:

Crear una tabla de números, con una fila para cada valor posible de un intervalo.
Generar grandes volúmenes de datos para pruebas. Cuando se le aplica una combinación cruzada a sí misma, una tabla con tan solo 100 filas puede generar fácilmente 10 000 filas de salida.
Sintaxis de CROSS JOIN
Al escribir consultas mediante CROSS JOIN, tenga en cuenta las instrucciones siguientes:

No se realiza ninguna coincidencia de filas, por lo que no se usa ninguna cláusula ON. (Es un error usar una cláusula ON con CROSS JOIN).
Para usar la sintaxis ANSI SQL-92, separe los nombres de tabla de entrada con el operador CROSS JOIN.
La consulta siguiente es un ejemplo del uso de CROSS JOIN para crear todas las combinaciones de empleados y productos:

SQL

Copiar
SELECT emp.FirstName, prd.Name
FROM HR.Employee AS emp
CROSS JOIN Production.Product AS prd;


Uso de autocombinaciones
Completado
100 XP
3 minutos
Hasta ahora, en las combinaciones que se han usado participaban tablas diferentes. Es posible que haya escenarios en los que tenga que recuperar y comparar filas de una tabla con otras filas de la misma tabla. Por ejemplo, en una aplicación de recursos humanos, una tabla Employee podría incluir información sobre el jefe de cada empleado y almacenar el identificador del jefe en la propia fila del empleado. Cada jefe también aparece como empleado.

EmployeeID (Id. de empleado)

FirstName

ManagerID

1

Dan

NULL

2

Aisha

1

3

Rosie

1

4

Naomi

3

Para recuperar la información de los empleados y hacerla coincidir con el jefe relacionado, puede usar la tabla dos veces en la consulta, y combinarla con sí misma para los fines de la consulta.

SQL

Copiar
SELECT emp.FirstName AS Employee, 
       mgr.FirstName AS Manager
FROM HR.Employee AS emp
LEFT OUTER JOIN HR.Employee AS mgr
  ON emp.ManagerID = mgr.EmployeeID;
Los resultados de esta consulta incluyen una fila para cada empleado con el nombre de su jefe. El director general de la empresa no tiene ningún jefe. Para incluir al director general en los resultados, se usa una combinación externa y el nombre del jefe se devuelve como NULL para las filas en las que el campo ManagerID no tiene ningún campo EmployeeID coincidente.

Empleado

Manager

Dan

NULL

Aisha

Dan

Rosie

Dan

Naomi

Rosie

Hay otros escenarios en los que querrá comparar filas de una tabla con otras filas de la misma tabla. Como ha visto, es bastante fácil comparar columnas de la misma fila mediante T-SQL, pero el método para comparar valores de filas diferentes (como una fila que almacena una hora de inicio y otra de la misma tabla que almacena una hora de finalización correspondiente) es menos obvio. Las autocombinaciones son una técnica útil para estos tipos de consultas.

Para realizar tareas como esta, debe tener en cuenta las instrucciones siguientes:

Defina dos instancias de la misma tabla en la cláusula FROM y combínelas según sea necesario, mediante combinaciones internas o externas.
Use alias de tabla para diferenciar las dos instancias de la misma tabla.
Use la cláusula ON para proporcionar un filtro que compare las columnas de una instancia de la tabla con las columnas de la otra instancia.



<===============================================================>
Sugerencia : A medida que sigue las instrucciones de este panel, cada vez que vea un ícono , puede usarlo para copiar texto del panel de instrucciones a la interfaz de la máquina virtual.

Si se le solicita que inicie sesión, inicie sesión en la cuenta de estudiante con la contraseña Pa55w.rd . Si se le solicita que permita que su PC sea detectable, seleccione No .

Consulta varias tablas con uniones
En esta práctica de laboratorio, utilizará la instrucción SELECT de Transact-SQL para consultar varias tablas en la base de datos de adventureworks . Para su referencia, el siguiente diagrama muestra las tablas en la base de datos (es posible que deba cambiar el tamaño del panel para verlas claramente).

Un diagrama entidad-relación de la base de datos Adventureworks

Nota : si está familiarizado con la base de datos de muestra estándar de AdventureWorks , puede notar que en esta práctica de laboratorio estamos usando una versión simplificada que facilita el enfoque en el aprendizaje de la sintaxis de Transact-SQL.

Usar uniones internas
Una combinación interna se usa para encontrar datos relacionados en dos tablas. Por ejemplo, suponga que necesita recuperar datos sobre un producto y su categoría de las tablas SalesLT.Product y SalesLT.ProductCategory . Puede encontrar el registro de categoría de producto relevante para un producto en función de su campo ProductCategoryID ; que es una clave externa en la tabla de productos que coincide con una clave principal en la tabla de categorías de productos.

Inicie Azure Data Studio y cree una nueva consulta (puede hacerlo desde el menú Archivo o en la página de bienvenida ).

En el nuevo panel SQLQuery_… , use el botón Conectar para conectar la consulta a la conexión guardada de AdventureWorks .

En el editor de consultas, ingrese el siguiente código:

SELECT SalesLT.Product.Name As ProductName, SalesLT.ProductCategory.Name AS Category
FROM SalesLT.Product
INNER JOIN SalesLT.ProductCategory
ON SalesLT.Product.ProductCategoryID = SalesLT.ProductCategory.ProductCategoryID;
Use el botón ⏵Ejecutar para ejecutar la consulta y, después de unos segundos, revise los resultados, que incluyen el Nombre del producto de la tabla de productos y la Categoría correspondiente de la tabla de categorías de productos. Debido a que la consulta utiliza una combinación INNER , los productos que no tienen categorías correspondientes y las categorías que no contienen productos se omiten de los resultados.

Modifique la consulta de la siguiente manera para eliminar la palabra clave INNER y vuelva a ejecutarla.

SELECT SalesLT.Product.Name As ProductName, SalesLT.ProductCategory.Name AS Category
FROM SalesLT.Product
JOIN SalesLT.ProductCategory
    ON SalesLT.Product.ProductCategoryID = SalesLT.ProductCategory.ProductCategoryID;
Los resultados deben ser los mismos que antes. Las uniones INNER son el tipo de unión predeterminado.

Modifique la consulta para asignar alias a las tablas en la cláusula JOIN , como se muestra aquí:

SELECT p.Name As ProductName, c.Name AS Category
FROM SalesLT.Product AS p
JOIN SalesLT.ProductCategory As c
    ON p.ProductCategoryID = c.ProductCategoryID;
Ejecute la consulta modificada y confirme que devuelve los mismos resultados que antes. El uso de alias de tabla puede simplificar enormemente una consulta, especialmente cuando se deben usar varias uniones.

Reemplace la consulta con el siguiente código, que recupera los datos del pedido de ventas de las tablas SalesLT.SalesOrderHeader , SalesLT.SalesOrderDetail y SalesLT.Product :

SELECT oh.OrderDate, oh.SalesOrderNumber, p.Name As ProductName, od.OrderQty, od.UnitPrice, od.LineTotal
FROM SalesLT.SalesOrderHeader AS oh
JOIN SalesLT.SalesOrderDetail AS od
    ON od.SalesOrderID = oh.SalesOrderID
JOIN SalesLT.Product AS p
    ON od.ProductID = p.ProductID
ORDER BY oh.OrderDate, oh.SalesOrderID, od.SalesOrderDetailID;
Ejecute la consulta modificada y tenga en cuenta que devuelve datos de las tres tablas.

Usar uniones externas
Una combinación externa se usa para recuperar todas las filas de una tabla y las filas correspondientes de una tabla relacionada. En los casos en que una fila de la tabla externa no tiene filas correspondientes en la tabla relacionada, se devuelven valores NULL para los campos de la tabla relacionada. Por ejemplo, suponga que desea recuperar una lista de todos los clientes y cualquier pedido que hayan realizado, incluidos los clientes que se han registrado pero que nunca realizaron un pedido.

Reemplace la consulta existente con el siguiente código:

SELECT c.FirstName, c.LastName, oh.SalesOrderNumber
FROM SalesLT.Customer AS c
LEFT OUTER JOIN SalesLT.SalesOrderHeader AS oh
    ON c.CustomerID = oh.CustomerID
ORDER BY c.CustomerID;
Ejecute la consulta y tenga en cuenta que los resultados contienen datos para cada cliente. Si un cliente ha realizado un pedido, se muestra el número de pedido. Los clientes que se han registrado pero no han realizado un pedido se muestran con un número de pedido NULL .

Tenga en cuenta el uso de la palabra clave LEFT . Esto identifica cuál de las tablas de la combinación es la tabla externa (aquella de la que se deben conservar todas las filas). En este caso, la combinación se encuentra entre las tablas Customer y SalesOrderHeader , por lo que una combinación IZQUIERDA designa a Customer como la tabla externa. Si se hubiera utilizado una unión DERECHA , la consulta habría devuelto todos los registros de la tabla SalesOrderHeader y solo los datos coincidentes de la tabla Customer** (en otras palabras, todos los pedidos, incluidos aquellos para los que no había un registro de cliente coincidente). También puede usar una combinación externa *FULL para conservar las filas no coincidentes de *ambaslados de la combinación (todos los clientes, incluidos los que no han realizado un pedido; y todos los pedidos, incluidos los que no tienen un cliente coincidente), aunque en la práctica esto se usa con menos frecuencia.

Modifique la consulta para eliminar la palabra clave OUTER , como se muestra aquí:

SELECT c.FirstName, c.LastName, oh.SalesOrderNumber
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.SalesOrderHeader AS oh
    ON c.CustomerID = oh.CustomerID
ORDER BY c.CustomerID;
Ejecute la consulta y revise los resultados, que deberían ser los mismos que antes. El uso de la palabra clave IZQUIERDA (o DERECHA ) identifica automáticamente la unión como una unión EXTERNA .

Modifique la consulta como se muestra a continuación para aprovechar el hecho de que identifica filas que no coinciden y devolver solo los clientes que no han realizado ningún pedido.

SELECT c.FirstName, c.LastName, oh.SalesOrderNumber
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.SalesOrderHeader AS oh
    ON c.CustomerID = oh.CustomerID
WHERE oh.SalesOrderNumber IS NULL 
ORDER BY c.CustomerID;
Ejecute la consulta y revise los resultados, que contienen datos de clientes que no han realizado ningún pedido.

Reemplace la consulta con la siguiente, que usa combinaciones externas para recuperar datos de tres tablas.

SELECT p.Name As ProductName, oh.SalesOrderNumber
FROM SalesLT.Product AS p
LEFT JOIN SalesLT.SalesOrderDetail AS od
    ON p.ProductID = od.ProductID
LEFT JOIN SalesLT.SalesOrderHeader AS oh
    ON od.SalesOrderID = oh.SalesOrderID
ORDER BY p.ProductID;
Ejecute la consulta y observe que los resultados incluyen todos los productos, con números de pedido para cualquiera que haya sido comprado. Esto requería una secuencia de uniones de Product a SalesOrderDetail a SalesOrderHeader . Tenga en cuenta que cuando une varias tablas como esta, después de especificar una unión externa en la secuencia de unión, todas las uniones externas subsiguientes deben tener la misma dirección ( IZQUIERDA o DERECHA ).

Modifique la consulta como se muestra a continuación para agregar una unión interna para devolver información de categoría. Al mezclar combinaciones internas y externas, puede ser útil ser explícito acerca de los tipos de combinación utilizando las palabras clave INNER y OUTER .

SELECT p.Name As ProductName, c.Name AS Category, oh.SalesOrderNumber
FROM SalesLT.Product AS p
LEFT OUTER JOIN SalesLT.SalesOrderDetail AS od
    ON p.ProductID = od.ProductID
LEFT OUTER JOIN SalesLT.SalesOrderHeader AS oh
    ON od.SalesOrderID = oh.SalesOrderID
INNER JOIN SalesLT.ProductCategory AS c
    ON p.ProductCategoryID = c.ProductCategoryID
ORDER BY p.ProductID;
Ejecute la consulta y revise los resultados, que incluyen nombres de productos, categorías y números de pedidos de ventas.

Usar una unión cruzada
Una unión cruzada coincide con todas las combinaciones posibles de filas de las tablas que se unen. En la práctica, rara vez se usa; pero hay algunos casos especializados donde es útil.

Reemplace la consulta existente con el siguiente código:

SELECT p.Name, c.FirstName, c.LastName, c.EmailAddress
FROM SalesLT.Product as p
CROSS JOIN SalesLT.Customer as c;
Ejecute la consulta y tenga en cuenta que los resultados contienen una fila para cada combinación de producto y cliente (que podría usarse para crear una campaña de correo en la que se envía por correo electrónico un anuncio individual para cada producto a cada cliente, una estrategia que puede no ganarse el cariño de la empresa). sus clientes!).

Usar una autounión
Una unión automática no es en realidad un tipo específico de unión, pero es una técnica utilizada para unir una tabla a sí misma definiendo dos instancias de la tabla, cada una con su propio alias. Este enfoque puede ser útil cuando una fila de la tabla incluye un campo de clave externa que hace referencia a la clave principal de la misma tabla; por ejemplo, en una tabla de empleados donde el gerente de un empleado también es un empleado, o una tabla de categorías de productos donde cada categoría puede ser una subcategoría de otra categoría.

Reemplace la consulta existente con el siguiente código, que incluye una unión automática entre dos instancias de la tabla SalesLT.ProductCategory (con alias cat y pcat ):

SELECT pcat.Name AS ParentCategory, cat.Name AS SubCategory
FROM SalesLT.ProductCategory as cat
JOIN SalesLT.ProductCategory pcat
    ON cat.ParentProductCategoryID = pcat.ProductCategoryID
ORDER BY ParentCategory, SubCategory;
Ejecute la consulta y revise los resultados, que reflejan la jerarquía de las categorías principales y secundarias.

Desafíos
Ahora que ha visto algunos ejemplos de uniones, es su turno de intentar recuperar datos de varias tablas por sí mismo.

Sugerencia : intente determinar las consultas adecuadas para usted. Si se queda atascado, las respuestas sugeridas se proporcionan al final de este laboratorio.

Desafío 1: generar informes de facturas
Adventure Works Cycles vende directamente a minoristas, a quienes se les debe facturar por sus pedidos. Se le ha asignado la tarea de escribir una consulta para generar una lista de facturas que se enviarán a los clientes.

Recuperar pedidos de clientes
Como paso inicial para generar el informe de facturas, escriba una consulta que devuelva el nombre de la empresa de la tabla SalesLT.Customer y el ID del pedido de ventas y el total adeudado de la tabla SalesLT.SalesOrderHeader .
Recuperar pedidos de clientes con direcciones
Amplíe su consulta de pedidos de clientes para incluir la dirección de la oficina principal de cada cliente, incluida la dirección postal completa, la ciudad, el estado o la provincia, el código postal y el país o la región.
Sugerencia : tenga en cuenta que cada cliente puede tener varios destinatarios en la tabla SalesLT.Address , por lo que el desarrollador de la base de datos ha creado la tabla SalesLT.CustomerAddress para habilitar una relación de muchos a muchos entre clientes y direcciones. Su consulta deberá incluir ambas tablas y debe filtrar los resultados para que solo se incluyan las direcciones de la oficina principal .
Desafío 2: recuperar datos de clientes
A medida que continúa trabajando con los datos de ventas y clientes de Adventure Works, debe crear consultas para los informes que ha solicitado el equipo de ventas.

Recuperar una lista de todos los clientes y sus pedidos
El gerente de ventas desea una lista de todas las empresas cliente y sus contactos (nombre y apellido), que muestre el ID del pedido de ventas y el total adeudado para cada pedido que hayan realizado. Los clientes que no hayan realizado ningún pedido deben incluirse en la parte inferior de la lista con valores NULL para el ID del pedido y el total adeudado.
Recuperar una lista de clientes sin dirección
Un empleado de ventas notó que Adventure Works no tiene información de dirección para todos los clientes. Debe escribir una consulta que devuelva una lista de ID de clientes, nombres de empresas, nombres de contactos (nombre y apellido) y números de teléfono de clientes sin direcciones almacenadas en la base de datos.
Desafío 3: Crear un catálogo de productos
El equipo de marketing le ha pedido que recupere datos para un nuevo catálogo de productos.

Recuperar información de productos por categoría
El catálogo de productos enumerará los productos por categoría principal y subcategoría, por lo que debe escribir una consulta que recupere los campos de nombre de categoría principal, nombre de subcategoría y nombre de producto para el catálogo.
Soluciones de desafío
Esta sección contiene soluciones sugeridas para las consultas de desafío.

Desafío 1
Recuperar pedidos de clientes:

SELECT c.CompanyName, oh.SalesOrderID, oh.TotalDue
FROM SalesLT.Customer AS c
JOIN SalesLT.SalesOrderHeader AS oh
    ON oh.CustomerID = c.CustomerID;
Recuperar pedidos de clientes con direcciones:

SELECT c.CompanyName,
       a.AddressLine1,
       ISNULL(a.AddressLine2, '') AS AddressLine2,
       a.City,
       a.StateProvince,
       a.PostalCode,
       a.CountryRegion,
       oh.SalesOrderID,
       oh.TotalDue
FROM SalesLT.Customer AS c
JOIN SalesLT.SalesOrderHeader AS oh
    ON oh.CustomerID = c.CustomerID
JOIN SalesLT.CustomerAddress AS ca
    ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address AS a
    ON ca.AddressID = a.AddressID
WHERE ca.AddressType = 'Main Office';
Desafío 2
Recuperar una lista de todos los clientes y sus pedidos:

SELECT c.CompanyName, c.FirstName, c.LastName,
       oh.SalesOrderID, oh.TotalDue
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.SalesOrderHeader AS oh
    ON c.CustomerID = oh.CustomerID
ORDER BY oh.SalesOrderID DESC;
Recuperar una lista de clientes sin dirección:

SELECT c.CompanyName, c.FirstName, c.LastName, c.Phone
FROM SalesLT.Customer AS c
LEFT JOIN SalesLT.CustomerAddress AS ca
    ON c.CustomerID = ca.CustomerID
WHERE ca.AddressID IS NULL;
Desafío 3
Recuperar información de productos por categoría:

SELECT pcat.Name AS ParentCategory, cat.Name AS SubCategory, prd.Name AS ProductName
FROM SalesLT.ProductCategory pcat
JOIN SalesLT.ProductCategory as cat
    ON pcat.ProductCategoryID = cat.ParentProductCategoryID
JOIN SalesLT.Product as prd
    ON prd.ProductCategoryID = cat.ProductCategoryID
ORDER BY ParentCategory, SubCategory, ProductName;
Volver a Microsoft Learn
Cuando haya terminado el ejercicio, complete la verificación de conocimientos en Microsoft Learn.
Cuando el enlace anterior se abra en otra pestaña del navegador, vuelva a esta para finalizar el entorno de laboratorio.

<====>
puedo ocupar esta consulta en laravel

SELECT cate.CompanyName, oh.SalesOrderID, oh.TotalDueFROM SalesLT.Customer AS cate JOIN SalesLT.SalesOrderHeader AS ohON oh.CustomerID = cate.CustomerID;
