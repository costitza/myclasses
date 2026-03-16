#include "ProdusDigital.cpp"

class Game : public ProdusDigital{
private:
    std::string type;
public:
    Game(std::string t, double p, int d, std::string ty): ProdusDigital(t, p, d), type(ty){}

    std::ostream& afisare(std::ostream& out) const override{
        out << " | Type " << type;
        return out;
    }
};