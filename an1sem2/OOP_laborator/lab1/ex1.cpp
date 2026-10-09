//
// Created by ababe on 3/2/2026.
//

#include <bits/stdc++.h>

using namespace std;

int main(){
    int n;
    cin >> n;

    int* arr = new int[n];

    for (int i = 0; i < n; i++){
        int x;
        cin >> x;

        *(arr + i) = x;
    }

    for (int i = 0; i < n; i++){
        cout << *(arr + i) << " ";
    }

    return 0;
}