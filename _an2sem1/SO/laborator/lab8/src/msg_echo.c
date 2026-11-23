#include <stdio.h>
#include <unistd.h>
#include <sys/ipc.h>
#include <sys/msg.h>

struct msgbuf {
    long mtype;
    char mtext[256];
};

int main(int argc, char *argv[]) {
    if (argc < 2) return 1;

    key_t key = ftok(argv[1], 42);
    int msqid = msgget(key, 0644);

    struct msgbuf msg;

    while (fgets(msg.mtext, 256, stdin) != NULL) {
        msg.mtype = getpid();
        msgsnd(msqid, &msg, 256, 0);

        msgrcv(msqid, &msg, 256, 0, 0);
        printf("%s", msg.mtext);
    }

    return 0;
}