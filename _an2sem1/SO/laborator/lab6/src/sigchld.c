#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>


void handler(int signo){
    // rearmez
    signal(signo, handler);


    int status;
    pid_t pidcopil;

    pidcopil = waitpid(-1, &status, WNOHANG);

    if (pidcopil > 0){
        printf("\n[HANDLER] semnal: %d, pid: %d, exit status: %d\n", status, pidcopil, WEXITSTATUS(status));
        
    }
}


int main(void){

    if (signal(SIGCHLD, handler) == SIG_ERR){
        perror("eroare la asocierea handlerului");
        exit(1);
    }

    pid_t pid = fork();

    if(pid < 0){
        perror("eroare la fork");
        exit(1);
    }
    else if(pid == 0){
        printf("[COPIL] pid: %d\n", getpid());
        printf("[COPIL] pid parinte: %d\n", getppid());

        exit(44);
    }
    else{

        getchar();

        printf("tasta primita, iesire\n");
        exit(0);
    }

    return 0;
}