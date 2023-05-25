moon_radius = """We only see.\n "about" 60% of the Moon's:\n surface"""
print(moon_radius)

multiline = """Facts about the Moon:
...  There is no atmosphere.
...  There is no sound."""
print(multiline)


"""Métodos de cadena en Python
Completado
100 XP
3 minutos
Los métodos de cadena son uno de los tipos de método más comunes en Python. A menudo tendrá que manipular cadenas para extraer información o ajustarse a un formato concreto. Python incluye varios métodos de cadena diseñados para realizar las transformaciones más comunes y útiles.

Los métodos de cadena forman parte del tipo str. Esto significa que los métodos existen como variables de cadena o directamente como parte de la cadena. Por ejemplo, el método .title() se puede usar directamente con una cadena:

 """

dev = "temperatures and facts about the moon".title()
'Temperatures And Facts About The Moon'

print(dev)

heading = "temperatures and facts about the moon"
heading.title()
print(heading)

"""División de una cadena
Un método de cadena común es .split(). Sin argumentos, el método separará la cadena en cada espacio. Esto crearía una lista de todas las palabras o números separados por un espacio:"""

temperatures = """Daylight: 260 F
... Nighttime: -280 F"""
temperatures .split('\n')
['Daylight: 260 F', 'Nighttime: -280 F']
print(temperatures)

""" Búsqueda de una cadena
Algunos métodos de cadena pueden buscar contenido antes del procesamiento, sin necesidad de usar un bucle. Imagine que tiene dos oraciones que analizan las temperaturas de varios planetas y lunas, pero solo le interesan las temperaturas relacionadas con la Luna. Es decir, si las oraciones no se refieren a la Luna, no se deben procesar para extraer información.

La manera más sencilla de detectar si existe una palabra, un carácter o un grupo de caracteres determinados en una cadena es usar el operador in:"""

""" luna = "Moon" in "This text will describe facts and challenges with space travel"
print(luna) """

""" Un enfoque para buscar la posición de una palabra específica en una cadena consiste en usar el método .find():"""

temperatures = "The Moon And The Earth".lower()
'the moon and the earth'
temperatures.count("Mars")
print(temperatures)

devs = "the monon and the earth".upper()
print(devs)


ejemplos = "Mars Average Temperatures: -60° C"

var = ejemplos.split(':')
var
['Mars average temperature', ' -60 C'] 
var[-1]

print(ejemplos)



"""El código anterior confía en que todo lo que hay después de los dos puntos (:) es una temperatura. La cadena se divide en :, lo que genera una lista de dos elementos. El uso de [-1] en la lista devuelve el último elemento que, en este ejemplo, es la temperatura.

Si el texto es irregular, no puede usar los mismos métodos de división para obtener el valor. Debe recorrer en bucle los elementos y comprobar si los valores son de un tipo determinado. Python tiene métodos que ayudan a comprobar el tipo de cadena:"""

mars_temperature = "The highest temperature on Mars is about 30 C"
for item in mars_temperature.split():
    if item.isnumeric():
        print(item)

marte_temperatura = "La temperatura en marte equivale a 90 C"
for items in marte_temperatura.split():
    if items.isnumeric():
        print(items)

temperaturas_in_marte = "-50".startswith('-')
print(temperaturas_in_marte)

replace = "Saturn has a daytime temperature of -170 degrees Celsius, while Mars has -28 Celsius.".replace("Celsius", "C")
'Saturn has a daytime temperature of -170 degrees C, while Mars has -28 C.'

print(replace)

text = "Temperatures on the Moon can vary wildly."
"temperatures" in text.lower()

print(text)

moon_facts = ["The Moon is drifting away from the Earth.", "On average, the Moon is moving about 4cm every year"]
'\n'.join(moon_facts)
print(moon_facts)

porcentaje = "1/6"

print("On the Moon, you would weigh about %s of your weight on Earth" % porcentaje)

porcentaje = "1/6"

print("On the Moon, you would weigh about {} of your weight on Earth" .format(porcentaje))


porcentaje = "1/6"

print("On the Moon, you would weigh about {0} of your weight {0} on Earth" .format("Moon", porcentaje))

porcentaje = "1/6"

print("""On the Moon, you would weigh about {moon} of your weight {moon} ... on Earth""".format(moon="Edgar", porce=porcentaje))


porcentaje = "1/6"

print(f"On the Moon, you would weigh about {round(100/6,1)}% of your weight on Earth")

