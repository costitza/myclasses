#include "OperatieMatematica.h"

OperatieMatematica::OperatieMatematica(): f1(0, 1), f2(0, 1){   
}

OperatieMatematica::OperatieMatematica(Fractie a, Fractie b): f1(a), f2(b){
}

void OperatieMatematica::afisSuma() const{
    std::cout << "Urmeaza suma: \n" << (this -> f1 + this -> f2) << '\n';
}