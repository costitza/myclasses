#include <bits/stdc++.h>
#include <climits>
#include <queue>
#include <vector>


using namespace std;

ifstream in("pedrumuriminime.in");
ofstream out("pedrumuriminime.out");

const int NMAX = 1e2;
const int INF = 1e9;
int n, m;

int d[NMAX * 3 + 1][NMAX * 3 + 1];
// distanta minima de la i la j

int main(){

    in >> n >> m;

    for(int i = 1;i <= n;i++){
        for(int j = 1;j <= n;j ++){
            if(i == j){
                d[i][j] = 0;
            }
            else{
                d[i][j] = INF;
            }
        }
    }

    for(int i = 1;i <= m;i++){
        int x, y, c;
        in >> x >> y >> c;

        d[x][y] = d[y][x] = min(d[x][y], c);
    }

    for(int k = 1;k <= n;k++){
        for(int i = 1;i <= n;i++){
            if (d[i][k] == INF) continue;
            for(int j = 1;j <= n;j ++){
                if (d[k][j] == INF) continue;
                if(d[i][j] > d[i][k] + d[k][j]){
                    d[i][j] = d[i][k] + d[k][j];
                }
            }

        }
    }


    int q;
    in >> q;
    for(int i = 1;i <= q;i++){
        int x, y, k;
        in >> x >> y >> k;

        if(d[x][y] == d[x][k] + d[k][y] && d[x][y] != INF){
            out << "1";
        }
        else {
            out << "0";
        }
    }

    return 0;
}