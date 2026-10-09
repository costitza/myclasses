#include "Produs.cpp"
#include <vector>

class Librarie{
private:
    std::vector<Produs*> catalog;

public:
    ~Librarie(){
        for (auto p: catalog){
            delete p;
        }
        
    }

    void adauga(Produs* p){
        catalog.push_back(p);
    }

    double calculTotal(){
        double total = 0;
        for(auto p: catalog){
            total += p->getPretFinal();
        }
    }

    void afiseazaStoc(){
        for(auto p: catalog){
            std::cout << p << '\n';
        }
    }
};