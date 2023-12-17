#include <string.h>

void myfunction (char *str) {
    char buffer[16];
    strcpy(buffer, str);        //copiamos el contenido de str en buffer[16] sin comprobar que el tamaño de str sea menor que 16!!
}

int main () {
    char large_string[256];
    int i;

    for (i = 0; i < 255; i++) {
        large_string[i] = 'A';
    }

    large_string[255] = '\0';
    myfunction(large_string);   //llamamos a la función myfunction con el argumento large_string, este sobreescribira buffer[16]
    return 0;
}