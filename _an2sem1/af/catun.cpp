#include <bits/stdc++.h>
#include <queue>
#include <vector>


using namespace std;

ifstream in("catun.in");
ofstream out("catun.out");

const int NMAX = 5e4;
int n, m, k;

vector<pair<int, int>> L[NMAX + 1];
int d[NMAX + 1], vis[NMAX + 1];
int fort[NMAX + 1];


void dijkstra(vector<int> s){
    for(int i = 1;i <= n;i ++){
        d[i] = 1e9;
    }

    priority_queue<pair<int, int>> pq;

    for(auto x : s){
        d[x] = 0;
        pq.push({-d[x], x});
        fort[x] = x;
    }

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
                fort[vec] = fort[nod];
            }
            else if(d[vec] == d[nod] + cost){
                fort[vec] = min(fort[vec], fort[nod]);
            }
        }
    }
}


int main(){

    in >> n >> m >> k;

    vector<int> s;
    for(int i = 0;i < k;i ++){
        int x;
        in >> x;
        s.push_back(x);
    }

    for(int i = 1;i <= m;i ++){
        int x, y, c;
        in >> x >> y >> c;
        L[x].push_back({y, c});
        L[y].push_back({x, c});
    }

    dijkstra(s);

    for(int i = 1;i <= n;i ++){
        if (d[i] == 1e9 || fort[i] == i){
            out << "0 ";
        }
        else{
            out << fort[i] << ' ';
        }
    }

    return 0;
}