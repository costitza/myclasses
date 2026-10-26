#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>

void print(char * str){
    while(*str != '\0'){
        write(1, str, 1);
        str ++;
    }
}


int main(){
     pid_t pid = vfork();


    if(pid < 0){
        perror("eroare");
        return 1;
    }


    if(pid == 0){
        // copil
        printf("[COPIL] id copilului este: %d\n", getpid());
        
        for(int i = 0;i < 10; i++){
            print("This is the child process printing\n");
        }

        exit(0);
    }
    else{
        // parinte
        printf("[PARINTE] copil creat cu id: %d\n", pid);
        
        for(int i = 0;i < 10; i++){
            print("This is the parent process printing\n");
        }

        exit(0);
    }

}