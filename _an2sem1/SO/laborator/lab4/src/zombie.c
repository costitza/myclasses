#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>


int main(){

    pid_t pid = fork();


    if(pid < 0){
        perror("eroare");
        return 1;
    }


    if(pid == 0){
        // copil
        printf("[COPIL] id copilului este: %d\n", getpid());
        printf("[COPIL] iesim din exec\n");
        exit(0);
    }
    else{
        // parinte
        printf("[PARINTE] copil creat cu id: %d\n", pid);
        printf("[PARINTE] dau sleep la parinte cu id: %d\n", getpid());

        sleep(25);
        printf("[PARINTE] acum se termina parintele");
    }

    return 0;
}