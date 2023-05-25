""" a = 93
b = 27

if a >= b:
    print(a)
else:
    print(b) """

""" Uso de elif """
""" En Python, la palabra clave elif es la abreviatura de else if. El uso de instrucciones elif permite agregar varias expresiones de prueba al programa. Estas instrucciones se ejecutan en el orden en que se escriben, por lo que el programa escribirá una instrucción elif solo si la primera instrucción if es False. Por ejemplo: """

""" a = 93
b = 27

if a >= b:
    print("a es mayor o igual que b")
elif a == b:
    print("a es igual que b")

La instrucción elif de este bloque de código no se ejecutará, porque la instrucción if es True.

La sintaxis de una instrucción if/elif siempre es la siguiente:

Python

Copiar
if test_expression:
    # statement(s) to be run
elif test_expression:
    # statement(s) to be run """

""" Combinacion de if elif y else """
""" Puede combinar instrucciones if, elif y else para crear programas con lógica condicional compleja. Recuerde que una instrucción elif solo se ejecuta cuando la condición if es false. Tenga en cuenta también que un bloque if solo puede tener un bloque else, pero puede tener varios bloques elif.

Ahora se volverá a examinar el ejemplo con una instrucción elif agregada: """

""" def expresion():
    a = 93
    b = 27
    if a > b:
        print("a es mayor a b")
    elif a < b:
        print("a es menor que b")
    else:
        print("a es igual que b")
value = expresion() """

""" Uso de lógica condicional anidada """
""" Python también admite la lógica condicional anidada, lo que significa que puede anidar instrucciones if, elif y else para crear programas aún más complejos. Para anidar condiciones, aplique sangría a las condiciones internas y todo lo que esté en el mismo nivel de sangría se ejecutará en el mismo bloque de código: """

""" def expresion():
    a = 16
    b = 25
    c = 27
    if a > b:
        if b > c:
            print("a es mayor que b y b es mayor que c")
        else:
            print("a es mayor b y b es menor que")
    elif a == b:
        print("a es igual que b")
    else:
        print("a es menor que b")
value = expresion() """