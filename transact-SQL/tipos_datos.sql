Trabajo con tipos de datos
Completado
100 XP
3 minutos
Las columnas y variables usadas en Transact-SQL tienen un tipo de datos. El comportamiento de los valores de las expresiones depende del tipo de datos de la columna o variable a la que se hace referencia. Por ejemplo, como vimos anteriormente, puede usar el operador + para concatenar dos valores de cadena o para agregar dos valores numéricos.

En la tabla siguiente se muestran los tipos de datos comunes admitidos en una base de datos de SQL Server.

Valor numérico exacto

Valor numérico aproximado

Carácter

Fecha y hora

Binary

Otros

TINYINT

FLOAT

char

fecha

binary

cursor

SMALLINT

real

varchar

time

varbinary

hierarchyid

int

text

datetime

imagen

sql_variant

bigint

NCHAR

datetime2

table

bit

NVARCHAR

smalldatetime

timestamp

decimal/numérico

ntext

datetimeoffset

UNIQUEIDENTIFIER

NUMERIC

Xml

money

geography

SMALLMONEY

geometry

 Nota

Para obtener más información sobre los distintos tipos de datos y sus atributos, visite la documentación de referencia de Transact-SQL.

Conversión de tipo de datos
Los valores de tipos de datos compatibles se pueden convertir implícitamente según sea necesario. Por ejemplo, supongamos que puede usar el operador + para agregar un número + a un número decimal o para concatenar un valor char de longitud fija y un valor varchar de longitud variable. Sin embargo, en algunos casos es posible que tenga que convertir explícitamente valores de un tipo de datos a otro; por ejemplo, intentar usar + para concatenar un valor varchar y un valor decimal producirá un error a menos que primero convierta el valor numérico en un tipo de datos de cadena compatible.

 Nota

Las conversiones implícitas y explícitas se aplican a determinados tipos de datos y algunas conversiones no son posibles. Utilice el gráfico documentación de referencia de Transact-SQL para obtener más información.

T-SQL incluye funciones que le ayudan a convertir explícitamente entre tipos de datos
CAST y TRY_CAST
La función CAST convierte un valor en un tipo de datos especificado si dicho valor es compatible con el tipo de datos de destino. Se devolverá un error si no es compatible.

Por ejemplo, la consulta siguiente usa CAST para convertir los valores integer de la columna ProductID en valores varchar (con un máximo de 4 caracteres) para concatenarlos con otro valor basado en caracteres:

SQL

Copiar
SELECT CAST(ProductID AS varchar(4)) + ': ' + Name AS ProductName
FROM Production.Product;
Los resultados posibles de esta consulta podrían tener un aspecto parecido al siguiente:

ProductName

680: HL Road Frame - Black, 58

706: HL Road Frame - Red, 58

707: Sport-100 Helmet, Red

708: Sport-100 Helmet, Black

...

Sin embargo, supongamos que la columna Size de la tabla Production.Product es una columna nvarchar (longitud variable, datos de texto Unicode) que contiene algunos tamaños numéricos (como 58) y algunos tamaños basados en texto (como "S", "M" o "L"). La consulta siguiente intenta convertir valores de esta columna en un tipo de datos integer:

SQL

Copiar
SELECT CAST(Size AS integer) As NumericSize
FROM Production.Product;
Esta consulta produce el siguiente error:

Error: Error de conversión al convertir el valor nvarchar "M" al tipo de datos int.

Dado que al menos algunos de los valores de la columna son numéricos, es posible que quiera convertir esos valores y pasar por alto los demás. Puede usar la función TRY_CAST para convertir tipos de datos.

SQL

Copiar
SELECT TRY_CAST(Size AS integer) As NumericSize
FROM Production.Product;
Los resultados esta vez podrían ser similares a los siguientes:

NumericSize

58

58

NULL

NULL

...

Los valores que se pueden convertir en un tipo de datos numérico se devuelven como valores decimales y los valores incompatibles se devuelven como NULL, que se usa para indicar que un valor es desconocido.

 Nota

Exploraremos las consideraciones para controlar los valores NULL más adelante en esta unidad.

CONVERT y TRY_CONVERT
CAST es la función de SQL del estándar ANSI para convertir entre tipos de datos y se usa en muchos sistemas de base de datos. En Transact-SQL, también puede usar la función CONVERT, como se muestra aquí:

SQL

Copiar
SELECT CONVERT(varchar(4), ProductID) + ': ' + Name AS ProductName
FROM Production.Product;
Una vez más, esta consulta devuelve el valor convertido al tipo de datos especificado de la siguiente forma:

ProductName

680: HL Road Frame - Black, 58

706: HL Road Frame - Red, 58

707: Sport-100 Helmet, Red

708: Sport-100 Helmet, Black

...

Al igual que CAST, CONVERT tiene una variante TRY_CONVERT que devuelve NULL para valores incompatibles.

Otra ventaja de usar CONVERT sobre CAST es que CONVERT también incluye un parámetro que permite especificar un estilo de formato al convertir valores numéricos y de fecha en cadenas. Por ejemplo, considere la siguiente consulta:

SQL

Copiar
SELECT SellStartDate,
       CONVERT(varchar(20), SellStartDate) AS StartDate,
       CONVERT(varchar(10), SellStartDate, 101) AS FormattedStartDate 
FROM SalesLT.Product;
Los resultados de esta consulta podrían tener un aspecto parecido al siguiente:

SellStartDate

StartDate

FormattedStartDate

2002-06-01T00:00:00

1 de junio de 2002 12:00 a. m.

1/6/2002

2002-06-01T00:00:00

1 de junio de 2002 12:00 a. m.

1/6/2002

2005-07-01T00:00:00

1 de julio de 2005 12:00 a. m.

01/07/2005

2005-07-01T00:00:00

1 de julio de 2005 12:00 a. m.

01/07/2005

...

...

...

 Nota

Para obtener más información sobre los códigos de formato de estilo que puede usar con CONVERT, consulte la documentación de referencia de Transact-SQL.

PARSE y TRY_PARSE
La función PARSE está diseñada para convertir cadenas con formato que representan valores numéricos o de fecha y hora. Por ejemplo, considere la siguiente consulta (que usa valores literales en lugar de valores de columnas de una tabla):

SQL

Copiar
SELECT PARSE('01/01/2021' AS date) AS DateValue,
   PARSE('$199.99' AS money) AS MoneyValue;
Los resultados de esta consulta son similares a los siguientes:

DateValue

MoneyValue

2021-01-01T00:00:00

199,99

De forma similar a CAST y CONVERT, PARSE tiene una variante TRY_PARSE que devuelve valores incompatibles como NULL.

 Nota

Al trabajar con tipos de datos decimales o numéricos, es posible que tenga que redondear a un número entero o establecer el separador decimal, que se puede lograr a través de la precisión y la escala. Para comprender mejor este concepto de precisión y escala, consulte la documentación de referencia de Transact-SQL.

STR
La función STR convierte un valor numérico en varchar.

Por ejemplo:

SQL

Copiar
SELECT ProductID,  '$' + STR(ListPrice) AS Price
FROM Production.Product;
Los resultados deberían ser parecidos a esto:

ProductID

Precio

680

$1432.00

706

$1432.00

707

35 USD

...

...

<=========>

Controlar valores NULL
Completado
100 XP
3 minutos
Un valor NULL significa que no hay ningún valor o es desconocido. No significa cero ni en blanco, ni siquiera una cadena vacía. Esos valores no son desconocidos. Se puede usar un valor NULL para los valores que aún no se han proporcionado, por ejemplo, cuando un cliente aún no ha proporcionado una dirección de correo electrónico. Como ha visto anteriormente, algunas funciones de conversión también pueden devolver un valor NULL si un valor no es compatible con el tipo de datos de destino.

A menudo, deberá realizar pasos especiales para tratar con los valores NULL. NULL es realmente un valor sin valor. Es desconocido. No es igual a nada y no es desigual a nada. NULL no es mayor ni menor que nada. No podemos decir nada sobre lo que es, pero a veces es necesario trabajar con valores NULL. Afortunadamente, T-SQL proporciona funciones para la conversión o sustitución de valores NULL.

ISNULL
La función ISNULL toma dos argumentos. El primero es una expresión que estamos probando. Si el valor de ese primer argumento es NULL, la función devuelve el segundo argumento. Si la primera expresión no es NULL, se devuelve sin cambios.

Por ejemplo, supongamos que la tabla Sales.Customer de una base de datos incluye una columna MiddleName que permite valores NULL. Al consultar esta tabla, en lugar de devolver NULL en el resultado, puede optar por devolver un valor específico, como "None".

SQL

Copiar
SELECT FirstName,
      ISNULL(MiddleName, 'None') AS MiddleIfAny,
      LastName
FROM Sales.Customer;
Los resultados de esta consulta podrían tener un aspecto parecido al siguiente:

FirstName

MiddleIfAny

LastName

Orlando

Hora

Gee

Keith

Ninguno

Howard

Donna

F.

Gonzales

...

...

...

 Nota

El valor sustituido por NULL debe ser el mismo tipo de datos que la expresión que se está evaluando. En el ejemplo anterior, MiddleName es varchar, por lo que el valor de reemplazo no podría ser numérico. Además, deberá elegir un valor que no aparecerá en los datos como un valor normal. A veces puede ser difícil encontrar un valor que nunca aparecerá en los datos.

El ejemplo anterior se ha controlado un valor NULL en la tabla de origen, pero se puede usar ISNULL con cualquier expresión que pueda devolver un valor NULL, incluido el anidamiento de una función TRY_CONVERT dentro de una función ISNULL.

COALESCE
La función ISNULL no es estándar de ANSI, por lo que puede que desee usar la función COALESCE en su lugar. COALESCE es un poco más flexible, ya que puede tomar un número variable de argumentos, cada uno de los cuales es una expresión. Devolverá la primera expresión de la lista que no sea NULL.

Si solo hay dos argumentos, COALESCE se comporta como ISNULL. Sin embargo, con más de dos argumentos, COALESCE se puede usar como alternativa a una expresión CASE de varias partes mediante ISNULL.

Si todos los argumentos son NULL, COALESCE devuelve NULL. Todas las expresiones deben devolver tipos de datos iguales o compatibles.

La sintaxis es la siguiente:

SQL

Copiar
SELECT COALESCE ( expression1, expression2, [ ,...n ] )
En el ejemplo siguiente se usa una tabla ficticia denominada HR.Wages, que incluye tres columnas que contienen información sobre las ganancias semanales de los empleados: la tarifa por hora, el salario semanal y una comisión por unidad vendida. No obstante, un empleado recibe solo un tipo de sueldo. Para cada empleado, una de esas tres columnas tendrá un valor y las otras dos serán NULL. Para determinar el importe total pagado a cada empleado, puede usar COALESCE para devolver solo el valor distinto de NULL que se encuentra en esas tres columnas.

SQL

Copiar
SELECT EmployeeID,
      COALESCE(HourlyRate * 40,
                WeeklySalary,
                Commission * SalesQty) AS WeeklyEarnings
FROM HR.Wages;
El resultado podría ser similar al siguiente:

EmployeeID (Id. de empleado)

WeeklyEarnings

1

899,76

2

1001,00

3

1298,77

...

...

NULLIF
La función NULLIF permite devolver NULL en determinadas condiciones. Esta función tiene aplicaciones útiles en áreas como la limpieza de datos, cuando desea reemplazar los caracteres en blanco o de marcador de posición por NULL.

NULLIF toma dos argumentos y devuelve NULL si son equivalentes. Si no son iguales, NULLIF devuelve el primer argumento.

En este ejemplo, NULLIF reemplaza un descuento de 0 por un valor NULL. Devuelve el valor de descuento si no es 0:

SQL

Copiar
SELECT SalesOrderID,
      ProductID,
      UnitPrice,
      NULLIF(UnitPriceDiscount, 0) AS Discount
FROM Sales.SalesOrderDetail;
El resultado podría ser similar al siguiente:

Id.OrdenVentas

ProductID

UnitPrice

Descuento

71774

836

356,898

NULL

71780

988

112,998

0,4

71781

748

818,7

NULL

71781

985

112,998

0,4

...

...

...

...

