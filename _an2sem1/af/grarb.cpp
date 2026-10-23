#include <bits/stdc++.h>

using namespace std;

ifstream in("input/grarb.in");
ofstream out("output/grarb.out");

vector<int> ar[100000 + 1];
int vis[100000 + 1];

int nrn, nrm;


void dfs(int node){
    vis[node] = 1;
    nrn ++;
    for(auto vec : ar[node]){

        nrm++;
        if(vis[vec] == 0){
            dfs(vec);
        }
    }
}

int main(){
    int n, m;
    in >> n >> m;
    
    for(int i = 1;i <= m;i++){
        int x, y;
        in >> x >> y;
        ar[x].push_back(y);
        ar[y].push_back(x);
    }

    int cc = 0;
    int sol = 0;

    for(int i = 1;i <= n;i ++){

        nrn = 0;
        nrm = 0;
        if(vis[i] == 0){
            cc++;
            dfs(i);

            nrm /= 2;
            sol += nrm - (nrn - 1);
        }
    }


    out << sol << '\n' << cc - 1;
    return 0;
}