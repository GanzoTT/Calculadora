# Integrantes
   1. Franco Comas
   2. David Martinez
   3. Anthony Barahona

# Calculadora en Flex y Bison

Este proyecto es una calculadora simple que utiliza **Bison** y **Flex** para el análisis sintáctico y la tokenización de expresiones matemáticas. Soporta operaciones básicas como suma, resta, multiplicación, división, potenciación. También permite la evaluación de expresiones dentro de paréntesis con presedencia normal, inversa y menor en los parentesis.

## Características

- **Gramática Normal**: Evaluación de expresiones matemáticas en orden normal de precedencia.
- **Gramática Inversa**: Permite evaluar expresiones en orden inverso.
- **Paréntesis**: Manejo de expresiones dentro de paréntesis con menor precedencia.
- **Errores de Entrada**: Manejo de errores para entradas no válidas.
  
## Guía para la Creación del Archivo `calculadora.l` y `calculadora.y`

### Descarga de los Archivos

1. **Descargar los Archivos:**
   - Navega al repositorio donde se encuentran los archivos `calculadora.l` y `calculadora.y`.
   - Descarga estos archivos a tu máquina local.

2. **Abrir una Terminal en la Carpeta Descargada:**
   - Navega a la carpeta donde descargaste los archivos.
   - Haz clic derecho en la carpeta y selecciona "Abrir terminal aquí".

### Implementación de Flex y Bison

1. **Generar el Archivo `lex.yy.c` con Flex:**
   - En la terminal abierta en la carpeta con los archivos, ejecuta el comando:
     ```bash
     flex calculadora.l
     ```
   - Esto generará el archivo `lex.yy.c`.

2. **Generar los Archivos `calculadora.tab.c` y `calculadora.tab.h` con Bison:**
   - Ejecuta el comando:
     ```bash
     bison -d calculadora.y
     ```
   - Esto generará los archivos `calculadora.tab.c` y `calculadora.tab.h`.

### Archivos Generados

- **`lex.yy.c`**: Archivo generado por Flex que contiene el analizador léxico.
- **`calculadora.tab.c`**: Archivo generado por Bison que contiene el analizador sintáctico.
- **`calculadora.tab.h`**: Archivo generado por Bison que contiene las definiciones de tokens y estructuras necesarias para el analizador sintáctico.

## Compilación del Programa

1. **Compilar y Unir los Archivos:**
   - Utiliza el siguiente comando para compilar y unir los archivos generados:
     ```bash
     gcc -o calculadora calculadora.tab.c lex.yy.c -lfl -lm
     ```
   - Esto creará un ejecutable llamado `calculadora`.

## Ejecución del Programa

1. **Ejecutar el Programa:**
   - Una vez compilado, puedes ejecutar el programa con:
     ```bash
     ./calculadora
     ```
### Ejemplos de Ejecucion:

  - Para la gramática normal (+, -, *, /):

Entrada:

      > 7*8/3
      = 18.6667
      > 1+6*5-2
      = 29
      > 2*5/8+4-1
      = 4.25
      > 2+3-9+3*1
      = -1

  - Para la gramática inversa (/ , *, -, +):

Entrada:
      
      > 7/4*3+2
      = 8.75
      > 8*3/6+2*4
      = 12
      > 2+1+7/2*7-8*3
      = -15

  - Para la gramática con menor precedencia de paréntesis:

Entrada:
   
      > 3 + (4 * 2)
      = 11
      > 1 - (2 * 3)
      = -5
      > 10 / (2 + 3)
      = 2



