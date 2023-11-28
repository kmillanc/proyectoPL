%{
#include <stdlib.h>
#include <string.h>
#include "proyecto.tab.h"
%}

/* Seccion de declaraciones */
%option yylineno

delim           [ \t\n]+

/* Seccion de reglas*/
%%

{delim}     ;

%%
/* Seccion de codigo */

