#include <bits/stdc++.h>

using namespace std;

struct Coada{
    int info;
    Coada* next;
};


void push(Coada* &head, Coada* &last, int x){
    Coada* p = new Coada();

    p -> info = x;
    p -> next = nullptr;

    if(head == nullptr){
        head = last = p;
    }
    else{
        last -> next = p;
        last = p;
    }
}


void pop(Coada* &head, Coada* &last){
    if(head == last){
        delete head;
        head = last = nullptr;
    }
    else{
        Coada* t = head;
        head = head -> next;
        delete t;
    }
}


int front(Coada* head){
    return head -> info;
}

bool empty(Coada* head){
    return head == nullptr;
}

int main(){
    Coada* head = nullptr;
    Coada* last = nullptr;



    return 0;
}