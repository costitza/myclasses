#include <bits/stdc++.h>
#include <vector>

using namespace std;

ifstream in("berarii2.in");
ofstream out("berarii2.out");

vector<int> ar[1000000 + 1];
int d[1000000 + 1];
const int INF = 1e9;
int n;

void bfs(vector<int> surse){
    for(int i = 1;i <= n;i++){
        d[i] = INF;
    }

    queue<int> q;
    for(auto x : surse){
        d[x] = 0;
        q.push(x);
    }

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
        ar[y].push_back(x);
    }

    vector<int> b;
    for(int i = 1;i <= s;i++){
        int x;
        in >> x;
        b.push_back(x);
    }

    bfs(b);
    vector<int> sol;
    for(int i = 1;i <= n;i++){
        if(d[i] == INF){
            sol.push_back(i);
        }
    }

    out << sol.size() << '\n';
    for(auto elem : sol){
        out << elem << '\n';
    }
    return 0;
}