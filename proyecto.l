%{
#include <stdlib.h>
#include <string.h>
#include "proyecto.tab.h"

%}

/* Seccion de declaraciones */
%option yylineno

strcpy          "strcpy"
gets            "gets"
memcpy          "memcpy"
int             "int"       
char            "char"  
delim           [ \t\n]+
word            [a-zA-Z_][a-zA-Z0-9_]*  

/* Seccion de reglas*/
%%
^#.*            ; 
{delim}         ;
{strcpy}        { return STRCPY; }
{gets}          { return GETS; }
{memcpy}        { return MEMCPY; }
{int}           { return INT; }
{char}          { return CHAR; }
{word}          { yylval.str = strdup(yytext); 
                    return WORD; }
.               { yylval.str=strdup(yytext); 
                    return ANY; }
%%