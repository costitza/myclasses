#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>

void handler(int signo){

    return;
}

void (*oh)(int);

int main(void){
    int fd[2];
    // f[0] - citire
    // f[1] - scriere


    oh = signal(SIGPIPE, handler);

    if(oh == SIG_IGN){
        printf("signal ignored\n");
        exit(1);
    }
    else if(oh == SIG_DFL){
        printf("signal default\n");
        exit(1);   
    }

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

        close(fd[0]);

        sleep(1);

        close(fd[1]);

        exit(0);
    }
    else{
        // parinte
        close(fd[0]);

        sleep(2);
        const char *msg = "salut, mesaj din parinte\n";

        if(write(fd[1], msg, strlen(msg)) < 0){
            perror("eroare la scriere din parinte");
            exit(1);
        }

        close(fd[1]);

        wait(NULL);
    }

    return 0;
}