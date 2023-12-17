#include <stdio.h>

void myfunction (int a, int b, int c) {
    char buffer1[8];
    char buffer2[12];
    int *retp;          //ret es un puntero a entero

    retp = (int *)buffer1 +4;  //pointer arithmetic, retp apunta a buffer1[4] (buffer1[0] + 4*sizeof(int))
    (*retp) += 7;       //sumamos 7 a lo que apunta retp
    printf("Old retp value = %x\n", *retp);
    (*retp) += 7;       //sumamos 7 a lo que apunta retp
    printf("New retp value = %x\n", *retp);
}

int main () {
    int x;

    x = 0;
    myfunction(1,2,3);
    x = 1;

    printf("%x\n",x);  //imprimimos el valor de x en hexadecimal
    return 0;
}