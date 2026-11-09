#include <stdio.h>
#include <unistd.h>
#include <signal.h>

void handler(int signo){

    return;
}


unsigned int mysleep(unsigned int seconds){

    // armez
    signal(SIGALRM, handler);

    alarm(seconds);

    // suspend procesul pana primesc semnal SIGINT
    pause();

    // anulez vechea alarma si returnez secundele ramase
    return alarm(0);
}

int main(void){

    signal(SIGINT, handler);

    printf("pid : %d\n", getpid());
    printf("incep sleep de 30s\n");

    unsigned int secunde_ramase = mysleep(30);

    printf("secunde ramase: %d\n", secunde_ramase);


    return 0;
}