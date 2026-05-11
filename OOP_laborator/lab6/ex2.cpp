#include <bits/stdc++.h>

using namespace std;


class Produs{
    string nume;
    int pret;
public:
    Produs(string n, int p) : nume(n), pret(p) {};

    bool operator<(const Produs& other){
        return this -> pret < other.pret;
    } 

    friend ostream& operator<<(ostream& os, const Produs& p){
        os << p.nume << " " << p.pret;
        return os;
    }
};


template <typename T>
class Depozit{
    vector<T> arr;

public: 

    void adauga(const T& el){
        arr.push_back(el);
    }

    void sorteaza(){
        sort(arr.begin(), arr.end());
    }

    void afis(){
        for(const auto& el : arr){
            cout << el << ' ';
        }
        cout << '\n';
    }
};

int main(){
    Depozit<int> depozitInt;
    depozitInt.adauga(10);
    depozitInt.adauga(2);
    depozitInt.adauga(7);
    depozitInt.sorteaza();
    depozitInt.afis();


    Depozit<Produs> depozitProduse;
    depozitProduse.adauga(Produs("Laptop", 3500.50));
    depozitProduse.adauga(Produs("Mouse", 150.0));
    depozitProduse.adauga(Produs("Tastatura", 250.0));
    depozitProduse.sorteaza();
    depozitProduse.afis();
}

