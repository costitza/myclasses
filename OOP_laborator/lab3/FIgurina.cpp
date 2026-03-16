#include "ProdusFizic.cpp"

class Figurina : public ProdusFizic{
private:
    std::string numePersonaj, numeShow;
public:
    Figurina(std::string t, double p, double g, std::string np, std::string ns): ProdusFizic(t, p, g), numePersonaj(np), numeShow(ns) {}

    std::ostream& afisare(std::ostream& out) const override {
        ProdusFizic::afisare(out);
        out << " | Personaj: " << numePersonaj << " (" << numeShow << ")";
        return out;
    }
};