#include <bits/stdc++.h>

using namespace std;

int total[2005][2005];
int mat[2005][2005];

int st[2005];
int top_st = 0;

int main(){

    int n, m;
    cin >> n >> m;
    int k;
    cin >> k;

    for(int i = 0;i < n; i++){
        for(int j = 0;j < m;j ++){
            int x;
            cin >> x;
            total[i][j] = 1;
            mat[i][j] = x;
        }
    }

    // stanga
    for(int i = 0;i < n;i++){

        top_st = 0;
        for(int j = 0;j < m; j++){

            while(top_st && mat[i][st[top_st]] <= mat[i][j]){
                top_st --;
            }

            int ind;
            if(top_st == 0){
                ind = -1;
            }
            else{
                ind = st[top_st];
            }

            int dist = j - ind - 1;
            total[i][j] += min(k, dist);

            st[++top_st] = j;
        }
    }


    // dreapta
    for(int i = 0;i < n;i++){

        top_st = 0;
        for(int j = m - 1;j >= 0; j--){

            while(top_st && mat[i][st[top_st]] <= mat[i][j]){
                top_st --;
            }

            int ind;
            if(top_st == 0){
                ind = m;
            }
            else{
                ind = st[top_st];
            }

            int dist = ind - j - 1;
            total[i][j] += min(k, dist);

            st[++top_st] = j;
        }
    }


    // sus
    for (int j = 0; j < m;j++){

        top_st = 0;
        for(int i = 0;i < n;i++){
            while(top_st && mat[st[top_st]][j] <= mat[i][j]){
                top_st--;
            }

            int ind;
            if(top_st == 0){
                ind = -1;
            }
            else{
                ind = st[top_st];
            }

            int dist = i - ind - 1;
            total[i][j] += min(k, dist);

            st[++top_st] = i;
        }
    }


    // jos
    for (int j = 0; j < m;j++){

        top_st = 0;
        for(int i = n - 1;i >= 0;i--){
            while(top_st && mat[st[top_st]][j] <= mat[i][j]){
                top_st--;
            }

            int ind;
            if(top_st == 0){
                ind = n;
            }
            else{
                ind = st[top_st];
            }

            int dist = ind - i - 1;
            total[i][j] += min(k, dist);

            st[++top_st] = i;
        }
    }


    int maxim = 0;
    for(int i = 0;i < n;i++){
        for(int j = 0;j < m;j++){
            maxim = max(maxim, total[i][j]);
        }
    }

    cout << maxim;
    return 0;
}