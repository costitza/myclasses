//
// Created by ababe on 3/2/2026.
//


#include <bits/stdc++.h>

using namespace std;

class Angajati{
private:
    char* nume;
    double salariu;
    int id;

public:
    Angajati(){
        nume = nullptr;
    }
    Angajati(char* _nume, double _salariu, int _id){

        id = _id;
        salariu = _salariu;

        int length = strlen(_nume);
        nume = new char[length + 1];

        strcpy(nume, _nume);
    }

    Angajati& operator=(const Angajati& other){
        delete[] nume;

        id = other.id;
        salariu = other.salariu;

        nume = new char[strlen(other.nume) + 1];
        strcpy(nume, other.nume);

        return *this;
    }

    ~Angajati(){
        delete[] nume;
    }

    // getter
    double getSalariu() const{
        return salariu;
    }

    char* getNume() const{
        return nume;
    }

    // setter
    void setNume(char* sursa){
        nume = new char[strlen(sursa) + 1];
        strcpy(nume, sursa);
    };

    void afis() const{

        // setNume("salut");

        cout << "nume: " << nume << ", salariu: " << salariu << ", id: " << id << '\n';
    }
};


void salariuMare(Angajati* list, int n){

    int maxim = -1;
    int index = 0;
    for (int i = 0; i < n;i ++){
        if(maxim < list[i].getSalariu()){
            maxim = list[i].getSalariu();
            index = i;
        }
    }

    cout << "\ncel mai smeker este: " << list[index].getNume() << '\n';
    return;
}


int main(){
    int n;
    cin >> n;

    Angajati* angajati = new Angajati[n];

    char* nume = new char[255];
    for (int i = 0; i < n; i++){
        int id;
        double salariu;
        cin.ignore();
        cin.getline(nume, 255);

        //cin.get();
        cin >> id;
        cin >> salariu;

        *(angajati + i) = Angajati(nume, salariu, id);
    }

    for (int i = 0; i < n; i++){
        (angajati + i) -> afis();
    }

    salariuMare(angajati, n);

    return 0;
}