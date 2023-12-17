%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(); 
int malicious_overwrite = 0;

void yyerror(const char *s);

extern int yylineno;
extern void yyclearin;

%}

%union {
    char *str;
}

%token IF
%token ELSE
%token WHILE
%token FOR
%token INT
%token CHAR
%token VOID
%token RETURN
%token LBRACE
%token RBRACE
%token LPAREN
%token RPAREN
%token COMMA
%token SEMICOLON
%token EQUALS
%token EQUALITY
%token INEQUALITY
%token LTHAN
%token GTHAN   
%token PLUS
%token MINUS
%token MULTIPLY
%token DIVIDE
%token COMMENTLINE
%token COMMENT
%token STRCPY
%token GETS
%token MEMCPY

%token <str> INTEGER
%token <str> WORD

%start program

%%

program: statements
;

statements: statement
          | statements statement
;

statement: 
          expression SEMICOLON
         | declaration SEMICOLON
         | if_statement
         | iteration_statement
;

declaration: type declarator_list
;

type: INT
    | CHAR
    | INTEGER
    | VOID
;

declarator_list: declarator
              | declarator_list COMMA declarator
;

declarator: WORD
          | WORD LPAREN RPAREN
          | WORD LPAREN parameter_list RPAREN
; 

parameter_list: parameter_declaration
          | parameter_list COMMA parameter_declaration
;

parameter_declaration: type WORD
;

if_statement: IF LPAREN expression RPAREN LBRACE statement RBRACE
               | if_statement ELSE LBRACE statement RBRACE
;

iteration_statement: WHILE LPAREN expression RPAREN statement
                    | FOR LPAREN expression SEMICOLON expression SEMICOLON expression RPAREN statement
;

expression: WORD
         | expression EQUALS WORD
         | expression EQUALS INTEGER
         | expression EQUALITY WORD
         | expression EQUALITY INTEGER
         | expression INEQUALITY WORD
         | expression INEQUALITY INTEGER
         | expression LTHAN WORD
         | expression LTHAN INTEGER 
         | expression GTHAN WORD
         | expression GTHAN INTEGER
;

%%

int main(int argc, char *argv[]) {
	yyparse(); 
    printf("Malicious overwrites detected: %i\n", malicious_overwrite);
	return 0;
}

void yyerror (const char *s) { 
    fprintf(stderr, "Error en la línea %i: %s\n", yylineno, s);
}
