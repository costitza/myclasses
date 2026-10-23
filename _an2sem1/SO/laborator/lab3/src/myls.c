#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>

int main(int argc, char *argv[]) {

    DIR *dir = opendir(argv[1]);
    if (dir == NULL) {
        perror("Eroare la opendir");
        return 1;
    }

    struct dirent *intrare;

    while ((intrare = readdir(dir)) != NULL) {


        printf("%s\n", intrare->d_name);
    }

    closedir(dir);
    return 0;
}