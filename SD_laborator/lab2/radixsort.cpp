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


int nrc(int x){
    int res = 0;
    while(x > 0){
        x /= 10;
        res ++;   
    }
    return res;
}

int a[1000001];

int main(){
    Coada* head[10] = {nullptr};
    Coada* last[10] = {nullptr};

    int n, pasi = 0;
    cin >> n;
    for(int i = 1; i <= n;i++){
        cin >> a[i];
        pasi = max(pasi, nrc(a[i]));
    }   

    int p = 1;
    for(int i = 1; i <= pasi; i++){
        for(int j = 1;j <= n;j++){
            int c = (a[j] / p) % 10;
            push(head[c], last[c], a[j]);
        }
        int nr = 0;

        for(int j = 0;j <= 9;j ++){
            while(!empty(head[j])){
                nr ++;
                a[nr] = front(head[j]);
                pop(head[j], last[j]);
            }
        }
        p *= 10;
    }


    for(int i = 1;i <= n;i++){
        cout << a[i] << ' ';
    }
    return 0;
}