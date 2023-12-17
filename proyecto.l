%{
#include <stdlib.h>
#include <string.h>
#include "proyecto.tab.h"

%}

/* Seccion de declaraciones */
%option yylineno

if              "if"
else            "else"
while           "while"
for             "for"
int             "int"       
char            "char"  
return          "return"
lbrace          \{
rbrace          \}
lparent         \(
rparent         \)
comma           ','
semicolon       ';'
equals          '='
equality        "=="
inequality      "!="
lthan           '<'
gthan           '>'
plus            '+'
minus           '-'
multiply        '*'
divide          \/
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
{if}            { return IF; }
{else}          { return ELSE; }
{while}         { return WHILE; }
{for}           { return FOR; }
{int}           { return INT; }
{char}          { return CHAR; }
{void}          { return VOID; }
{return}        { return RETURN; }
{lbrace}        { return LBRACE; }
{rbrace}        { return RBRACE; }
{lparent}       { return LPAREN; }
{rparent}       { return RPAREN; }
{comma}         { return COMMA; }
{semicolon}     { return SEMICOLON; }
{equals}        { return EQUALS; }
{equality}      { return EQUALITY; }
{inequality}    { return INEQUALITY; }
{lthan}         { return LTHAN; }
{gthan}         { return GTHAN; }
{plus}          { return PLUS; }
{minus}         { return MINUS; }
{multiply}      { return MULTIPLY; }
{divide}        { return DIVIDE; }
{commentLine}   { return COMMENTLINE; }
{comment}       { return COMMENT; }
{strcpy}        { return STRCPY; }
{gets}          { return GETS; }
{memcpy}        { return MEMCPY; }
{integer}       { yylval.str = strdup(yytext) ; 
                    return INTEGER; };
{word}          { yylval.str = strdup(yytext); 
                    return WORD; }  
.               { printf("Error en la linea %i: caracter invalido: %s\n", yylineno, yytext); }
%%




