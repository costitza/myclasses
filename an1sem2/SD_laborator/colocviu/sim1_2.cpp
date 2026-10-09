#include <bits/stdc++.h>

using namespace std;

struct Node{
    int dist;
    int val;
};

int sz;
Node heap[100001];


int parinte(int pos){
    return pos / 2;
}

int stanga(int pos){
    return pos * 2;
}

int dreapta(int pos){
    return pos * 2 + 1;
}

bool cmp(Node a, Node b){
    if (a.dist > b.dist){
        return true;
    }
    if(a.dist == b.dist && a.val > b.val){
        return true;
    }

    return false;
}


void up(int pos){
    while(pos > 1 && cmp(heap[pos], heap[parinte(pos)])){
        swap(heap[pos], heap[parinte(pos)]);

        pos = parinte(pos);
    }
}

void add(Node elem){
    sz ++;
    heap[sz] = elem;
    up(sz);
}


void down(int pos){
    while(1){
        if(stanga(pos) > sz){
            return;
        }
        int fiu = stanga(pos);
        if(dreapta(pos) <= sz && cmp(heap[dreapta(pos)], heap[fiu])){
            fiu = dreapta(pos);
        }
        if(cmp(heap[fiu], heap[pos])){
            swap(heap[pos], heap[fiu]);
            pos = fiu;
        }
        else{
            return;
        }
    }
}


void del(){
    swap(heap[1], heap[sz]);
    sz --;
    down(1);
}

int main(){
    int n, x, k;
    cin >> n >> k >> x;
    for(int i = 0; i < n;i++){
        int val;
        cin >> val;
        Node aux = {abs(val - x), val};
        if(sz < k){
            add(aux);
        }
        else{
            if(cmp(heap[1], aux)){
                del();
                add(aux);
            }
        }
    }

    while(sz){
        cout << heap[1].val << ' ';
        del();
    }

    return 0;
}