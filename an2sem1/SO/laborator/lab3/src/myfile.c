#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/sysmacros.h>
#include <time.h>


void citfisier(const char* infofisier){
    struct stat sb;

    if (lstat(infofisier, &sb) == -1) {
        perror("lstat");
        
        return;
    }

    printf("File type for: %s -> ", infofisier);

    switch (sb.st_mode & S_IFMT) {
    case S_IFBLK:  printf("block device\n");            break;
    case S_IFCHR:  printf("character device\n");        break;
    case S_IFDIR:  printf("directory\n");               break;
    case S_IFIFO:  printf("FIFO/pipe\n");               break;
    case S_IFLNK:  printf("symlink\n");                 break;
    case S_IFREG:  printf("regular file\n");            break;
    case S_IFSOCK: printf("socket\n");                  break;
    default:       printf("unknown?\n");                break;
    }

    return;
}

int main(int argc, char *argv[])
{

    if (argc < 2) {
        printf("Utilizare : %s file1 file2 ..", argv[0]);
        return 1;
    }


    for(int i = 1;i < argc; i++){
        citfisier(argv[i]);
    }

    return 0;
}