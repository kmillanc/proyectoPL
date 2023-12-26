/*****************************************************************************************************************

Final Project - Language Processing 

Aut@r: Kevin Millán Canchapoma - k.millanc@udc.es

Aut@r: Inés Faro Pérez - ines.fperez@udc.es

*****************************************************************************************************************/


In this project we propose the implementation of a lexical and syntactic analyser that detects possible attacks of 

buffer overflow attacks. As input we receive a .c file and as output we return a report that highlights the lines and variables that can be overwritten. 

variables that can be fraudulently overwritten. The grammars will collect all the ways our variables can be overwritten. 

variables can be overwritten. Along with another final module that has a counter that shows the possible 

malicious overwrites and a table where we indicate the variable, the line where it is declared and the line where it is initialised.

initialised.


The files that make up this project will be a lexical analyser (lexer) that we name "proyecto.l ".

The lexer will recognise the initialised variables and the functions such as strcpy, gets, memcpy...

We will also have a parser "proyecto.y" which will recognise the grammar and will deal with errors due to a possible attack, and "proyecto.l ". 

due to a possible attack, and a folder with different test examples with buffer overflow attacks. We have 

We also have a Makefile to facilitate the execution of our program from the terminal where it would be enough to execute a 

make all to compile the project, a make run to execute it and a make clear to delete all the files 

generated in compilation. For a more detailed analysis, we can run make compile2, and make run2 to directly execute the examples found in the 

directly the examples found in the folder called 'examples'.


In our lexical analyser we look at certain C reserved words with a focus on functions vulnerable to

buffer overflow attacks. For any unrecognised character we throw an invalid character error message.


In the case of the syntactic parser, we consider some specific C language structures, but only the ones 

necessary for our concrete examples of buffer overflow attacks. We recognise basic structures such as 

statements, expressions, conditional structures such as if then else or loops such as while and for. 


Error handling is done by means of the bison function yyerror, which we launch whenever there might be

a malicious overwrite or in case the input file is not correct.


Finally, we have an auxiliary function print to give a more visual format to our table displayed in the output.
