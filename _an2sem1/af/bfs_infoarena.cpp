#include <bits/stdc++.h>

using namespace std;

ifstream in("bfs.in");
ofstream out("bfs.out");

vector<int> ar[100000 + 1];
int d[100000 + 1];
const int INF = 1e9;
int n;

void bfs(int sursa){
    for(int i = 1;i <= n;i++){
        d[i] = INF;
    }

    d[sursa] = 0;
    queue<int> q;

    q.push(sursa);
    while(!q.empty()){
        int node = q.front();

        q.pop();
        for(auto vec : ar[node]){
            if(d[vec] > d[node] + 1){
                d[vec] = d[node] + 1;
                q.push(vec);
            }
        }
    }
}


int main(){
    int m, s;
    in >> n >> m >> s;
    
    for(int i = 1;i <= m;i++){
        int x, y;
        in >> x >> y;
        ar[x].push_back(y);
    }

    bfs(s);

    for(int i = 1;i <= n;i++){
        if(d[i] == INF){
            out << -1 << ' ';
        }
        else{
            out << d[i] << " ";
        }
    }
    return 0;
}