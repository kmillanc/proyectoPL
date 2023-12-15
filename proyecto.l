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
eof             \n
tab             \t     
word            ["\-\/\_\!\&\'a-zA-Z0-9][a-zA-Z0-9\-\>.\!\'\_\/\\\"]* 

/* Seccion de reglas*/
%%

{strcpy}        { return STRCPY; }
{gets}          { return GETS; }
{memcpy}        { return MEMCPY; }
{int}           { return INT; }
{eof}           { return EOF }
{tab}           { return TAB }
{word}          { yylval.str = strdup(yytext); 
                    return WORD; }
.               { yylval.string=strdup(yytext); 
                    return ANY; }
%%