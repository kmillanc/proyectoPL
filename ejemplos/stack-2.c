#include <string.h>

void callme (char *a){
    char b[255];
    strcpy(b, a);
}

int main(int argc, char *argv[]){
    if (argc > 1){
        callme(argv[1]);
    }
    return 0;
}