#include <bits/stdc++.h>

using namespace std;


class Produs {
protected:
    static int cont;
    int id;
    string nume;
    double pret;

public:
    Produs(string n, double p) : nume(n), pret(p), id(cont ++) {}
    virtual ~Produs() = default;

    virtual void afis(ostream& os) const = 0;
    friend ostream& operator<<(ostream& os, const Produs& ob);

    int getId() const;
    double getPret() const;
    void setPret(double newPret);


    virtual double getCostFinal() const = 0;

};


int Produs :: getId() const {
    return id;
}

double Produs :: getPret() const {
    return pret;
}


ostream& operator<< (ostream& os, const Produs& ob){
    ob.afis(os);
    os << "id: " << ob.id << ", nume: " << ob.nume << ", pret: " << ob.pret << '\n';
    return os;
}

void Produs :: setPret(double newPret){
    this -> pret = newPret;
}

int Produs :: cont = 1000;


// elec mare
class ElectroMare : public Produs {
    double greutate;

public:
    ElectroMare(double g, string n, double p) : Produs(n, p), greutate(g) {}

    void afis(ostream& os) const override;

    double getCostFinal() const override;
};

void ElectroMare :: afis(ostream& os) const {
    os << "[Electronica mare]: greutate:" << this -> greutate << ", ";
}

double ElectroMare :: getCostFinal() const {
    if (greutate > 50){
        return 100 + pret;
    }
    return 50 + pret;
}



// elec mic
class ElecMic : public Produs{
    int lungCablu;
    bool esteWireless;

public:
    ElecMic(int l, bool e, string n, double p) : Produs(n, p), lungCablu(l), esteWireless(e) {}

    double getCostFinal() const override;

    void afis(ostream& os) const override;
};

void ElecMic :: afis(ostream& os) const{
    string b = "nu";
    if (esteWireless == true){
        b = "da";
    }
    os << "[Electrocasnic Mic]: lungime cablu: " << this -> lungCablu << ", este wireless: " << b << ", ";
}

double ElecMic :: getCostFinal() const {
    if (esteWireless == true){
        return pret * 15 / 100 + pret;
    }
    return pret;
}



// gadget
class Gadget : public Produs{
private:
    double capacitateBaterie;
    bool areBT;
public:
    Gadget(double c, bool a, string n, double p) : Produs(n, p), capacitateBaterie(c), areBT(a)  {}

    double getCostFinal() const override;

    void afis(ostream& os) const override;
};


void Gadget :: afis(ostream& os) const{
    string b = "nu";
    if (areBT == true){
        b = "da";
    }
    os << "[Gadget]: capacitate baterie: " << this -> capacitateBaterie << ", are bluetooth: " << b << ", ";
}

double Gadget :: getCostFinal() const {
    double pretF = pret;
    if (areBT == true){
        pretF += 35;
    }

    return pretF + pretF * 0.25 / 100;
}


class Menu {
    Menu() = default;
    Menu(const Menu& menu) = delete;
    Menu& operator=(const Menu& m) = delete;

    vector<shared_ptr<Produs>> produse;

public:
    static Menu& getInstance(){
        static Menu menu;
        return menu;
    }

    void print() const;

    void run();

    void creazaProdus();

    void afisStoc();

    vector<shared_ptr<Produs>> cautBuget(double suma);

    void devalorizare(int deval, string tip);
};

void Menu :: creazaProdus(){

    int tip;
    cout << "De care (tip 1/2/3): ";
    cin >> tip;

    shared_ptr<Produs> ob = nullptr;

    if (tip == 1){
        string nume;
        cout << "Da mi nume: ";
        cin >> nume;

        double pret;
        cout << "Da mi pret: ";
        cin >> pret;

        double greutate;
        cout << "Spune mi greutatea lui: ";
        cin >> greutate;

        ob = make_shared<ElectroMare>(greutate, nume, pret);
    }
    else if(tip == 2){
        string nume;
        cout << "Da mi nume: ";
        cin >> nume;

        double pret;
        cout << "Da mi pret: ";
        cin >> pret;

        double cablu;
        cout << "Spune mi lungimea cablului: ";
        cin >> cablu;

        string este;
        cout << "Spune mi daca este wireless: ";
        cin >> este;

        bool wr;
        if (este == "da"){
            wr = true;
        }
        else{
            wr = false;
        }

        ob = make_shared<ElecMic>(cablu, wr, nume, pret);
    }
    else if(tip == 3){
                string nume;
        cout << "Da mi nume: ";
        cin >> nume;

        double pret;
        cout << "Da mi pret: ";
        cin >> pret;

        double capacitate;
        cout << "Spune mi capacitatea bateriei: ";
        cin >> capacitate;

        string este;
        cout << "Spune mi daca este wireless: ";
        cin >> este;

        bool bt;
        if (este == "da"){
            bt = true;
        }
        else{
            bt = false;
        }

        ob = make_shared<Gadget>(capacitate, bt, nume, pret);
    }
    produse.push_back(ob);
}


void Menu :: afisStoc(){
    for(auto elem : produse){
        cout << *elem;
        cout << "   -> cost final: " << elem -> getCostFinal();
        cout << '\n';
    }
}

vector<shared_ptr<Produs>> Menu :: cautBuget(double suma){

    vector<shared_ptr<Produs>> tosend;

    for (auto elem : produse){
        if (suma >= elem -> getCostFinal()){
            tosend.push_back(elem);
        }
    }

    return tosend;
}


void Menu :: devalorizare(int deval, string tip){

    string newt = "";
    for (auto ch : tip){
        newt += tolower(ch);
    }

    for (auto &elem : produse){
        if (newt == "electrocasnice mari"){
            shared_ptr<ElectroMare> derived = dynamic_pointer_cast<ElectroMare>(elem);
            if (derived){
                derived -> setPret(derived -> getPret() - derived -> getPret() * deval / 100);
            }
        }
        else if(newt == "electrocasnice mici"){
            shared_ptr<ElecMic> derived = dynamic_pointer_cast<ElecMic>(elem);
            if (derived){
                derived -> setPret(derived -> getPret() - derived -> getPret() * deval / 100);
            }
        }
        else if(newt == "gadgeturi"){
            shared_ptr<Gadget> derived = dynamic_pointer_cast<Gadget>(elem);
            if (derived){
                derived -> setPret(derived -> getPret() - derived -> getPret() * deval / 100);
            }
        }
    }
}


void Menu :: print() const{
    string content = "1. Adauga produs\n2. Afiseaza stocul\n3. Cauta dupa un buget\n4. Devalorizare\n0. Iesi\nAlege ce doresti sa faci: ";

    cout << content;
}


void Menu :: run(){
    while(true){
        print();
        int task;
        cin >> task;

        switch (task)
        {
        case 1:
            creazaProdus();
            break;
        case 2:
            afisStoc();
            break;
        case 3: {
            cout << "Ce buget ai: ";
            double buget;
            cin >> buget;

            vector<shared_ptr<Produs>> primit = cautBuget(buget);

            for (auto elem : primit){
                cout << *elem;
            }
            cout << '\n';

            break;
        }
        case 4:{
            int red;
            cout << "Ce reducere se aplica: ";
            cin >> red;
            string tip;
            cout << "Pentru ce tip: ";
            getline(cin >> ws, tip);
            devalorizare(red, tip);
            break;
        }
        case 0:
            cout << "PA PA";
            return;
        default:
            cout << "trebuie sa scrii ceva";
            break;
        }
    }
}



int main(){
    Menu& app = Menu :: getInstance();

    app.run();

    return 0;
}