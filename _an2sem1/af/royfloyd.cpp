#include <bits/stdc++.h>
#include <queue>
#include <vector>


using namespace std;

ifstream in("royfloyd.in");
ofstream out("royfloyd.out");

const int NMAX = 1e3;
int n, m;

int d[NMAX + 1][NMAX + 1];
// distanta minima de la i la j

int main(){
    int n;
    in >> n;

    for(int i = 1;i <= n;i++){
        for(int j = 1;j <= n;j++){
            in >> d[i][j];

            if(i != j && d[i][j] == 0){
                d[i][j] = 1e9;
            }
        }
    }

    for(int k = 1;k <= n;k++){
        for(int i = 1;i <= n;i++){
            for(int j = 1;j <= n;j ++){
                if(d[i][j] > d[i][k] + d[k][j]){
                    d[i][j] = d[i][k] + d[k][j];
                }
            }

        }
    }


    for(int i = 1;i <= n;i ++){
        for(int j = 1;j <= n;j ++){
            out << d[i][j] << ' ';        
        }

        out << '\n';
    }

    return 0;
}