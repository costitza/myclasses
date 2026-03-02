//
// Created by ababe on 3/2/2026.
//
#include <bits/stdc++.h>

using namespace std;

int main(){

    long long suma = 0;
    // cout << suma;

    for(int s = 200; s <= 7000001; s++){
        if (s % 7 == 0){
            suma += s;
        }
    }
    cout << suma;

    return 0;
}