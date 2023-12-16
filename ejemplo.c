#include <stdio.h>
#include <string.h>

int main()
{
    char password[16];
    int passcheck = 0;

    printf("\n Enter the password : \n");
    gets(password); //gets no comprueba que lo que escribamos por teclado tenga como máximo 16 caracteres

    if(strcmp(password, "password1"))
    {
        printf ("\n Wrong Password \n");
    }
    else
    {
        printf ("\n Correct Password \n");
        passcheck = 1;
    }

    if(passcheck)
    {
       /* Now Give root or admin rights to user*/
        printf ("\n Root privileges given to the user \n");
        system("cat /etc/shadow\n");
    }

    return 0;
}
