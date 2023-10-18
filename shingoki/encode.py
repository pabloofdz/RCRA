import sys

lines = sys.stdin.readlines()  # accedemos al documento que pasamos como entrada
# inicializamos lista y posiciones
resultado = []
i = 0
j = 0
size = -1
for row in lines:  # recorremos documento
    j = 0
    if (row != '\n') and (row != ''):
        if size < 0 and row.split() != 0:
            size = len(row.split())
        for element in row.split():
            if element != '0':

                resultado.append(
                    ("number((" + str(i) + "," + str(j) + ")," + element + ")."))
            j += 1
        i += 1
# imprimimos size y numbers
print(("size(" + str(size) + ")."))
for e in resultado:
    print(e)
