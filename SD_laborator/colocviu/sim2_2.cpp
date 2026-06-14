#include <bits/stdc++.h>

using namespace std;

int heap[100001];
int sz;

int parinte(int pos){
    return pos / 2;
}

int fiu_stanga(int pos){
    return pos * 2;
}

int fiu_dreapta(int pos){
    return pos * 2 + 1;
}

void up(int pos){
    while(pos > 1 && heap[parinte(pos)] > heap[pos]){
        swap(heap[parinte(pos)], heap[pos]);

        pos = parinte(pos);
    }
}


void add(int x){
    sz++;
    heap[sz] = x;
    up(sz);
}


void down(int pos){
    while(1){
        if(fiu_stanga(pos) > sz){
            return;
        }
        int fiu = fiu_stanga(pos);

        if(fiu_dreapta(pos) <= sz && heap[fiu_dreapta(pos)] < heap[fiu]){
            fiu = fiu_dreapta(pos);
        }

        if(heap[fiu] < heap[pos]){
            swap(heap[fiu], heap[pos]);
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
    int n;
    cin >> n;

    for(int i = 0;i < n;i++){
        int val;
        cin >> val;
        add(val);
    }

    int sum = 0;

    while(sz > 1){
        int x = heap[1];
        del();
        int y = heap[1];
        del();
        add(x + y);
        sum += x + y;
    }

    cout << sum;
    return 0;
}