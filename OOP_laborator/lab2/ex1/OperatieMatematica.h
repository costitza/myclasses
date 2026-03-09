#pragma once
#include <iostream>
#include "Fractie.h"

class OperatieMatematica
{
private:
    Fractie f1;
    Fractie f2;

public:
    OperatieMatematica();
    OperatieMatematica(Fractie a, Fractie b);

    void afisSuma() const;
};