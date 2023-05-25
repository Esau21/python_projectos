""" El operador or """
""" Puede conectar dos expresiones booleanas, o de prueba, mediante el operador booleano or. Para que toda la expresión se evalúe como True, al menos una de las subexpresiones debe ser true. Si ninguna de las subexpresiones es true, toda la expresión se evalúa como False. Por ejemplo, en la expresión siguiente, toda la expresión de prueba se evalúa como True, porque se ha cumplido una de las condiciones de las subexpresiones: """
""" a = 23
b = 34
if a == 34 or b ==34:
    print(a + b) """

""" El operador and """
""" También puede conectar dos expresiones de prueba mediante el operador booleano and. Las dos condiciones de la expresión de prueba deben cumplirse para que toda la expresión de prueba se evalúe como True. En cualquier otro caso, la expresión de prueba es False. En el ejemplo siguiente, toda la expresión de prueba se evalúa como False, porque solo una de las condiciones de las subexpresiones es true: """

a = 23
b = 34

if a == 34 and b == 34:
    print(a + b)