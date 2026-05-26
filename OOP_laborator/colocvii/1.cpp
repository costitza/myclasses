#include <bits/stdc++.h>

using namespace std;

class Masina{
protected:
    int an;
    string nume;
    float vitezamax;
    float greutate;

public:
    Masina(int a, string n, float v, float g) : an(a), nume(n), vitezamax(v), greutate(g) {}
    virtual ~Masina() = default;


    virtual float calculAutonomie() const = 0;

    virtual void print(ostream& os) const;

    friend ostream& operator<<(ostream& os, const Masina& m);

    // getters
    float getViteza() const;
    float getGreutate() const;
    string getNume() const;

    // setters
    void setViteza(float adaug);
};


void Masina :: print(ostream& os) const{
    os << "nume: " << nume << ", an: " << an << ", viteza maxima: " << vitezamax << ", greutate: " << greutate; 
}

ostream& operator<<(ostream& os, const Masina& m){
    m.print(os);
    return os;
}

float Masina :: getViteza() const{
    return this -> vitezamax;
}

float Masina :: getGreutate() const{
    return this -> greutate;
}

string Masina :: getNume() const {
    return this -> nume;
}

void Masina :: setViteza(float adaug){
    vitezamax += adaug;
}


class MasinaCombust : virtual public Masina{
protected:
    string tipCombust;
    float capacitateRez;

public:
    MasinaCombust(int a, string n, float v, float g, string t, float c) : Masina(a, n, v, g), tipCombust(t), capacitateRez(c) {}
    

    float calculAutonomie() const;

    void print(ostream& os) const override;
};

float MasinaCombust :: calculAutonomie() const{
    return capacitateRez / sqrt(greutate);
}

void MasinaCombust :: print(ostream& os) const{
    Masina :: print(os);
    os << ", tip combustibil" << tipCombust << ", capacitate rezervor: " << capacitateRez;
}


class MasinaElectric : virtual public Masina{
protected:
    float capacitateBat;

public:
    MasinaElectric(int a, string n, float v, float g, float c) : Masina(a, n, v, g), capacitateBat(c) {}

    float calculAutonomie() const;

    void print(ostream& os) const override;
};

float MasinaElectric :: calculAutonomie() const{
    return capacitateBat / (greutate * greutate);
}

void MasinaElectric :: print(ostream& os) const{
    Masina :: print(os);
    os << ", capacitate baterie: " << capacitateBat;
}


class MasinaHibrid : public MasinaCombust, public MasinaElectric{

public:
    MasinaHibrid(int a, string n, float v, float g, float c1, string t, float c2) :
        Masina(a, n, v, g),
        MasinaCombust(a, n, v, g, t, c2), MasinaElectric(a, n, v, g, c1) {}

    float calculAutonomie() const;
    void print(ostream& os) const override;
};

void MasinaHibrid :: print(ostream& os) const{
    MasinaCombust :: print(os);
    os << ", capacitate baterie" << capacitateBat;
}

float MasinaHibrid :: calculAutonomie() const{
    return MasinaCombust :: calculAutonomie() + MasinaElectric :: calculAutonomie();
}


class Tranzactie{
private:
    string client;
    vector<shared_ptr<Masina>> modele;
    struct d{
        int zi, luna, an;
        d(int z, int l, int a) : zi(z), luna(l), an(a) {}
    }data;

public:
    Tranzactie(string c, vector<shared_ptr<Masina>> m, int z, int l, int a) : client(c), data(z, l, a){
        for(auto mod : m){
            modele.push_back(mod);
        }
    }
};



class Menu{
    Menu() = default;
    Menu(const Menu& m) = delete;
    Menu& operator=(const Menu& m) = delete;

    vector<shared_ptr<Masina>> masini;
    vector<shared_ptr<Tranzactie>> tranzactii;
    map<shared_ptr<Masina>, int> vedeta;
public:
    static Menu& getInstance(){
        static Menu menu;
        return menu;
    }

    void print() const;
    void run();
    void adaugaModel();
    void afiseazaModele() const;
    shared_ptr<Masina> getModelbyIndex(int index) const;
    void adaugaTranzactie();
    void afiseazaCelMaiVandut();
    void afiseazaAutonomie();
    void optimizareModel();
};

void Menu :: print() const{
    cout << "Meniu Masini \n";
    cout << "1. adauga model de masina\n";
    cout << "2. adauga tranzactie\n";
    cout << "3. afiseaza cel mai vandut model\n";
    cout << "4. afiseaza modelul cu autonomia cea mai mare\n";
    cout << "5. fa optimizare (creste viteza maxima) unui model de masina\n";
    cout << "Alege o optiune: ";
}


void Menu :: afiseazaModele() const{
    for (auto mod : masini){
        cout << *mod;
        cout << "\n";
    }
}

shared_ptr<Masina> Menu :: getModelbyIndex(int index) const{
    if (index < 0 || index > masini.size()) return nullptr;

    return masini[index];
}


void Menu :: adaugaModel(){
    shared_ptr<Masina> mod = nullptr;

    string nume;
    cout << "Introdu numele: ";
    getline(cin >> ws, nume);

    int an;
    cout << "Introdu an: ";
    cin >> an;

    float vit;
    cout << "Introdu viteza maxima: ";
    cin >> vit;

    float greu;
    cout << "Introdu greutatea: ";
    cin >> greu;

    string tip;
    cout << "De ce tip este modelul (c, e, h): ";
    getline(cin >> ws, tip);

    if(tip == "c"){
        string combust;
        cout << "Introdu tipul de combustibil (Benzina, Motorina): ";
        getline(cin >> ws, combust);

        float capacitate;
        cout << "Introdu capacitatea rezervorului: ";
        cin >> capacitate;

        mod = make_shared<MasinaCombust>(an, nume, vit, greu, combust, capacitate);
    }
    else if(tip == "e"){
        float capac;
        cout << "Introdu capacitatea bateriei: ";
        cin >> capac;

        mod = make_shared<MasinaElectric>(an, nume, vit, greu, capac);
    }
    else if(tip == "h"){
        string combust;
        cout << "Introdu tipul de combustibil (Benzina, Motorina): ";
        getline(cin >> ws, combust);

        float capacitaterez;
        cout << "Introdu capacitatea rezervorului: ";
        cin >> capacitaterez;

        float capac;
        cout << "Introdu capacitatea bateriei: ";
        cin >> capac;

        mod = make_shared<MasinaHibrid>(an, nume, vit, greu, capac, combust, capac);
    }

    masini.push_back(mod);

    cout << "Masina adaugata cu succes\n";
}

void Menu :: adaugaTranzactie(){
    string client;
    cout << "Introdu clientul ce face tranzactia: ";
    getline(cin >> ws, client);

    int zi;
    cout << "Introdu ziua tranzactiei: ";
    cin >> zi;

    int luna;
    cout << "Introdu luna tranzactiei: ";
    cin >> luna;

    int an;
    cout << "Introdu anul tranzactiei: ";
    cin >> an;

    vector<shared_ptr<Masina>> modele;
    int index = 0;
    while(index != -1){
        Menu :: afiseazaModele();

        cout << "Introdu index pentru masina sau -1 ca sa iesi: ";
        cin >> index;

        shared_ptr<Masina> model = getModelbyIndex(index);

        if(vedeta.find(model) != vedeta.end()){
            vedeta[model]++;
        }
        else{
            vedeta[model] = 1;
        }

        if (model != nullptr){
            modele.push_back(Menu :: getModelbyIndex(index));
        }
        else{
            cout << "Problema la index\n";
        }
    }

    shared_ptr<Tranzactie> tranz = make_shared<Tranzactie>(client, modele, zi, luna, an);

    tranzactii.push_back(tranz);
}


void Menu :: afiseazaAutonomie(){
    if (!masini.size()){
        cout << "Nu exista masini\n";
        return;
    }
    shared_ptr<Masina> ob = masini[0];

    for(int i = 1; i < masini.size(); i++){
        if (masini[i] -> calculAutonomie() > ob -> calculAutonomie()){
            ob = masini[i];
        }
    }

    cout << *ob << '\n';
    cout << "   -> cu autonomia:" << ob -> calculAutonomie() << '\n';
}


void Menu :: afiseazaCelMaiVandut(){
    if (vedeta.size() == 0){
        cout << "Nu exista nicio masina in nicio tranzactie\n";
    }
    else{
        shared_ptr<Masina> biggest = nullptr;
        int nr = 0;
        
        auto max_it = max_element(vedeta.begin(), vedeta.end(), [](const auto& a, const auto& b){
            return a.second < b.second;
        });

        cout << *(max_it -> first) << '\n';
        cout << "   -> cu atatea aparitii: " << max_it -> second << '\n';
    }
    
}


void Menu :: optimizareModel(){
    afiseazaModele();

    int index;
    cout << "Introdu indexul modelului pentru optimizare: ";
    cin >> index;

    float adaug;
    cout << "Introdu numarul de optimizare a vitezei: ";
    cin >> adaug;

    shared_ptr<Masina> model = getModelbyIndex(index);

    if (model != nullptr){
        model -> setViteza(adaug);
    }
    else{
        cout << "Problema la index\n";
    }
}


void Menu :: run(){
    while(true){
        print();

        int task;
        cin >> task;

        switch(task){
            case 1:
                adaugaModel();
                break;
            case 2:
                adaugaTranzactie();
                break;
            case 3:
                afiseazaCelMaiVandut();
                break;
            case 4:
                afiseazaAutonomie();
                break;
            case 5:
                optimizareModel();
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
