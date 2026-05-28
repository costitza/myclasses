// colocviu 2023

#include <bits/stdc++.h>

using namespace std;


class Drum{
protected:
    string denumire;
    float lungime;
    int nrTronsoane;

public:
    Drum(string d, float l, int n) : denumire(d), lungime(l), nrTronsoane(n) {}
    virtual ~Drum() = default;
    
    string getDenumire() const { return denumire; }
    float getLungime() const { return lungime; }
    int getTrons() const { return nrTronsoane; }

    float calcLungimeTronson() const;
    virtual float costContract() const = 0;

    virtual void afisare(ostream& os) const = 0;
    friend ostream& operator<<(ostream& os, const Drum& drum);
};

float Drum :: calcLungimeTronson() const{
    return (lungime / nrTronsoane);
}

ostream& operator<<(ostream& os, const Drum& drum){
    os << "Denum: " << drum.denumire << ", lungime: " << drum.lungime << ", nr trons: " << drum.nrTronsoane;
    drum.afisare(os);
    
    return os;
}


class DrumNat : public Drum{
    int nrJudete;

public:
    DrumNat(string d, float l, int n, int nr) : Drum(d, l, n), nrJudete(nr) {}

    float costContract() const;
    void afisare(ostream& os) const;
};

void DrumNat :: afisare(ostream& os) const{
    os << ", nr judete: " << nrJudete;
} 

float DrumNat :: costContract() const{
    return 3000 * calcLungimeTronson();
}


class Autostrada : virtual public Drum{
protected:
    int nrBenzi;

public:
    Autostrada(string d, float l, int n, int nr) : Drum(d, l, n), nrBenzi(nr) {}

    float costContract() const;
    void afisare(ostream& os) const;
};

void Autostrada :: afisare(ostream& os) const{
    os << ", nr benzi: " << nrBenzi;
} 

float Autostrada :: costContract() const{
    return 2500 * nrBenzi * calcLungimeTronson();
}


class DrumEuropean : virtual public Drum{
protected:
    int nrTari;

public:
    DrumEuropean(string d, float l, int n, int nr) : Drum(d, l, n), nrTari(nr) {}

    float costContract() const;
    void afisare(ostream& os) const;
};

void DrumEuropean :: afisare(ostream& os) const{
    os << ", nr tari: " << nrTari;
} 

float DrumEuropean :: costContract() const{
    return 3000 * calcLungimeTronson() + 500 * nrTari;
}



class AutoEuropean : public DrumEuropean, public Autostrada{

public:
    AutoEuropean(string d, float l, int n, int nrb, int nrt) : Drum(d, l, n), Autostrada(d, l, n, nrb), DrumEuropean(d, l, n, nrt) {}

    float costContract() const override;
    void afisare(ostream& os) const;
};

float AutoEuropean :: costContract() const{
    return Autostrada :: costContract() + 500 * (nrTari);
}

void AutoEuropean :: afisare(ostream& os) const {
    Autostrada :: afisare(os);

    os << ", nr tari: " << nrTari;
}


class Contract{
private:
    const int id;
    static int contor;
    string nume;
    string cif;
    shared_ptr<Drum> drum;
    int tronson;
    float cost;

public:
    Contract(string n, string c, shared_ptr<Drum> d, int t) : 
        nume(n), cif(c), tronson(t), id(contor ++){
            drum = d;
            contor ++;

            cost = d -> costContract();
        }
    
    string getCif() const { return cif; }
    shared_ptr<Drum> getDrum() const { return drum; }
    int getTronson() const { return tronson; }
    float getCost() const { return cost; }

    friend ostream& operator<<(ostream& os, const Contract& c);
};

int Contract :: contor = 100;

ostream& operator<<(ostream& os, const Contract& c){
    os << "ID: " << c.id << ", nume: " << c.nume << ", cif: " << c.cif << ", tronson: " << c.tronson << '\n';
    os << " -> drumul: " << *(c.drum);

    return os;
}


class Menu{
private:
    Menu() = default;
    Menu(const Menu& m) = delete;
    Menu& operator=(const Menu& m) = delete;

    vector<shared_ptr<Drum>> drumuri;
    vector<shared_ptr<Contract>> contracte;

public:
    static Menu& getInstance(){
        static Menu menu;
        return menu;
    }


    void print() const;
    void run();
    void adaugaDrum();
    void adaugaContract();
    void afiseazaDrum() const;
    void afiseazaContract() const;

    void calcLungimeTotala();
    void calcLungimeAut();
    void stergeContracte();
    void calculeazaCostTotalptDrum();
};


void Menu :: print() const{
    cout << "1. adauga drum\n";
    cout << "2. adauga contract\n";
    cout << "3. afiseaza drumuri\n";
    cout << "4. afiseaza contracte\n";
    cout << "5. cerinta 2\n";
    cout << "6. cerinta 3\n";
    cout << "7. cerinta 4\n";
    cout << "spune: ";
}


void Menu :: adaugaDrum(){
    shared_ptr<Drum> ob = nullptr;

    cout << "denumire: ";
    string denumire;
    getline(cin >> ws, denumire);

    cout << "lungime: ";
    float lungime;
    cin >> lungime;

    cout << "nr trons: ";
    int nrtrons;
    cin >> nrtrons;

    string tip;
    cout << "tip: ";
    getline(cin >> ws, tip);

    if (tip == "1"){
        int nrjud;
        cout << "nr jud: ";
        cin >> nrjud;

        ob = make_shared<DrumNat>(denumire, lungime, nrtrons, nrjud);
    }
    else if(tip == "2"){
        int nrb;
        cout << "nr benzi: ";
        cin >> nrb;

        ob = make_shared<Autostrada>(denumire, lungime, nrtrons, nrb);
    }
    else if(tip == "3"){
        int nrb;
        cout << "nr tari: ";
        cin >> nrb;

        ob = make_shared<DrumEuropean>(denumire, lungime, nrtrons, nrb);
    }
    else if(tip == "4"){
        int nrb;
        cout << "nr benzi: ";
        cin >> nrb;

        int nrt;
        cout << "nr tari: ";
        cin >> nrt;

        ob = make_shared<AutoEuropean>(denumire, lungime, nrtrons, nrb, nrt);
    }

    drumuri.push_back(ob);
}


void Menu :: afiseazaDrum() const{
    for(auto elem : drumuri){
        cout << *elem;
        cout << '\n';
    }
}


void Menu :: adaugaContract(){
    shared_ptr<Contract> ob = nullptr;
    
    cout << "denumire: ";
    string denumire;
    getline(cin >> ws, denumire);

    cout << "cif : ";
    string cif;
    getline(cin >> ws, cif);

    int trons;
    cout << "tronson: ";
    cin >> trons;

    afiseazaDrum();

    string nume;
    cout << "Drum: ";
    getline(cin >> ws, nume);

    shared_ptr<Drum> d = nullptr;

    for(auto& elem : drumuri){
        if (nume == elem -> getDenumire()){
            if(trons <= elem -> getTrons()){
                cout << "gasit \n";
                d = elem;
            }
        }
    }

    if(d){
        cout << "adaugat \n";
        ob = make_shared<Contract>(denumire, cif, d, trons);
        contracte.push_back(ob);
    }
}


void Menu :: afiseazaContract() const{
    for(auto elem : contracte){
        cout << *elem;
        cout << "\n";
    }
}

void Menu :: calcLungimeAut(){
    float total = 0;

    for(auto elem : drumuri){
        shared_ptr<Autostrada> a = dynamic_pointer_cast<Autostrada>(elem);

        if(a){
            total += elem -> getLungime();
        }
    }

    cout << "lungime totala autostrazi: " << total << '\n';

}


void Menu :: calcLungimeTotala(){
    float lung = 0;

    for(auto elem : drumuri){
        lung += elem -> getLungime();
    }

    cout << "lungime totala: " << lung << '\n';;

    calcLungimeAut();
}


void Menu :: stergeContracte(){
    string cif;
    cout << "Introdu cif: ";
    getline(cin >> ws, cif);

    for (int i = 0;i < contracte.size(); i++){
        if (cif == contracte[i] -> getCif()){
            contracte.erase(contracte.begin() + i);
        }
    }
}


void Menu :: calculeazaCostTotalptDrum(){
    string den;
    cout << "introdu denumire: ";
    getline(cin >> ws, den);

    float total = 0;

    for(auto elem : contracte){
        if (den == elem -> getDrum() -> getDenumire()){
            total += elem -> getCost();
        }
    }

    cout << "Cost total: " << total << '\n';
}


void Menu :: run(){
    drumuri.push_back(make_shared<DrumNat>("dn1", 1000, 10, 5));
    drumuri.push_back(make_shared<DrumEuropean>("e4", 1500, 40, 10));
    drumuri.push_back(make_shared<AutoEuropean>("e70", 1999, 15, 4, 8));

    contracte.push_back(make_shared<Contract>("mm", "1000", drumuri[1], 5));
    while(true){
        int tip;
        print();

        cin >> tip;

        switch (tip)
        {
        case 1:
            adaugaDrum();
            break;

        case 2:
            adaugaContract();
            break;

        case 3:
            afiseazaDrum();
            break;

        case 4:
            afiseazaContract();
            break;
        
        case 5:
            calcLungimeTotala();
            break;

        case 6:
            stergeContracte();
            break;

        case 7:
            calculeazaCostTotalptDrum();
            break;
        
        default:
            return;
        }
    }
}

int main(){

    Menu& menu = Menu :: getInstance();

    menu.run();

    return 0;
}