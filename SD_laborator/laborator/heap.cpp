#include <bits/stdc++.h>

using namespace std;

struct Node{
    int dist;
    int val;
};

int sz;
Node H[100000];

int p(int pos){
    return pos /2;
}

int ls(int pos){
    return 2 * pos;
}


int rs(int pos){
    return 2 * pos + 1;
}


bool cmp(Node n1, Node n2){
    if (n1.dist > n2.dist){
        return true;
    }

    if(n1.dist == n2.dist && n1.val > n2.val){
        return true;
    }

    return false;
}


void up(int pos){
    while(pos > 1 && cmp(H[pos], H[p(pos)])){
        swap(H[pos], H[p(pos)]);
        pos = p(pos);
    }
}


void add(Node x){
    sz ++;
    H[sz] = x;

    up(sz);
}


void down(int pos){
    while(1){
        if(ls(pos) > sz){
            break;
        }

        int fiu = ls(pos);

        if(rs(pos) <= sz && cmp(H[rs(pos)], H[fiu])){
            fiu = rs(pos);
        }

        if(cmp(H[fiu], H[pos])){
            swap(H[fiu], H[pos]);
            pos = fiu;
        }
        else{
            break;
        }
    }
}


void del(){
    swap(H[1], H[sz]);

    sz--;
    down(1);
}


int main(){
    int n, k, x;

    cin >> n >> k >> x;


    for (int i = 0;i < n;i++){
        int val;
        cin >> val;

        Node aux = {abs(val - x), val};

        if(sz < k){
            add(aux);
        }
        else{
            if (cmp(H[1], aux)){
                del();

                add(aux);
            }
        }
    }

    while(sz > 0){
        cout << H[1].val << ' ';
        del();
    }
}