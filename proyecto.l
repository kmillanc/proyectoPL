%{
#include <stdlib.h>
#include <string.h>
#include "proyecto.tab.h"

%}

/* Seccion de declaraciones */
%option yylineno

include         "include"
strcpy          "strcpy"
gets            "gets"
memcpy          "memcpy"
void            "void"
delim           [ \t\n]+
commentLine     [ \/\/ ]+.*[\n]  
initComment     [ \/\* ]+
endComment      [ \*\/ ]+
comment         {initComment}.*{endComment}
word            [^ \t\n\r]+
integer         [0-9]+

/* Seccion de reglas*/
%%
^#.*            ; 
{delim}         ;
{include}\<{word}+\> { yylval.str = strdup(yytext); return HEADER_INCLUDE; }
{strcpy}        { return STRCPY; }
{gets}          { return GETS; }
{memcpy}        { return MEMCPY; }
{integer}       { yylval.str = strdup(yytext) ; 
                    return INTEGER; };
{word}          { yylval.str = strdup(yytext); 
                    return WORD; }  
.               { printf("Error en la linea %i: caracter invalido: %s\n", yylineno, yytext); }
%%




