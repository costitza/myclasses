#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>


int main(void){

    pid_t pid1, pid2; 
    int fd[2];

    if(pipe(fd) < 0){
        perror("eroare la pipe");
        exit(1);
    }



    if (!fork()) {
        // ls

        close(fd[0]);

        dup2(fd[1], STDOUT_FILENO);

        execlp("ls", "ls", "-l", 0);

        close(fd[1]);
        exit(0);
    }


    if(!fork()){
        // less

        close(fd[1]);
        dup2(fd[0], STDIN_FILENO);

        execlp("less", "less", NULL);

        close(fd[0]);
        exit(0);
    }

    close(fd[0]);
    // close(fd[1]);

    wait(NULL);
    wait(NULL);

    return 0;
}