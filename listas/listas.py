""" planeta = ["Mercury","Venus","Saturno","Earth","Mars","Neptune","Jupiter","Uranus"]
print(planeta) """

""" Acceso a elementos de lista por índice """
""" Puede acceder a cualquier elemento de una lista colocando el índice entre corchetes [] después del nombre de la variable de lista. Los índices comienzan a partir de 0, por lo que en el código siguiente, planets[0] es el primer elemento de la lista planets: """

""" esto tambien se le puede denominar como un array multidimencional en python para acceder a cada uno de los indices """

planeta = ["Mercury","Venus","Saturno","Earth","Mars","Neptune","Jupiter","Uranus"]
print("The first planet is", planeta[0])
print("The seconds planet is", planeta[1])


planeta[3] = 'Planeta Red'

print("Mars is also known as", planeta[3])

""" Determinación de la longitud de una lista
Para obtener la longitud de una lista, use la función integrada len(). El código siguiente crea una variable, number_of_planets. El código asigna esa variable con el número de elementos de la lista planets (8). """
number_of_planets = len(planeta)
print("There are", number_of_planets, "planets in the solar system.")

""" Incorporación de valores a listas
Las listas de Python son dinámicas: puede agregar y quitar elementos después de crearlas. Para agregar un elemento a una lista, use el método .append(value).

Por ejemplo, el código siguiente agrega la cadena "Pluto" al final de la lista planets: """

planeta.append("Pluto")
number_of_planets = len(planeta)
print("There are actually", number_of_planets, "planets in the solar system.")

""" Eliminación de valores de listas
Puede quitar el último elemento de una lista llamando al método .pop() en la variable de lista: """

planeta.pop()
number_of_planets = len(planeta)
print("No, there are definitely", number_of_planets, "Goodbye Pluto")
print("There first planet is", planeta[0])
"""Los índices comienzan en cero y van en aumento. Los índices negativos comienzan al final de la lista y van hacia atrás.

En el ejemplo siguiente, un índice de -1 devuelve el último elemento de una lista. Un índice de -2 devuelve el penúltimo."""
print("The last planet is", planeta[-1])
print("The penultimate planet is", planeta[-2])
"""dados estos indices podemos hacer que vaya de reversa buscando desde indices negativos desde 
[-3],[-4] y asi sucesivamente"""

""" Búsqueda de un valor en una lista
Para determinar dónde se almacena un valor en una lista, use el método index de la lista. Este método busca el valor y devuelve el índice de ese elemento en la lista. Si no encuentra ninguna coincidencia, devuelve -1.

En el ejemplo siguiente se muestra el uso de "Jupiter" como el valor del índice: """
jupiter_index = planeta.index("Jupiter")
print("Jupiter is the", jupiter_index + 1, "Planet from the sun")