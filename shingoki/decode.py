import sys
# Leer la entrada estándar del script
entrada_estandar = sys.stdin.read().split()
j = 0
segmentos = []
# vamos a cortar para quedarnos solo con los segmentos
for i in range(1, len(entrada_estandar)):
    if entrada_estandar[i] == 'Answer:':
        j = 1
    elif j < 3 and j > 0:
        j += 1
    elif entrada_estandar[i] == 'SATISFIABLE':
        j = 0

    if j > 2:
        segmentos.append(entrada_estandar[i])

# print(segmentos)
size = segmentos[0]
size = size.split('(')
size = size[1].split(')')
# print(size[0])
N = int(size[0])
# ahora crearemos la matriz bidimensional vacía:
# Definir el tamaño de la matriz:
filas = N-1+N
columnas = 2*(N-1)+N

# Generar la matriz vacía de caracteres:
matriz = []
for i in range(filas):
    fila_vacia = []
    for j in range(columnas):
        fila_vacia.append(' ')
    matriz.append(fila_vacia)
# Ponemos los + donde deben estar:
for i in range(0, filas, 2):
    for j in range(0, columnas, 3):
        matriz[i][j] = '+'

# Ponemos los - y |: , aquí pos 0 y 1 son los primeros X,Y y pos 2 3 son X1,Y1
segmentos = segmentos[1:]
for seg in segmentos:
    pos = seg[5:(len(seg)-2)]
    pos = pos.split(',')
    pos[1] = pos[1].split(')')[0]
    pos[2] = pos[2].split('(')[1]
    if pos[0] == pos[2]:
        x = 2*(int(pos[0]))
        if int(pos[1]) < int(pos[3]):
            y = 3*(int(pos[1]))
            y1 = 3*(int(pos[3]))
        else:
            y1 = 3*(int(pos[1]))
            y = 3*(int(pos[3]))
        for i in range(y, y1):
            if matriz[x][i] != '+':
                matriz[x][i] = '-'
    elif pos[1] == pos[3]:
        x = 3*(int(pos[1]))
        if int(pos[0]) < int(pos[2]):
            y = 2*(int(pos[0]))
            y1 = 2*(int(pos[2]))
        else:
            y1 = 2*(int(pos[0]))
            y = 2*(int(pos[2]))
        for i in range(y, y1):
            if matriz[i][x] != '+':
                matriz[i][x] = '|'

# Imprimir la matriz resultante:
for i in range(filas):
    rescol = ""
    for j in range(columnas):
        rescol += matriz[i][j]
    print(rescol)
