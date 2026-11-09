#include <stdio.h>
#include <unistd.h>
#include <signal.h>

void handler(int signo){

    return;
}


int main(void){

    signal(SIGALRM, handler);

    alarm(0);

    return 0;
}