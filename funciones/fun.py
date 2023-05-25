from datetime import timedelta, datetime

def generar_reporte(Main_tank, External_tank, Hydroguen_tank):
    output = f""" Fuel Report:
    Main tank: {Main_tank}
    External tank: {External_tank}
    Hydroguen tank: {Hydroguen_tank}
     """
    print(output)
generar_reporte(80,70,75)

def arrival_time(hours=51):
    now = datetime.now()
    arrival = now + timedelta(hours=hours)
    return arrival.strftime("Arrival: %A %H:%M")
arrival_time(hours=0)

def variable_length(*args):
    print(args)
variable_length("one", "two")

def sequence_time(*args):
    total_minutos = sum(args)
    if total_minutos < 60:
        return f"Total tiempo to launch is {total_minutos} minutes"
    else:
        return f"Total tiempo to launch {total_minutos/60} minutes"
print(sequence_time(4, 14, 18))

#Argumentos de palabra clave variable
#Para que una función acepte cualquier número de argumentos de palabra clave, debe usar una sintaxis similar. En este caso, se requiere un asterisco doble:

def variable_length(**kwargs):
    print(kwargs)
variable_length(tanks=1, day="Wednesday", pilots=3)

"""En esta función, vamos a usar argumentos de palabra clave variable para notificar los astronautas asignados a la misión. Dado que esta función permite cualquier número de argumentos de palabra clave, se puede reutilizar independientemente del número de astronautas asignados:"""

def crew_members(**kwargs):
    print(f"{len(kwargs)} astronauts assigned for this mission:")
    for title, name in kwargs.items():
        print(f"{title}: {name}")
crew_members(captain="Neil Armstrong", pilot="Buzz Aldrin", command_pilot="Edgar esau")

"""Dado que puede pasar cualquier combinación de argumentos de palabra clave, asegúrese de evitar palabras clave repetidas. Las palabras clave repetidas producirán un error:

Python

Copiar
>>> crew_members(captain="Neil Armstrong", pilot="Buzz Aldrin", pilot="Michael Collins")
  File "<stdin>", line 1
SyntaxError: keyword argument repeated: pilot"""

def informe_combustible(**kwargs):
    for name, value in kwargs.items():
        print(f'{name}: {value}')
informe_combustible(main=50, external=100, emergency=60)