%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void); 
int malicious_overwrite = 0;

void yyerror(const char *s);
%}

%union {
    char *str;
}

%token STRCPY
%token GETS
%token MEMCPY
%token INT
%token EOF
%token TAB

%token <str> WORD
%token <str> ANY

%start S
%%

S: 
;

%%

int main(int argc, char *argv[]) {
	yyparse(); 
    printf("Malicious overwrites detected:\n");
	return 0;
}

void yyerror (const char *s) { 
    fprintf(stderr, "Error en la línea %i: %s\n", yylineno, s, malicious_overwrite+1);
}