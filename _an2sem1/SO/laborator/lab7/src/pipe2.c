#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(void){

    int fd[2];
    // f[0] - citire
    // f[1] - scriere


    if (pipe(fd) < 0){
        perror("eroare la pipe");
        exit(1);
    }

    pid_t pid = fork();

    if (pid < 0){
        perror("eroare la fork");
        exit(1);
    }
    else if(pid == 0){
        // copil

        char buffer[128];

        ssize_t bytes = read(fd[0], buffer, sizeof(buffer) - 1);

        if (bytes <= 0){
            perror("eroare la citire din copil");
            exit(1);
        }
        
        buffer[bytes] = '\0';

        printf("copil - mesaj primit: %s", buffer);
        fflush(stdout);

        const char *msg = "done, am terminat de afisat\n";

        if(write(fd[1], msg, strlen(msg)) < 0){
            perror("eroare la scriere din copil");
            exit(1);
        }

        close(fd[0]);
        close(fd[1]);

        exit(0);
    }
    else{
        // parinte

        const char *msg = "salut, mesaj din parinte\n";

        if(write(fd[1], msg, strlen(msg)) < 0){
            perror("eroare la scriere din parinte");
            exit(1);
        }

        char buffer[128];

        ssize_t bytes = read(fd[0], buffer, sizeof(buffer) - 1);

        if (bytes <= 0){
            perror("eroare la citire din parinte");
            exit(1);
        }
        
        buffer[bytes] = '\0';

        printf("parinte - mesaj primit: %s", buffer);
        fflush(stdout);

        close(fd[0]);
        close(fd[1]);

        wait(NULL);
    }


    return 0;
}