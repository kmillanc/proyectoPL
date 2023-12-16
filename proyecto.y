%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void); 
int malicious_overwrite = 0;

void yyerror(const char *s);

extern int yylineno;
extern void yyclearin;

%}

%union {
    char *str;
}

%token STRCPY
%token GETS
%token MEMCPY
%token INT
%token CHAR

%token <str> WORD
%token <str> ANY

%%

program: statements
       ;

statements: statement
          | statements statement
          ;

statement: INT WORD ';'
         | STRCPY '(' WORD ',' WORD ')' {
             printf("Potential Buffer Overflow: %s\n", $5);
             malicious_overwrite++;
         }
         | GETS '(' WORD ')' {
             printf("Potential Buffer Overflow: %s\n", $3);
             malicious_overwrite++;
         }
         | MEMCPY '(' WORD ',' WORD ')' {
             printf("Potential Buffer Overflow: %s\n", $5);
             malicious_overwrite++;
         }
         ;

%%

int main(int argc, char *argv[]) {
	yyparse(); 
    printf("Malicious overwrites detected:\n");
	return 0;
}

void yyerror (const char *s) { 
    fprintf(stderr, "Error en la línea %i: %s\n", yylineno, s);
}