#include "Produs.cpp"

class ProdusFizic : public Produs{
private:
    double greutate;

public:
    ProdusFizic(){}
    ProdusFizic(std::string title, double pret, double weight): Produs(title, pret), greutate(weight){}

    double getPretFinal() const override{
        return pretBaza + 0.5 * greutate;
    }

    std::ostream& afisare(std::ostream& out) const override{
        out << "[Fizic] " << titlu << " | Greutate: " << greutate 
            << "kg | Pret Total: " << getPretFinal();
        return out;
    }
};