#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <string.h>


int main(void) {

    int fd[2];
    // f[0] - citire
    // f[1] - scriere


    if (pipe(fd) < 0){
        perror("eroare la pipe");
        exit(1);
    }

    pid_t pid;

    if ((pid = vfork()) < 0) {
        perror("Eroare la fork");
        exit(1);
    } else if (pid == 0) {
        // Procesul copil 
        close(fd[1]);

        char buffer[128];

        ssize_t bytes = read(fd[0], buffer, sizeof(buffer) - 1);

        if (bytes <= 0){
            perror("eroare la citire din copil");
            exit(1);
        }
        
        buffer[bytes] = '\0';

        printf("copil - %d - mesaj primit: %s", getpid(), buffer);
        fflush(stdout);

        close(fd[0]);

        exit(0);
    }
    else{
        close(fd[0]);

        const char *msg = "B\n";

        if(write(fd[1], msg, strlen(msg)) < 0){
            perror("eroare la scriere din parinte");
            exit(1);
        }


        close(fd[1]);
        exit(0);
    }





    return 0;
}