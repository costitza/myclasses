#include "ProdusDigital.cpp"

class Ebook : public ProdusDigital{
private:
    std::string format;
public:
    Ebook(std::string t, double p, int mb, std::string f): ProdusDigital(t, p, mb), format(f){}
    Ebook(const Ebook& other){
        this->titlu = other.titlu;
        this->pretBaza = other.pretBaza;
        this->dimensiuneMB = other.dimensiuneMB;
        this->format = other.format;
    }

    std::ostream& afisare(std::ostream& out) const override {
        ProdusDigital::afisare(out);
        out << " | Format: " << format;
        return out;
    }
};