#include "Produs.cpp"

class ProdusDigital : public Produs{
protected:
    int dimensiuneMB;

public:
    ProdusDigital(){}
    ProdusDigital(std::string title, double pret, int dim): Produs(title, pret), dimensiuneMB(dim){}


    double getPretFinal() const override{
        return this->pretBaza;
    }

    std::ostream& afisare(std::ostream& out) const override{
        out << "[Digital] " << titlu << " | Dimensiune: " << dimensiuneMB 
            << "kg | Pret Total: " << getPretFinal();
        return out;
    }
};