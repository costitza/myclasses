#include <bits/stdc++.h>
#include <queue>
#include <vector>


using namespace std;

ifstream in("dijkstra.in");
ofstream out("dijkstra.out");

const int NMAX = 5e4;
int n, m;

vector<pair<int, int>> L[NMAX + 1];
int d[NMAX + 1], vis[NMAX + 1];


void dijkstra(int s){
    for(int i = 1;i <= n;i ++){
        d[i] = 1e9;
    }

    d[s] = 0;
    priority_queue<pair<int, int>> pq;
    pq.push({-d[s], s});

    while(!pq.empty()){
        int nod = pq.top().second;
        pq.pop();

        if(vis[nod]) continue;

        vis[nod] = 1;
        for(auto it : L[nod]){
            int vec = it.first;
            int cost = it.second;

            if(d[vec] > d[nod] + cost){
                d[vec] = d[nod] + cost;
                pq.push({-d[vec], vec});
            }
        }
    }
}


int main(){
    in >> n >> m;

    for(int i = 1;i <= m;i ++){
        int x, y, c;
        in >> x >> y >> c;
        L[x].push_back({y, c});
    }

    dijkstra(1);

    for(int i = 2;i <= n;i ++){
        if (d[i] == 1e9){
            out << "0 ";
        }
        else{
            out << d[i] << ' ';
        }
    }

    return 0;
}