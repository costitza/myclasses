#include <bits/stdc++.h>
#include <iterator>
#include <queue>


using namespace std;

ifstream in("maxflow.in");
ofstream out("maxflow.out");

const int NMAX = 1e3;
vector<int> G[NMAX + 1];
int capacitate[NMAX + 1][NMAX + 1], flux[NMAX + 1][NMAX + 1];
int n, m;
int vis[NMAX + 1], p[NMAX + 1];

int flow(int sursa, int dest){
    for(int i = 1; i <= n; i++){
        vis[i] = p[i] = 0;
    }

    queue<int> q;
    q.push(sursa);
    vis[sursa] = 1;

    while(!q.empty()){
        int node = q.front();
        q.pop();

        for(auto vec : G[node]){
            if(!vis[vec] && capacitate[node][vec] - flux[node][vec] > 0){
                vis[vec] = 1;
                q.push(vec);
                p[vec] = node;
            }
        }


    }

    if (vis[dest] == 0) return 0;
    vector<int> drum;

    int x = dest;

    while(x != sursa){
        drum.push_back(x);
        x = p[x];
    }
    drum.push_back(sursa);

    reverse(drum.begin(), drum.end());

    int f = 1e9;

    for(int i = 0;i < drum.size() - 1; i++){
        int x = drum[i];
        int y = drum[i + 1];

        f = min(f, capacitate[x][y] - flux[x][y]);
    }

    for(int i = 0;i < drum.size() - 1; i ++){
        int x = drum[i];
        int y = drum[i + 1];


        flux[x][y] += f;
        flux[y][x] -= f;
    }

    return f;
}

int main(){
    
    in >> n >> m;

    for(int i = 1; i <= m;i ++){
        int x, y, c;
        in >> x >> y >> c;

        G[x].push_back(y);
        G[y].push_back(x);

        capacitate[x][y] += c;

    }
    int sum = 0;

    while(true){
        int val = flow(1, n);

        if(val == 0){
            break;
        }

        sum += val;
    }


    out << sum;
    return 0;
}