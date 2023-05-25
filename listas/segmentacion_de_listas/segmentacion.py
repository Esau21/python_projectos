planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
planets_before_earth = planets[0:2]
print(planets_before_earth)

"""Observe cómo la Tierra no está incluida en la lista. El motivo es que el índice finaliza antes del índice final.

Para obtener todos los planetas después de la Tierra, comience en el tercero y vaya hasta el octavo:"""
planets_after_earth = planets[3:8]
print(planets_after_earth) 

"""En este ejemplo, se muestra Neptuno. La razón es que el índice de Neptuno es 7, porque la indexación comienza en 0. Dado que el índice final era 8, incluye el último valor. Si no coloca el índice de detención en la segmentación, Python asume que quiere ir al final de la lista:"""


planets_after_earth = planets[3:]
print(planets_after_earth)

"""Combinación de listas
Ha visto cómo puede usar segmentaciones para dividir listas, pero ¿qué sucede con unirlas de nuevo?

Para unir dos listas, debe usar el otro operador (+) con dos listas para devolver una nueva.

Hay 79 lunas conocidas de Júpiter. Las cuatro más grandes son Ío, Europa, Ganímedes y Calisto. Estas lunas se denominan lunas galileanas, ya que Galileo Galilei las descubrió con su telescopio en 1610. El grupo de Amaltea está más cerca de Júpiter que el grupo galileano. Consta de las lunas Metis, Adrastea, Amaltea y Tebe.

Cree dos listas. Rellene la primera lista con las cuatro lunas de Amaltea y la segunda lista con las cuatro lunas galileanas. Únalas mediante + para crear una lista:"""


amalthea_group = ["Metis", "Adrastea", "Amalthea", "Thebe"]
galilean_moons = ["Io", "Europa", "Ganymede", "Callisto"]

regular_satellite_moons = amalthea_group + galilean_moons
print("The regular satellite moons of Jupiter are", regular_satellite_moons)

"""Ordenación de listas
Para ordenar una lista, use el método .sort() de la lista. Python ordenará una lista de cadenas en orden alfabético y una lista de números en orden numérico:"""
regular_satellite_moons.sort()
print("The regular satellite moons of Jupiter are", regular_satellite_moons)
"""Para ordenar una lista en orden inverso, llame a .sort(reverse=True) en la lista:"""
regular_satellite_moons.sort(reverse=True)
print("The regular satellite moons of Jupiter are", regular_satellite_moons)

""" usuario_planeta = input("Please enter the name of the planet (with a capital letter to start)")
planeta = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Neptune"]
planeta_index = planeta.index(usuario_planeta)
print(planeta_index) """

""" user_planet = input("Please enter the name of the planet (with a capital letter to start)")
planeta = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Neptune"]
planeta_index = planeta.index(usuario_planeta)
print("Here are the planets closer than" + usuario_planeta)
print(planeta[0:planeta_index]) """

def Planetas():
    planet = ["MERCURIO", "JUPITER", "VENUS", "TIERRA", "MARTE", "NEPTUNO", "URANO", "SATURNO"]
    if planet:
        planet.append("PLUTO")
        numero_planeta = len(planet)
        print("El planeta nuevo es", numero_planeta, "En el sistema solar")
    else:
        print("El planeta nuevo es", numero_planeta, "En el sistema solar")
Planetas()
