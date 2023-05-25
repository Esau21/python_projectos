""" Almacenamiento de números en listas
Para almacenar números con decimales en Python, se debe usar el tipo float. Para crear un valor float, escriba el número con la posición decimal y asígnelo a una variable: """

gravity_on_earth = 1.0
gravity_on_the_moon = 0.166
gravity_on_planets = [0.378, 0.907, 1, 0.377, 2.36, 0.916, 0.889, 1.12]
bus_weight = 12650 # in kilograms, on Earth

print("On Earth, a double-decker bus weighs", bus_weight, "kg")
print("On Mercury, a double-decker bus weighs", bus_weight * gravity_on_planets[0], "kg")

""" Uso de min() y max() con listas
Python tiene funciones integradas para calcular los números más grandes y más pequeños de una lista. La función max() devuelve el número más grande y min() devuelve el más pequeño. Por lo tanto, min(gravity_on_planets) devuelve el número más pequeño de la lista gravity_on_planets, que es 0,377 (Marte).

El código siguiente calcula los pesos mínimo y máximo en el sistema solar mediante esas funciones: """

bus_weight = 12650 # in kilograms, on Earth

print("On Earth, a double-decker bus weighs", bus_weight, "kg")
print("The lightest a bus would be in the solar system is", bus_weight * min(gravity_on_planets), "kg")
print("The heaviest a bus would be in the solar system is", bus_weight * max(gravity_on_planets), "kg")