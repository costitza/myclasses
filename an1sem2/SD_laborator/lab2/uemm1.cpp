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

const int NMAX = 1e5;
int a[NMAX + 1];
int sol[NMAX + 1];

int main(){

    Stiva* st = nullptr;

    int n;
    cin >> n;
    for(int i = 1;i <= n;i ++){
        cin >> a[i];
        sol[i] = -1;
    }

    for(int i = 1;i <= n;i++){
        while(!empty(st) && a[i] > a[top(st)]){
            sol[top(st)] = a[i];
            pop(st);
        }
        push(st, i);
    }


    for(int i = 1;i <= n;i++){
        cout << sol[i] << ' '; 
    }
    return 0;
}