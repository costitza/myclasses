#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>


int main(int argc, char *argv[]){

    if (argc < 2){
        perror("nu ai al doilea argument");
        return 1;
    }

    FILE* fp = fopen(argv[1], "r");
    
    if(!fp){
        perror("eroare la deschidere");
        return 1;
    }

    char line[1000];
    if(!fgets(line, sizeof(line), fp)){
        perror("nu am putut citi din script");
    }
    fclose(fp);

    int len = strlen(line);
    if (len > 0 && line[len - 1] == '\n'){
        line[len - 1] = '\0';
    }


    char *p = strtok(line + 2, " ");

    char *argumente[100];
    int idx = 0;

    while(p != NULL){
        argumente[idx++] = p;
        p = strtok(NULL, " ");
    }

    argumente[idx++] = argv[1];
    for (int i = 2;i < argc; i++){
        argumente[idx++] = argv[i];
    }
    argumente[idx] = NULL;

    pid_t pid = vfork();

    if(pid < 0){
        perror("eroare la fork");
        return 1;
    }
    else if(pid == 0){
        execv(argumente[0], argumente);


        perror("eroare la execv");
        return 1;
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