//
// Created by ababe on 3/2/2026.
//
#include <bits/stdc++.h>

using namespace std;

class Masina{
private:
    int roti;
    int usi;

public:
    Masina(int r, int u): roti(r), usi(u) {}

    void afis() const{
        cout << "roti: " << roti << ", usi: " << usi << '\n';
    }
};

int main(){

    Masina car1(4, 4);

    car1.afis();

    Masina* car2 = new Masina(3, 3);

    car2->afis();
    return 0;
}
