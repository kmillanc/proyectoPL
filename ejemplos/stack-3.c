#include <string.h>
#include <stdio.h>

void callme (char *filename){
    char b[256];
    FILE* f;

    f = fopen ( filename, "r");
    fgets (b, 512, f);
}

int main(int argc, char *argv[]){
    if (argc > 1){
        callme(argv[1]);
    }
    return 0;
}