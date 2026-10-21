#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
    
    int fd = open(argv[1], O_RDONLY);
    if (fd == -1) {
        perror("Eroare la open");
        return 1;
    }


    if (unlink(argv[1]) == -1) {
        perror("Eroare la unlink");
        close(fd);
        return 1;
    }
    printf("Fisierul '%s' a fost sters din director (unlink executat).\n", argv[1]);

    sleep(10);

    printf("Continut in fisier: \n");
    char buffer[256];
    ssize_t bytes_cititi;

    while ((bytes_cititi = read(fd, buffer, sizeof(buffer) - 1)) > 0) {
        buffer[bytes_cititi] = '\0';
        printf("%s", buffer);
    }

    if (bytes_cititi == -1) {
        perror("\nEroare la read");
        close(fd);
        exit(EXIT_FAILURE);
    }


    close(fd);
    printf("Descriptor inchis. Program terminat.\n");

    return 0;
}