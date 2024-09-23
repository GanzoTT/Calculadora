%{
# include "calculadora.tab.h"
%}

%%
"+"     { return ADD; }
"-"     { return SUB; }
"*"     { return MUL; }
"/"     { return DIV; }
"^"	{ return POW; }
"|"     { return ABS; }
"("     { return OP; }
")"     { return CP; }
[0-9]+(\.[0-9]+)?  { yylval.dval = atof(yytext); return NUMBER; }

\n      { return EOL; }
"//".*
[ \t]   { /* ignore white space */ }
.       { yyerror("Mystery character %c\n", *yytext); }
%%
