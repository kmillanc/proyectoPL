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
void            "void"
return          "return"
lbrace          \{
rbrace          \}
lparent         \(
rparent         \)
lbracket        \[
rbracket        \]
comma           \,
semicolon       \;
singlequot      \'
quotesIn        \"
quotesEnd       \"
quotedstring    ({quotesIn}.*{quotesEnd})|({singlequot}.*{singlequot})
equals          \=
equality        \=\=
inequality      \!\=
lthan           \<
gthan           \>
plus            \+
increment       {word}\+\+
minus           \-
printf          "printf"
strcpy          "strcpy"
strcmp          "strcmp"
gets            "gets"
system          "system"
fopen           "fopen"
fgets           "fgets"
delim           [ \t\n]+
word            [a-zA-Z_][a-zA-Z0-9_]* 
integer         [0-9]+
pointer         \*{word}*
commentLine     \/\/.*  
initComment     \/\*
endComment      \*\/
comment         {initComment}.*{endComment}

/* Seccion de reglas*/
%%
^#.*            ; 
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
{lbracket}      { return LBRACKET; }
{rbracket}      { return RBRACKET; }
{comma}         { return COMMA; }
{semicolon}     { return SEMICOLON; }
{quotedstring}  { return PRINTSTRING; }
{equals}        { return EQUALS; }
{equality}      { return EQUALITY; }
{inequality}    { return INEQUALITY; }
{lthan}         { return LTHAN; }
{gthan}         { return GTHAN; }
{plus}          { return PLUS; }
{increment}     { return INCREMENT; }
{minus}         { return MINUS; }
{printf}        { return PRINTF; }
{strcpy}        { return STRCPY; }
{strcmp}        { return STRCMP; }
{gets}          { return GETS; }
{system}        { return SYSTEM; }
{fopen}         { return FOPEN; }
{fgets}         { return FGETS; }
{integer}       { yylval.str = strdup(yytext) ; 
                    return INTEGER; };
{word}          { yylval.str = strdup(yytext); 
                    return WORD; }  
{pointer}       { return POINTER; }
{delim}         {}
{commentLine}   { return COMMENTLINE; }
{comment}       { return COMMENT; }
.               { printf("Error en la linea %i: caracter invalido: %s\n", yylineno, yytext); }
%%