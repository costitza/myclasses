#include <bits/stdc++.h>

using namespace std;

template <typename T>
int cautare(vector<T>& arr, T elem){
    for (int ind = 0; ind < arr.size(); ind ++){
        if (arr[ind] == elem){
            return ind;
        }
    }
    return -1;
}

int main(){
    std::vector<int> vInt = {1, 3, 5, 7};
    std::vector<double> vDouble = {1.1, 2.2, 3.3};
    std::vector<std::string> vString = {"mere", "pere", "banane"};

    cout << cautare(vInt, 5) << "\n";
    cout << cautare(vDouble, 4.4) << "\n";
    cout << cautare(vString, std::string("pere")) << "\n";
}