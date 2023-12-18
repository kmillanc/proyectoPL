%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
int malicious_overwrite = 0;

void yyerror(const char *s);

extern int yylineno;
extern void yyclearin;

struct variable {
   char *name;
   int declarationLine;
   int initializationLine;
};

struct variable variables[256];

int variableCount = 0;

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
%token LBRACKET
%token RBRACKET
%token COMMA
%token SEMICOLON
%token PRINTSTRING
%token EQUALS
%token EQUALITY
%token INEQUALITY
%token LTHAN
%token GTHAN   
%token PLUS
%token MINUS
%token MULTIPLY
%token DIVIDE
%token PRINTF
%token COMMENTLINE
%token COMMENT
%token STRCPY
%token STRCMP
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
          | statements function
;

function: LBRACE statements RBRACE
;

statement: 
        expression
        | expression SEMICOLON
        | declaration
        | declaration SEMICOLON
        | if_statement
        | iteration_statement
        | gets {printf("Malicious overwrite detected in line %i\n", yylineno); malicious_overwrite++;}
        | PRINTF LPAREN parameter_declaration RPAREN SEMICOLON
        | COMMENTLINE
        | COMMENT
;

declaration: type declarator_list 
;

type: INT
    | CHAR
    | VOID
;

declarator_list: declarator
              | declarator_list COMMA declarator
;

declarator: WORD { 
                variables[variableCount].name = strdup($1);
                variables[variableCount].declarationLine = yylineno;
                variableCount++;}
            | WORD EQUALS INTEGER {
                variables[variableCount].name = strdup($1);
                variables[variableCount].declarationLine = yylineno;
                variables[variableCount].initializationLine = yylineno;
                variableCount++;}
            | WORD LPAREN RPAREN
            | WORD LPAREN parameter_list RPAREN
            | WORD LBRACKET INTEGER RBRACKET { 
                variables[variableCount].name = strdup($1);
                variables[variableCount].declarationLine = yylineno;
                variableCount++;}
; 

parameter_list: parameter_declaration
          | parameter_list COMMA parameter_declaration
;

parameter_declaration: type WORD
                    | PRINTSTRING
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

gets: 
    GETS LPAREN expression RPAREN 
    | gets SEMICOLON
;


%%

int main(int argc, char *argv[]) {
    
	yyparse(); 
    printf("Malicious overwrites detected: %i\n", malicious_overwrite);
    printf("Variables:\n");
    for (int i = 0; i < variableCount; i++) {
        printf("Name: %s, Declaration line: %i, Initialization line: %i\n", variables[i].name, variables[i].declarationLine, variables[i].initializationLine);
    }
	return 0;
}

void yyerror (const char *s) { 
     fprintf(stderr, "Error en la línea %i: %s\n", yylineno, s);
}