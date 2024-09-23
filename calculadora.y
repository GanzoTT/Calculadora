%{
    #include <stdio.h>
%}

/* Declarar tokens */
%token <dval> NUMBER
%token ADD SUB MUL DIV POW ABS EOL

%union {
    double dval;
}

%type <dval> exp term factor

%%

// Lista de cálculos
calclist: /* nada */
    | calclist exp EOL { printf("= %g\n> ", $2); }
    | calclist EOL { printf("> "); } /* línea en blanco o comentario */
    ;

// Expresiones (suma y resta)
exp: term
    | exp ADD term { $$ = $1 + $3; }
    | exp SUB term { $$ = $1 - $3; }
    ;

// Términos (multiplicación, división)
term: factor
    | term MUL factor { $$ = $1 * $3; }
    | term DIV factor {
        if ($3 == 0) {
            printf("error: división por cero\n");
            $$ = 0; // Valor predeterminado en caso de error
        } else {
            $$ = $1 / $3;
        }
    }
    ;

// Factores (números, absoluto, potencia, y negación)
factor: NUMBER
    | ABS factor { $$ = $2 >= 0 ? $2 : -$2; }
    | factor POW factor {
        double base = $1;
        int exponent = (int) $3;
        $$ = 1;
        for (int i = 0; i < exponent; i++) {
            $$ *= base;
        }
    }
    | SUB factor { $$ = -$2; }
    ;

%%

// Función principal
int main() {
    printf("> ");
    yyparse();
    return 0;
}

// Función de manejo de errores
void yyerror(char *s) {
    fprintf(stderr, "error: %s\n", s);
}
