#include <stdio.h>
#include <unistd.h>
#include <signal.h>

void handler(int signo){

    signal(signo, handler);

    if (signo == SIGUSR1) {
        printf("semnal SIGUSR1 %d\n", signo);
    } else if (signo == SIGUSR2) {
        printf("semnal SIGUSR2 %d\n", signo);
    }
}


int main(void){

    // asociere aceelasi handler pentru usr1 si usr2
    signal(SIGUSR1, handler);
    signal(SIGUSR2, handler);

    printf("PID : %d\n", getpid()); 

    // adorm procesul ca sa astept semnale
    while(1){
        pause();
    }

    return 0;
}