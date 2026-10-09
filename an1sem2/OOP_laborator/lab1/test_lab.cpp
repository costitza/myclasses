#include <bits/stdc++.h>

using namespace std;

int sum(int x){
    int s = 0;
    do{
        s += x % 10;
        x /= 10;
    }while(x != 0);

    return s;
}

int main(){
    int x;
    cin >> x;

    if (sum(x) % 2 == 0){
        cout << "suma este para";
    }
    else{
        cout << "suma nu este para";
    }

}