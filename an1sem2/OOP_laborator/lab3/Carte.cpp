#include "ProdusFizic.cpp"

class Carte : public ProdusFizic{
private:
    std::string author;
public:
    Carte(std::string t, double p, double g, std::string a) 
        : ProdusFizic(t, p, g), author(a) {}

    std::ostream& afisare(std::ostream& out) const override {
        ProdusFizic::afisare(out); 
        out << " | Autor: " << author;
        return out;
    }
};