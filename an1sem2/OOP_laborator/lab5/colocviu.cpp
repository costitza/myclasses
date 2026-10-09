#include <iostream>
#include <vector>
#include <string>
#include <ctime>
#include <memory>

enum class Locatie {
    Suprafata, Subteran
};


class Bilet{
protected:
    double pret;
public:
    Bilet(double p) : pret(p) {

    }
    virtual ~Bilet() = default;
    virtual bool esteValid(Locatie loc) const = 0;
    virtual void afiseaza() const = 0;
};


class BiletSuprafata : public Bilet {

public:
    BiletSuprafata() : Bilet(2.0) {}
    bool esteValid(Locatie loc) const override{
        return loc == Locatie :: Suprafata;
    }
    void afiseaza() const override{
        std :: cout << "Bilet de [suprafata]";
    }
};


class BiletMetrou : public Bilet{
public:
    BiletMetrou() : Bilet(2.5) {}
    bool esteValid(Locatie loc) const override{
        return loc == Locatie :: Subteran;
    }
    void afiseaza() const override{
        std :: cout << "Bilet de [Metrou]";
    }
};

class BiletTranzit : public Bilet{
protected:
    time_t createdAt = time(0) + 3600 + 1800;

public:
    BiletTranzit() : Bilet(3.0) {}
    bool esteValid(Locatie loc) const override{
        return (time(0) <= createdAt);
    }
    void afiseaza() const override{
        std :: cout << "Bilet de [tranzit]";
    }
};


class Card{
protected:
    int contorValidari;
    std :: vector<std :: unique_ptr<Bilet>> portofel;
    std :: vector<const Locatie> locatiiValide;

public:
    Card() : contorValidari(0) {}
    ~Card() = default;

    bool valideaza(Locatie loc){
        for (auto it = portofel.begin(); it != portofel.end(); it++){
            if ((*it) -> esteValid(loc)){
                std :: cout << "Validare reusita";
                (*it) -> afiseaza();

                std :: cout << "\n";
                portofel.erase(it);
                contorValidari ++;
                
                if(contorValidari > 0 && contorValidari % 8 == 0){
                    std :: cout << "Ai primit bilet gratis\n";
                    adaugaBiletGratis();
                }
                return true;
            }
        }

        std :: cout << "Validare esuata!\n";
        return false;
    }

    virtual void adaugaBilet(std :: unique_ptr<Bilet> bilet){
        portofel.push_back(std :: move(bilet));
        std :: cout << "Bilet incarcat pe card\n";
    }

    virtual void adaugaBiletGratis() = 0;
};

class CardSuprafata : public Card{

public:
    CardSuprafata() : Card() {
        locatiiValide = {Locatie :: Suprafata};
    }

    void adaugaBiletGratis() override{
        adaugaBilet(std :: make_unique<BiletSuprafata>());
    }
};


class CardSubteran : public Card{

public:
    CardSubteran() : Card() {
        locatiiValide = {Locatie :: Subteran};
    }

    void adaugaBiletGratis() override{
        adaugaBilet(std :: make_unique<BiletMetrou>());
    }
};

class CardTranzit : public Card{

public:
    CardTranzit() : Card(){
        locatiiValide = {Locatie :: Suprafata, Locatie :: Subteran};
    }

    void adaugaBilet(std :: unique_ptr<Bilet> bilet) override {
        if (dynamic_cast<BiletTranzit*>(bilet.get())){
            portofel.push_back(bilet);
        }
        else{
            std :: cout << "Nu s-a putut aduaga bilet\n";
        }
    }
};


class Aparat {
    Locatie locatie;

public: 
    Aparat(Locatie loc) : locatie(loc){}

    void proceseazaCard(std :: shared_ptr<Card> card){
        card -> valideaza(locatie);
    }
};