Examen de la instrucción SELECT
Completado
100 XP
3 minutos
Transact-SQL o T-SQL es un dialecto del lenguaje SQL estándar de ANSI que usan los productos y servicios de Microsoft SQL. Es similar a SQL estándar. La mayor parte de nuestro enfoque se centrará en la instrucción SELECT, que, con diferencia, es la instrucción DML que tiene mayor número de opciones y variaciones.

Para empezar, echemos un vistazo de alto nivel a cómo se procesa una instrucción SELECT. El orden en el que se escribe una instrucción SELECT no es el orden en que el motor de base de datos de SQL Server la evalúa y procesa.

Considere la consulta siguiente:

SQL

Copiar
SELECT OrderDate, COUNT(OrderID) AS Orders
FROM Sales.SalesOrder
WHERE Status = 'Shipped'
GROUP BY OrderDate
HAVING COUNT(OrderID) > 1
ORDER BY OrderDate DESC;
La consulta consta de una instrucción SELECT, que se compone de varias cláusulas, cada una de las cuales define una operación específica que se debe aplicar a los datos que se recuperan. Antes de examinar el orden de las operaciones en tiempo de ejecución, echemos un vistazo brevemente a lo que hace esta consulta, aunque los detalles de las diferentes cláusulas no se tratarán en este módulo.

La cláusula SELECT devuelve la columna OrderDate y el recuento de valores OrderID, a los que se asigna el nombre (o alias) Orders:

SQL

Copiar
SELECT OrderDate, COUNT(OrderID) AS Orders
La cláusula FROM identifica qué tabla es el origen de las filas de la consulta; en este caso, es la tabla Sales.SalesOrder:

SQL

Copiar
FROM Sales.SalesOrder
La cláusula WHERE filtra las filas de los resultados, manteniendo solo las filas que cumplen la condición especificada; en este caso, los pedidos que tienen el estado "enviado":

SQL

Copiar
WHERE Status = 'Shipped'
La cláusula GROUP BY toma las filas que cumplen la condición del filtro y las agrupa por OrderDate, de modo que todas las filas con el mismo valor OrderDate se consideren como un único grupo y se devuelva una fila para cada grupo:

SQL

Copiar
GROUP BY OrderDate
Una vez formados los grupos, la cláusula HAVING filtra los grupos en función de su propio predicado. Solo las fechas con más de un pedido se incluirán en los resultados:

SQL

Copiar
HAVING COUNT(OrderID) > 1
Para obtener una vista previa de esta consulta, la cláusula final es ORDER BY, que ordena la salida en orden descendente de OrderDate:

SQL

Copiar
ORDER BY OrderDate DESC;
Ahora que ha visto lo que hace cada cláusula, echemos un vistazo al orden en que SQL Server las evalúa realmente:

La cláusula FROM se evalúa primero para proporcionar las filas de origen para el resto de la instrucción. Se crea una tabla virtual y se pasa al paso siguiente.
La cláusula WHERE es la siguiente en evaluarse, filtrando las filas de la tabla de origen que coinciden con un predicado. La tabla virtual filtrada se pasa al paso siguiente.
GROUP BY es la siguiente, que organiza las filas de la tabla virtual según los valores únicos que se encuentran en la lista GROUP BY. Se crea una nueva tabla virtual que contiene la lista de grupos y se pasa al paso siguiente. A partir de este punto del flujo de operaciones, otros elementos solo pueden hacer referencia a las columnas de la lista GROUP BY o a las funciones de agregado.
Después se avalúa la cláusula HAVING, que filtra grupos completos en función de su predicado. La tabla virtual creada en el paso 3 se filtra y se pasa al paso siguiente.
Por último, se ejecuta la cláusula SELECT, que determina qué columnas aparecerán en los resultados de la consulta. Dado que la cláusula SELECT se evalúa después de los otros pasos, los alias de columna (en nuestro ejemplo, Orders)creados allí no se pueden usar en las cláusulas GROUP BY o HAVING.
La cláusula ORDER BY es la última en ejecutarse, que ordena las filas según lo determinado por su lista de columnas.
Para aplicar este conocimiento a nuestra consulta de ejemplo, este es el orden lógico en tiempo de ejecución de la instrucción SELECT anterior:

SQL

Copiar
FROM Sales.SalesOrder
WHERE Status = 'Shipped'
GROUP BY OrderDate 
HAVING COUNT(OrderID) > 1
SELECT OrderDate, COUNT(OrderID) AS Orders
ORDER BY OrderDate DESC;
No todas las cláusulas posibles son necesarias en todas las instrucciones SELECT que escriba. La única cláusula necesaria es la cláusula SELECT, que se puede usar por sí misma en algunos casos. Normalmente, también se incluye una cláusula FROM para identificar la tabla que se está consultando. Además, Transact-SQL tiene otras cláusulas que se pueden agregar.

Como ha visto, no se escriben consultas T-SQL en el mismo orden en que se evalúan lógicamente. El orden de evaluación en tiempo de ejecución determina qué datos están disponibles para qué cláusulas, ya que una cláusula solo tiene acceso a la información ya disponible desde una cláusula ya procesada. Por esta razón, es importante comprender el verdadero orden de procesamiento lógico a la hora de escribir consultas.

Selección de todas las columnas
A menudo se hace referencia a la cláusula SELECT como la listaSELECT, ya que enumera los valores que se devolverán en los resultados de la consulta.

La forma más sencilla de una cláusula SELECT es el uso del carácter de asterisco (*) para devolver todas las columnas. Cuando se usa en consultas de T-SQL, se denomina estrella. Aunque SELECT * es adecuado para una prueba rápida, debe evitar usarlo en el trabajo de producción por los siguientes motivos:

Los cambios en la tabla que agregan o reorganizan columnas se reflejarán en los resultados de la consulta, lo que puede dar lugar a una salida inesperada para las aplicaciones o informes que usan la consulta.
La devolución de datos que no son necesarios puede ralentizar las consultas y provocar problemas de rendimiento si la tabla de origen contiene un gran número de filas.
Por ejemplo, en el ejemplo siguiente se recuperan todas las columnas de la tabla (hipotética) Production.Product.

SQL

Copiar
SELECT * FROM Production.Product;
El resultado de esta consulta es un conjunto de filas que contiene todas las columnas de todas las filas de la tabla, que podrían tener un aspecto parecido al siguiente:

ProductID

Nombre

ProductNum

Color

StandardCost

ListPrice

Tamaño

Peso

ProductCatID

680

HL Road Frame - Black, 58

FR-R92B-58

Negro

1059,31

1431,5

58

1016,04

18

706

HL Road Frame - Red, 58

FR-R92R-58

Rojo

1059,31

1431,5

58

1016,04

18

707

Sport-100 Helmet, Red

HL-U509-R

Rojo

13,0863

34,99

35

708

Sport-100 Helmet, Black

HL-U509

Negro

13,0863

34,99

35

...

...

...

...

...

...

...

...

...

Selección de columnas específicas
Una lista de columnas explícita le permite tener control sobre exactamente qué columnas se devuelven y en qué orden. Cada columna del resultado tendrá el nombre de la columna como encabezado.

Por ejemplo, considere la siguiente consulta, que usa de nuevo la hipotética tabla Production.Product.

SQL

Copiar
SELECT ProductID, Name, ListPrice, StandardCost
‎FROM Production.Product;
Esta vez, los resultados incluyen solo las columnas especificadas:

ProductID

Nombre

ListPrice

StandardCost

680

HL Road Frame - Black, 58

1431,5

1059,31

706

HL Road Frame - Red, 58

1431,5

1059,31

707

Sport-100 Helmet, Red

34,99

13,0863

708

Sport-100 Helmet, Black

34,99

13,0863

...

...

...

...

Selección de expresiones
Además de recuperar columnas almacenadas en la tabla especificada, una cláusula SELECT puede realizar cálculos y manipulaciones, que usan operadores para combinar columnas y valores o varias columnas. El resultado del cálculo o la manipulación debe ser un resultado de un solo valor (escalar) que aparecerá en el resultado como una columna independiente.

Por ejemplo, la consulta siguiente incluye dos expresiones:

SQL

Copiar
SELECT ProductID,
      Name + '(' + ProductNumber + ')',
  ListPrice - StandardCost
FROM Production.Product;
Los resultados de esta consulta podrían tener un aspecto parecido al siguiente:

ProductID

680

HL Road Frame - Black, 58(FR-R92B-58)

372,19

706

HL Road Frame - Red, 58(FR-R92R-58)

372,19

707

Sport-100 Helmet, Red(HL-U509-R)

21,9037

708

Sport-100 Helmet, Black(HL-U509)

21,9037

...

...

...

Hay un par de puntos interesantes sobre estos resultados que se deben resaltar:

Las columnas devueltas por las dos expresiones no tienen nombres de columna. En función de la herramienta que use para enviar la consulta, un nombre de columna que falta podría indicarse mediante un encabezado de columna en blanco, un indicador literal "sin nombre de columna" o un nombre predeterminado como column1. Más adelante en esta sección veremos cómo especificar un alias para el nombre de columna en la consulta.
La primera expresión usa el operador + para concatenar valores de cadena (basados en caracteres), mientras que la segunda expresión usa el operador - para restar un valor numérico a otro. Cuando se usa con valores numéricos, el operador + realiza la suma. Por tanto, está claro que es importante comprender los tipos de datos de las columnas que se incluyen en las expresiones. En la sección siguiente se tratarán los tipos de datos.
Especificación de alias de columna
Puede especificar un alias para cada columna que la consulta SELECT devuelve, ya sea como alternativa al nombre de la columna de origen o para asignar un nombre a la salida de una expresión.

Por ejemplo, esta es la misma consulta que antes, pero con alias especificados para cada una de las columnas:

SQL

Copiar
SELECT ProductID AS ID,
      Name + '(' + ProductNumber + ')' AS ProductName,
  ListPrice - StandardCost AS Markup
FROM Production.Product;
Los resultados de esta consulta incluyen los nombres de columna especificados:

ID

ProductName

marcado

680

HL Road Frame - Black, 58(FR-R92B-58)

372,19

706

HL Road Frame - Red, 58(FR-R92R-58)

372,19

707

Sport-100 Helmet, Red(HL-U509-R)

21,9037

708

Sport-100 Helmet, Black(HL-U509)

21,9037

...

...

...

 Nota

La palabra clave AS es opcional cuando se especifica un alias, pero es una buena práctica incluirla por motivos de esclarecimiento.

Formateo de consultas
Puede observar en los ejemplos de esta sección que tiene cierta flexibilidad a la hora de formatear el código de consulta. Por ejemplo, puede escribir cada cláusula (o la consulta completa) en una sola línea o dividirla en varias líneas. En la mayoría de los sistemas de base de datos, el código no distingue entre mayúsculas y minúsculas, y algunos elementos del lenguaje T-SQL son opcionales (incluida la palabra clave AS como se mencionó anteriormente e incluso el punto y coma al final de una instrucción).

Tenga en cuenta las siguientes pautas para que el código de T-SQL sea fácil de leer (y, por tanto, ¡más fácil de entender y depurar!):

Ponga en mayúsculas las palabras clave de T-SQL, como SELECT, FROM, AS, etc. La utilización de mayúsculas para las palabras clave es una convención de uso frecuente que facilita la búsqueda de cada cláusula de una instrucción compleja.
Inicie una nueva línea para cada cláusula principal de una instrucción.
Si la lista SELECT contiene más de unas pocas columnas, expresiones o alias, considere la posibilidad de enumerar cada columna en su propia línea.
Aplicar sangría a las líneas que contienen subcláusulas o columnas para dejar claro qué código pertenece a cada cláusula principal.