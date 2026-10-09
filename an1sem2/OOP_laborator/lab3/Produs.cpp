#include <iostream>

class Produs{
protected:
    std::string titlu;
    double pretBaza;
public:
    Produs(){}
    Produs(std::string t, double pret): titlu(t), pretBaza(pret){};

    virtual ~Produs();

    virtual double getPretFinal() const = 0;

    operator double() const {
        return getPretFinal();
    }

    virtual std::ostream& afisare(std::ostream& out) const = 0;
    friend std::ostream& operator<<(std::ostream& out, const Produs& prod){
        return prod.afisare(out);
    }
};
