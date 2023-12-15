### PL. Fichero makefile basico
# FUENTE: nombre fichero fuente con extension .l
FUENTE = proyecto
# PRUEBA: nombre fichero de prueba
PRUEBA = ejemplo.c
# LIB (libreria flex): lfl (gnu/linux, windows); ll (macos)
LIB = lfl

all: compile

compile:
	flex $(FUENTE).l
	bison -o $(FUENTE).tab.c $(FUENTE).y -yd 
	gcc -o $(FUENTE) lex.yy.c $(FUENTE).tab.c -$(LIB) -ly 

clean:
	rm $(FUENTE) lex.yy.c $(FUENTE).tab.c $(FUENTE).tab.h

run:
	./$(FUENTE) < $(PRUEBA)

