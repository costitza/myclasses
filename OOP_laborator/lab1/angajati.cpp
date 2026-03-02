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
    Angajati(char* _nume, double _salariu, int _id){

        id = _id;
        salariu = _salariu;

        int length = strlen(_nume);
        nume = new char[length + 1];

        strcpy(nume, _nume);
    }

    ~Angajati(){
        delete[] nume;
    }

    // getter
    double getSalariu(){
        return salariu;
    }

    // setter
    void setNume(char* sursa){
        nume = new char[strlen(sursa) + 1];
        strcpy(nume, sursa);
    };
};

int main(){
    return 0;
}