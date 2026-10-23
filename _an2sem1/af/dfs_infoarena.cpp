#include <bits/stdc++.h>

using namespace std;

ifstream in("dfs.in");
ofstream out("dfs.out");

vector<int> ar[100000 + 1];
int vis[100000 + 1];


void dfs(int node){
    vis[node] = 1;
    for(auto vec : ar[node]){
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

    for(int i = 1;i <= n;i ++){
        if(vis[i] == 0){
            cc++;
            dfs(i);
        }
    }


    out << cc;
    return 0;
}