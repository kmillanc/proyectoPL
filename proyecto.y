%{
// ---------------------------- Librerias -------------------------------

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// ---------------------------- Definiciones -----------------------------

extern int yylex();

void yyerror(char *s);

extern int yylineno;
extern void yyclearin;

// ------------------------- Variables globales ---------------------------

struct variable {
   char *name;
   int declarationLine;
   int initializationLine;
};

struct variable variables[256];

int variableCount = 0;
int malicious_overwrite = 0;

%}

%union {
    char *str;
}

// ---------------------------- Simbolos terminales --------------------------

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
%token PRINTF
%token COMMENTLINE
%token COMMENT
%token STRCPY
%token STRCMP
%token GETS
%token SYSTEM
%token FOPEN
%token FGETS

%token <str> LPAREN
%token <str> RPAREN
%token <str> INCREMENT
%token <str> POINTER

%token <str> INTEGER
%token <str> WORD

%type <str> expression

// ---------------------------- Inicio de la gramatica -------------------------

%start program

%%

// ---------------------------- Reglas gramaticales ----------------------------

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
        | gets
        | strcmp 
        | system
        | return
        | strcpy
        | printf
        | fgets
        | COMMENTLINE
        | COMMENT
;

// ---------------------------- Expresiones ----------------------------

operador: PLUS EQUALS
        | MINUS
        | PLUS 
        | EQUALS
        | EQUALITY
        | INEQUALITY
        | LTHAN
        | GTHAN
;

expression: WORD
        | INTEGER
        | POINTER 
        | INCREMENT
        | expression LBRACKET WORD RBRACKET 
        | expression indexArray 
        | expression LPAREN expression_list RPAREN
        | expression operador WORD
        | expression operador INTEGER
        | expression operador PRINTSTRING
        | expression operador cast
        | expression operador fopen
;

expression_list:
        expression
        | expression_list COMMA expression
;

indexArray: LBRACKET INTEGER RBRACKET
;

// ---------------------------- Declaraciones ----------------------------

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
            | WORD operador INTEGER {
                variables[variableCount].name = strdup($1);
                variables[variableCount].declarationLine = yylineno;
                variables[variableCount].initializationLine = yylineno;
                variableCount++;}
            | WORD LPAREN RPAREN
            | WORD LPAREN parameter_list RPAREN
            | WORD indexArray { 
                variables[variableCount].name = strdup($1);
                variables[variableCount].declarationLine = yylineno;
                variableCount++;}
            | POINTER 
            | POINTER LBRACKET RBRACKET
; 

parameter_list: parameter_declaration
          | parameter_list COMMA parameter_declaration
;

parameter_declaration: type WORD
                    | type POINTER
                    | type POINTER LBRACKET RBRACKET
;

// ---------------------------- If-Then-Else ----------------------------

if_statement: IF LPAREN expression RPAREN LBRACE statements RBRACE
            | IF LPAREN strcmp RPAREN LBRACE statements RBRACE ELSE
            | if_statement ELSE LBRACE statements RBRACE
;

// ---------------------------- Bucles ----------------------------

iteration_statement: WHILE LPAREN expression RPAREN statement
                    | FOR LPAREN expression SEMICOLON expression SEMICOLON expression RPAREN function
;


// ---------------------------- Funciones de C ----------------------------

gets: 
    GETS LPAREN expression RPAREN   { yyerror (strdup($3)); }
    | gets SEMICOLON
;

strcmp:
    STRCMP LPAREN WORD COMMA PRINTSTRING RPAREN
    | strcmp SEMICOLON
;

system: 
    SYSTEM LPAREN PRINTSTRING RPAREN
    | system SEMICOLON
;

return:
    RETURN INTEGER 
    | return SEMICOLON
;

strcpy:
    STRCPY LPAREN WORD COMMA WORD RPAREN    { yyerror (strdup($3)); }
    | strcpy SEMICOLON                      
;

cast: 
    LPAREN type RPAREN
    | LPAREN type POINTER RPAREN
;

printf: 
    PRINTF LPAREN PRINTSTRING RPAREN SEMICOLON
    | PRINTF LPAREN PRINTSTRING COMMA expression RPAREN SEMICOLON
;

fopen:
    FOPEN LPAREN WORD COMMA PRINTSTRING RPAREN          { yyerror (strdup($3));  }
;

fgets:
    FGETS LPAREN WORD COMMA INTEGER COMMA WORD RPAREN   { yyerror (strdup($3)); }
    | fgets SEMICOLON                                   
;


%%

// ---------------------------- Funciones ----------------------------

void yyerror (char *s) { 
    fprintf(stderr, "Malicious overwrite detected in line %i over variable: %s\n", yylineno, s);
    malicious_overwrite++;
    yyclearin;
}

void print(){
    printf("Malicious overwrites detected: %i\n", malicious_overwrite);
        printf("Variables:\n");
        printf("|    Name    | Declaration Line | Initialization Line |\n");
        printf("|------------|------------------|---------------------|\n");
        for (int i = 0; i < variableCount; i++) {
            //Make a table with the variables and its fields. | Name | Declaration Line | Initialization Line |
            printf("| %10s | %16i | %19i |\n", variables[i].name, variables[i].declarationLine, variables[i].initializationLine);
        }
}

int main(int argc, char *argv[]) {
    
    extern FILE *yyin;

    switch (argc) {
        case 1: yyin=stdin;
            yyparse();
            print();
            break;
        case 2: yyin = fopen(argv[1], "r");
            if (yyin == NULL) {
                printf("ERROR: No se ha podido abrir el fichero.\n");
            }
            else {
                yyparse(); 
                print();
                fclose(yyin);
            }
            break;
        default: printf("ERROR: Demasiados argumentos.\nSintaxis: %s [fichero_entrada]\n\n", argv[0]);
    }
	return 0;
}
