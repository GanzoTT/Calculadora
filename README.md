# Integrantes
  Franco Comas


# Calculadora en Flex y Bison

Este documento proporciona instrucciones detalladas sobre cómo instalar, configurar y ejecutar una calculadora simple desarrollada en Flex y Bison.

## Antes de Empezar

### Verificar la Instalación de Flex y Bison

1. **Abrir una Terminal:**
   - Utiliza el atajo `Ctrl + Alt + T` para abrir una terminal en Kali Linux.

2. **Verificar la Instalación de Bison:**
   - Ingresa el comando `bison --version` en la terminal. Esto mostrará la versión de Bison instalada.

3. **Verificar la Instalación de Flex:**
   - Ingresa el comando `flex --version` en la terminal. Esto mostrará la versión de Flex instalada.

### Instalar Flex y Bison

1. **Instalar Bison:**
   - Abre una terminal con `Ctrl + T`.
   - Ejecuta el comando `sudo apt-get install bison` y presiona Enter. Esto instalará Bison en tu sistema.

2. **Instalar Flex:**
   - En la misma terminal, ejecuta el comando `sudo apt-get install flex` y presiona Enter. Esto instalará Flex en tu sistema.

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
![Ejemplo1](https://github.com/user-attachments/assets/90648786-9ffa-422f-9b19-1e7a752c1a9b)
![Ejemplo2](https://github.com/user-attachments/assets/0e0c0ee9-4333-4d2a-bd54-d1c38507bed2)


Este fragmento incluye ejemplos de entradas válidas y errores que la calculadora maneja, con capturas de pantalla y descripciones detalladas para facilitar la comprensión de cómo el programa responde a diferentes situaciones.

## Explicación del Código

### Tokenización

La tokenización es el primer paso en el proceso de interpretación de una expresión matemática en la calculadora. Durante esta fase, el código fuente de la calculadora, a través del lexer (el archivo `calculadora.l`), divide la cadena de entrada en unidades mínimas de significado conocidas como tokens. Estos tokens representan los componentes básicos de una expresión, como números, operadores aritméticos, paréntesis, y otros caracteres especiales.

#### Cómo Funciona el Lexer (`calculadora.l`)

El lexer utiliza expresiones regulares para identificar y separar los diferentes elementos de la entrada. Cada vez que se encuentra un patrón que coincide con una expresión regular definida, se genera un token correspondiente que es luego procesado por el parser (Bison).

**Explicación de Cada Regla:**

1. **Operadores Aritméticos (+, -, *, /, |):**
   - Cada operador es reconocido y se devuelve un token correspondiente (`ADD`, `SUB`, `MUL`, `DIV`, `ABS`).

2. **Paréntesis ((, )):**
   - Los paréntesis son reconocidos y se devuelven como los tokens `OP` (para `(`) y `CP` (para `)`).

3. **Números ([0-9]+):**
   - Cualquier secuencia de dígitos es reconocida como un número y se devuelve el token `NUMBER`.
   - El valor numérico se convierte de texto a entero utilizando `atoi(yytext)` y se almacena en `yylval`, una variable especial utilizada para pasar valores del lexer al parser.

4. **Nueva Línea (\n):**
   - La nueva línea es tratada como un token especial `EOL` (End of Line), aunque no se usa explícitamente en este ejemplo.

5. **Comentarios ("//".*):**
   - Los comentarios que empiezan con `//` y continúan hasta el final de la línea se ignoran.

6. **Espacios en Blanco ([ \t]):**
   - Los espacios y tabulaciones son ignorados, permitiendo que la entrada pueda tener formato sin afectar la tokenización.

7. **Caracteres Desconocidos (.):**
   - Si el lexer encuentra un carácter que no coincide con ninguna de las reglas anteriores, se genera un error con `yyerror`, indicando un carácter misterioso.

El lexer actúa como un filtro que escanea la entrada y extrae los elementos relevantes (tokens) que la calculadora puede procesar. Cada token es luego enviado al parser para su análisis y evaluación.

### Análisis Sintáctico

El análisis sintáctico es el proceso mediante el cual el parser, generado por Bison, toma los tokens producidos por el lexer y los organiza en una estructura jerárquica conocida como árbol de sintaxis. Esta estructura refleja la estructura gramatical de la expresión matemática y es crucial para evaluar la expresión correctamente.

#### Cómo Funciona el Parser (`calculadora.y`)

El archivo `calculadora.y` define las reglas gramaticales para la calculadora. Bison usa estas reglas para construir un árbol de sintaxis a partir de los tokens proporcionados por el lexer. Cada regla en el archivo `calculadora.y` especifica cómo los tokens se combinan para formar expresiones válidas.

**Explicación de las Reglas:**

1. **Regla `exp`:**
   - La regla `exp` permite que una expresión sea una operación de valor absoluto (`ABS factor`) o una expresión compuesta. El resultado de esta operación se almacena en `$$` (el resultado de la regla completa). La operación de valor absoluto (`|`) se aplica aquí.

2. **Regla `factor`:**
   - La regla `factor` permite que un factor sea simplemente un término (`term`), o una operación de multiplicación o división de factores.
   - `factor MUL term` y `factor DIV term` permiten realizar operaciones de multiplicación y división, respectivamente, aplicando la operación correspondiente a los valores de `$1` (el primer factor) y `$3` (el segundo término).

3. **Regla `term`:**
   - La regla `term` define los componentes básicos de una expresión. Puede ser un número (`NUMBER`), una operación de valor absoluto (`ABS term`), o una subexpresión encerrada entre paréntesis (`OP exp CP`).
   - `ABS term` aplica el valor absoluto al valor de `$2`, y `OP exp CP` permite evaluar subexpresiones.

**Cómo se Construye el Árbol de Sintaxis:**

- Para una expresión simple como `3 + 5`, el parser construye un árbol con un nodo raíz para la operación de suma, y dos nodos hijos para los números 3 y 5.
- Para una expresión más compleja como `(3 + 5) * 2`, el parser construye un árbol con un nodo raíz para la multiplicación, con un nodo hijo que es una subexpresión `(3 + 5)` y otro hijo para el número 2.

**Evaluación del Árbol de Sintaxis:**

Una vez que el árbol de sintaxis se construye, se evalúa para obtener el resultado final. Esto se realiza durante el proceso de evaluación en el lexer, donde se aplican las operaciones definidas en las reglas gramaticales a los nodos del árbol.

### Evaluación

La evaluación es el proceso final en el que se calcula el resultado de la expresión matemática usando el árbol de sintaxis construido durante el análisis sintáctico. En el contexto de la calculadora creada con Bison y Flex, esto se realiza en la fase de ejecución del programa cuando se recorren los nodos del árbol de sintaxis para aplicar las operaciones definidas.

#### Cómo se Realiza la Evaluación

En el archivo `calculadora.y`, la evaluación se realiza directamente en las reglas gramaticales. Cada regla en el archivo `calculadora.y` define cómo combinar los resultados de subexpresiones para obtener el resultado final.

**Explicación de la Evaluación:**

1. **Regla `exp`:**
   - La regla `exp` maneja la operación de valor absoluto y la evaluación general de expresiones. El cálculo de `ABS factor` aplica la operación de valor absoluto al resultado de `factor`. En esta regla, `$$` recibe el resultado final.

2. **Regla `factor`:**
   - La regla `factor` maneja las operaciones de multiplicación y división. La evaluación de `factor MUL term` y `factor DIV term` realiza las operaciones aritméticas básicas, multiplicando o dividiendo los valores de `$1` (factor) y `$3` (término). El resultado se asigna a `$$`.

3. **Regla `term`:**
   - La regla `term` maneja los números, la operación de valor absoluto, y las subexpresiones. La evaluación de `ABS term` calcula el valor absoluto del resultado de `term`. La evaluación de `OP exp CP` evalúa una subexpresión encerrada en paréntesis.

**Valores y Resultados:**

El valor de cada operación se almacena en `$$`, que representa el resultado de la regla completa. Este resultado se utiliza en la evaluación de reglas superiores.

La evaluación transforma la estructura del árbol de sintaxis en un resultado numérico. La implementación en `calculadora.y` maneja cada operación de la expresión matemática de manera directa, utilizando las reglas definidas en el parser para calcular el resultado final.


