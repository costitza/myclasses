#include <bits/stdc++.h>

using namespace std;

struct Stiva{
    int info;
    Stiva* next;
};

void push(Stiva* &st, int x){
    Stiva* p = new Stiva();
    p -> info = x;

    p -> next = nullptr;

    if(st == nullptr){
        st = p;
    }
    else{
        p -> next = st;
        st = p;
    }
}


void pop(Stiva* &st){
    Stiva* t = st;
    st = st -> next;
    delete t;
}


int top(Stiva* st){
    return st -> info;
}

bool empty(Stiva* st){
    return st == nullptr;
}

int main(){

    Stiva* st = nullptr;

    push(st, 3);
    push(st, 5);
    push(st, 1);
    cout << top(st) << '\n';
    pop(st);
    cout << top(st) << '\n';

    return 0;
}