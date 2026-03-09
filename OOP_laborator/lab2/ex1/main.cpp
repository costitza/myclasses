#include <iostream>
#include "Fractie.h"
#include "OperatieMatematica.h"
#include "FractiePozitiva.h"

using namespace std;

int main(){

    Fractie f1(1, 2);
    Fractie f2(f1);

    if (f1 == f2)
        cout << "da\n";

    cout << ++f1 << '\n';
    Fractie f3 = f2++;

    cout << f3 << '\n';

    // citire + afisare
    Fractie fUser;
    cin >> fUser;
    cout << fUser;

    Fractie f(1, 2);
    OperatieMatematica op(f, fUser);
    op.afisSuma();

    Fractie fNeg(-1, 90);
    cout << fNeg;

    FractiePozitiva fPoz(-1, 90);
    cout << fPoz;
}