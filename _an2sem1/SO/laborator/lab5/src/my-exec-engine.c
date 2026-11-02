#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>


int main(int argc, char *argv[]){

    if (argc < 2){
        perror("nu ai al doilea argument");
        return 1;
    }


    pid_t pid = vfork();

    if(pid < 0){
        perror("eroare la fork");
        return 1;
    }
    else if(pid == 0){
        execvp(argv[1], &argv[1]);

        // execvp esueaza
        perror("execvp a esuat");
        exit(1);
    }
    else{
        int status;
        pid_t copil_pid = wait(&status);


        if(copil_pid == -1){
            perror("Eroare la wait");
            return 1;
        }

        printf("print din parinte pentru demo\n");
    }

    return 0;
}