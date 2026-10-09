#include <bits/stdc++.h>

class Produs{
protected:
    std::string titlu;
    double pretBaza;
public:
    Produs(){}
    Produs(std::string t, double pret): titlu(t), pretBaza(pret){};

    virtual ~Produs() {}

    virtual double getPretFinal() const = 0;

    operator double() const {
        return getPretFinal();
    }

    virtual std::ostream& afisare(std::ostream& out) const = 0;
    friend std::ostream& operator<<(std::ostream& out, const Produs& prod){
        return prod.afisare(out);
    }
};

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

        return total;
    }

    void afiseazaStoc(){
        for(auto p: catalog){
            std::cout << *p << '\n';

        }
    }
};

using namespace std;

int main() {
    Librarie lib;

    lib.adauga(new Carte("Dune", 50.0, 0.8, "Frank Herbert"));
    lib.adauga(new Figurina("Batman", 120.0, 0.5, "Bruce Wayne", "DC"));
    lib.adauga(new Ebook("C++ Guide", 30.0, 5, "PDF"));

    lib.afiseazaStoc();
    std::cout << "Valoare totala inventar: " << lib.calculTotal() << " RON" << std::endl;

    return 0; 
}