#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>


int global = 6;
char buf[] = "unbuffered write to stdout\n";

int main(void) {

    int local = 10;
    pid_t pid;

    // 1. Tiparire cu apelul de sistem write (nebufferizat)
    if (write(STDOUT_FILENO, buf, sizeof(buf) - 1) != sizeof(buf) - 1) {
        perror("Eroare la write");
        exit(1);
    }

    printf("inainte de fork\n");

    // 3. Crearea procesului nou
    if ((pid = fork()) < 0) {
        perror("Eroare la fork");
        exit(1);
    } else if (pid == 0) {
        // Procesul copil incrementeaza ambele variabile
        global++;
        local++;
    } else {
        // Procesul parinte doarme 2 secunde
        sleep(2);
    }

    // Ambele procese termina executand EXACT aceeasi linie de cod:
    printf("pid = %ld, global = %d, local = %d\n", (long)getpid(), global, local);

    return 0;
}