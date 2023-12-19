### PL. Fichero makefile basico
# FUENTE: nombre fichero fuente con extension .l
FUENTE = proyecto
# PRUEBA: nombre fichero de prueba
PRUEBA = ejemplo.c
# SALIDA: nombre del fichero de salida
SALIDA = scan.txt
# LIB (libreria flex): lfl (gnu/linux, windows); ll (macos)
LIB = lfl

all: compile

compile:
	flex $(FUENTE).l
	bison -o $(FUENTE).tab.c $(FUENTE).y -yd 
	gcc -o $(FUENTE) lex.yy.c $(FUENTE).tab.c -$(LIB) -ly 

compile2:
	flex -d $(FUENTE).l
	bison -d -t -r all -o $(FUENTE).tab.c $(FUENTE).y -yd -Wcounterexamples
	gcc -o $(FUENTE) proyecto.tab.c lex.yy.c -$(LIB) -DDEBUG

clean:
	rm $(FUENTE) lex.yy.c $(FUENTE).tab.c $(FUENTE).tab.h $(SALIDA)

run:
	./$(FUENTE) < $(PRUEBA) > scan.txt
