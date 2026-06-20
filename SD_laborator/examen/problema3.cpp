#include <bits/stdc++.h>

using namespace std;

int sz;
int heap[200004];

int parinte(int pos){
    return pos / 2;
}

int fiu_st(int pos){
    return pos * 2;
}

int fiu_dr(int pos){
    return pos * 2 + 1;
}


void up(int pos){
    while(pos > 1 && heap[pos] > heap[parinte(pos)]){
        swap(heap[pos], heap[parinte(pos)]);

        pos = parinte(pos);
    }
}


void add(int val){
    heap[++sz] = val;

    up(sz);
}

void down(int pos){

    while(1){
        if(fiu_st(pos) > sz){
            return;
        }
        int fiu = fiu_st(pos);

        if(fiu_dr(pos) <= sz && heap[fiu_dr(pos)] > heap[fiu]){
            fiu = fiu_dr(pos);
        }

        if(heap[fiu] > heap[pos]){
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
    sz--;
    down(1);
}

struct Node{
    int energ;
    int poz;
}arr[200001];

bool cmp(Node a, Node b){
    if (a.poz < b.poz) return true;

    return false;
}

int main(){

    int n, d, f;
    cin >> n >> d >> f;

    for(int i = 0;i < n; i++){
        int e, p;
        cin >> p >> e;
        arr[i].energ = e;
        arr[i].poz = p;
    }

    sort(arr, arr + n, cmp);

    /* for(int i = 0;i < n;i++){
        cout << arr[i].poz << " " << arr[i].energ << '\n';
    } */
    int iter = 0;

    long long curr_en = f;
    int pasi = 0;

    if(curr_en < arr[0].poz){
        cout << "-1";
        return 0;
    }
    add(arr[0].energ);
    iter++;

    while(curr_en < d){
        if(sz == 0){
            if(arr[iter].poz > curr_en){
                cout << "-1";
                return 0;
            }
            else if(iter == n){
                cout << "-1";
                return 0;
            }
        }

        while(iter != n && arr[iter].poz <= curr_en){
            add(arr[iter].energ);
            
            iter++;
        }

        // cout << heap[1] << ' ';
        curr_en += heap[1];
        del();
        // cout << curr_en << ' ';
        pasi++;
    }

    cout << pasi;

    return 0;
}