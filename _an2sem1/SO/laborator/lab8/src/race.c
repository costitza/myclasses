#include <stdio.h>
#include <pthread.h>
#include <time.h>

pthread_mutex_t buffer_mutex;

void myprint(const char* msg){
    pthread_mutex_lock(&buffer_mutex);
    for (int i = 0; msg[i] != '\0'; i++) {
        putchar(msg[i]);
    }
    pthread_mutex_unlock(&buffer_mutex);
}

void *run(void* arg){
    for(int i = 0;i < 10; i ++){
        myprint((char *)arg);
    }

    return NULL;
}

int main(){
    pthread_t t1, t2;

    pthread_mutex_init(&buffer_mutex, NULL);

    pthread_create(&t1, NULL, run, "Thread 1111\n");
    pthread_create(&t2, NULL, run, "Thread 2222\n");
    
    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    pthread_mutex_destroy(&buffer_mutex);
    return 0;
}