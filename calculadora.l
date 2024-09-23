%{
#include "calculadora.tab.h"
#include <stdlib.h>
%}

%%
// Tokens
"+"     { return ADD; }
"-"     { return SUB; }
"*"     { return MUL; }
"/"     { return DIV; }
"^"     { return POW; }
"|"     { return ABS; }
[0-9]+(\.[0-9]+)?  { yylval.dval = atof(yytext); return NUMBER; }

// Nueva línea
\n      { return EOL; }

// Manejo de comentarios
"//".*  { /* ignorar comentarios */ }

// Ignorar espacios en blanco
[ \t]   { /* ignorar espacios en blanco */ }

// Manejo de caracteres inesperados
.       { yyerror("Caracter desconocido"); }
%%

// Función para llamar al lexer
int yywrap() {
    return 1;
}
