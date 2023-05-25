from math import ceil, floor

""" answer = 30 + 12
print(answer) """

""" Imagine que tenga que convertir un numero de segundos a minutos para su visualizacion """

def Convertidor():
    segundos = 1042
    #El primer paso consiste en determinar el número 
    # de minutos que hay en 1042 segundos. Con 60 
    # segundos en un minuto, puede dividir por 60 y 
    # obtener una respuesta de 17.3666667. El número 
    # que le interesa simplemente es 17. Se recomienda 
    # redondear hacia abajo, usando lo que se conoce como 
    # división de múltiplo inferior. Para realizar una 
    # división de este tipo en Python, debe utilizar //.
    minutos = 1042 // 60
    display_segundos = 1042 % 60

    print(minutos)
    print(display_segundos)
value = Convertidor()

""" Orden de las operaciones """
"""
Python respeta el orden de las operaciones en matemáticas. El orden de las operaciones determina que las expresiones se 
deben evaluar en este orden:

Paréntesis
Exponentes
Multiplicación y división
Suma y resta

Observe que se evalúan los paréntesis antes que cualquier 
otra operación. Usar paréntesis le permite asegurarse de 
que el código se ejecute de una manera predecible y el 
código resulta más fácil de leer y mantener. 
Como resultado, el procedimiento recomendado es usar 
paréntesis aunque el orden de las operaciones se evalúe 
de la misma manera sin ellos. En las dos líneas de código 
siguientes, la segunda es más comprensible porque el 
paréntesis indica claramente qué operación se realizará 
primero.
""" 

resultado_uno = 1032 + 26 * 2
resultado_dos = 1032 + (26 * 2)
print(resultado_dos)
print(resultado_uno)

def Distanci_entre_planetas():
    tierra = 149597870
    jupiter = 778547200
    if jupiter >= tierra:
        distancia_kilometro = jupiter - tierra
        print(distancia_kilometro)
        distancia = distancia_kilometro / 1.609344
        print(distancia)
    else:
        print("No hay resultados")
Distanci_entre_planetas()

""" Conversión de cadenas en números
Python admite dos tipos principales de números: números 
enteros (o int) y número de punto flotante (o float). 
La diferencia clave entre ambos es la existencia de un 
separador decimal; los enteros son números enteros, 
mientras que los números de punto flotante contienen un 
valor decimal.

Al convertir cadenas en números, debe indicar el tipo de 
número que desea crear. Tiene que decidir si necesita un 
separador decimal. Se usa int para realizar la conversión 
en un número entero y float para hacerlo en un número de 
punto flotante. """

def Convertir_Cadenas_a_numeros():
    entero = int('215')
    flotante = float('215.3')
    print(entero)
    print(flotante)
Convertir_Cadenas_a_numeros()

"""  Importante
Si usa un valor no válido para int o float, 
recibirá un error. """

"""Valores absolutos
En matemáticas, un valor absoluto es el número no negativo sin su signo. El uso de un valor absoluto puede ser útil en situaciones varias, incluido el ejemplo de búsqueda para determinar la distancia entre dos planetas. Considere los cálculos siguientes:"""

""" Pitón

Copiar
39 - 16
16 - 39
Observe que la diferencia entre las dos ecuaciones es que los números se invierten. Las respuestas son 23 y -23, respectivamente. Al determinar la distancia entre dos planetas, no importa el orden en el que se escriben los números, ya que la respuesta absoluta es la misma.

Use abs para convertir el valor negativo en su valor absoluto. Si hace la misma operación mediante abs (e imprime las respuestas), verá que muestra 23 para ambas ecuaciones. """

def valor_absoluto():
    variable_uno = 39 - 16
    variable_dos = 16 -39 
    print(abs(variable_uno))
    print(abs(variable_dos))
    print(round(14.5))
valor_absoluto()

""" Biblioteca matemática
Python tiene bibliotecas para proporcionar operaciones y cálculos más avanzados. Una de las más comunes es la biblioteca math. math permite hacer el redondeo con floor y ceil, proporcionar el valor de pi y muchas otras operaciones. Veamos cómo usar esta biblioteca para redondear hacia arriba o hacia abajo.

El redondeo de números permite quitar la parte decimal de un número de punto flotante. Puede optar por redondear siempre hacia arriba al número entero más cercano si usa ceil, o hacia abajo si usa floor. """

def Redondear():
    redondear_arriba = ceil(12.5)
    print(redondear_arriba)

    redondear_abajo = floor(12.5)
    print(redondear_abajo)
Redondear()


""" def Calculo_entre_sol_planeta():
    primer_planeta_input = input("Ingresa la primer distancia que quieras calcular")
    segundo_planeta_input = input("Ingresa la segunda distancia que quieras calcular")
    primer_planeta = int(primer_planeta_input)
    segundo_planeta = int(segundo_planeta_input)
    distancia_en_kilometros = segundo_planeta - primer_planeta
    print(distancia_en_kilometros)
Calculo_entre_sol_planeta() """

def Calculo_entre_planetas():
    Earht = int(input("Ingresa la distancia que quieres calcular: "))
    jupyter = int(input("Ingresa la distancia del segundo planeta que quieres medir: "))
    distance = jupyter - Earht

    if jupyter > Earht:
        print(abs(distance))
    else:
        print(abs(distance))

Calculo_entre_planetas()
