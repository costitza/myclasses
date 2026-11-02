#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>


int main(void){
    char line[10000];


    while (1){
        printf("my-shell> ");
        fflush(stdout);


        if(!fgets(line, sizeof(line), stdin)){
            printf("am terminat \n");
            break;
        }


        int len = strlen(line);
        if (len > 0 && line[len - 1] == '\n'){
            line[len - 1] = '\0';
        }

        char *args[1000];
        int argc = 0;

        char *p = strtok(line, " ");
        while(p){
            args[argc] = malloc(32);
            strcpy(args[argc++], p);

            
            p = strtok(NULL, " ");
        }
        args[argc] = NULL;


        pid_t pid = vfork();

        if(pid < 0){
            perror("eroare la fork");
            return 1;
        }
        else if(pid == 0){
            execvp(args[0], args);


            perror("eroare la execv");
            return 1;
        }
        else{
            wait(NULL);
        }

    }

}