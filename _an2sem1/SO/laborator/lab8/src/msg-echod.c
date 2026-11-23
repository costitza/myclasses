#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <sys/types.h>
#include <string.h>

int msqid;

struct msgbuf {
    long mtype;
    char mtext[256];
};

void handler(int signo) {
    msgctl(msqid, IPC_RMID, NULL);
    exit(0);
}


int main(int argc, char *argv[]){

    if(argc < 2) return 1;

    signal(SIGTERM, handler);

    key_t key = ftok(argv[1], 42);

    msqid = msgget(key, IPC_CREAT |IPC_EXCL | 0644);

    struct msgbuf msg;

    while(1){
        if(msgrcv(msqid, &msg, 256, 1, 0)) return 1;
        msgsnd(msqid, &msg, 256, 0);
    }

}