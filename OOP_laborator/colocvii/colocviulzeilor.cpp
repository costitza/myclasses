// colocviu de anul trecut (2025)


#include <bits/stdc++.h>

using namespace std;

class Produs{
protected:
    string nume;
    int gramaj;

public:
    Produs(string n, int g) : nume(n), gramaj(g) {}
    virtual ~Produs() = default;

    // getters
    int getGramaj() const;

    virtual int calcValEnerg() const = 0;
};


int Produs :: getGramaj() const{
    return gramaj;
}

class Bautura : public Produs {
private:
    string esteSticla;

public:
    Bautura(string n, int g, string e) : Produs(n, g), esteSticla(e) {}


    int calcValEnerg() const override;
};

int Bautura :: calcValEnerg() const{
    if(esteSticla == "nu") return 25;
    return gramaj / 4;
}


class Desert : public Produs {
private:
    string format;

public:
    Desert(string n, int g, string f) : Produs(n, g), format(f) {}

    int calcValEnerg() const override;
};

int Desert :: calcValEnerg() const{
    if (format == "felie") return 25;
    else if(format == "portie") return gramaj / 2;
    else if(format == "cupa") return 2 * gramaj;
    return 0;
}


class Burger : public Produs{
private:
    string listaingred;
    int nrIngred;

public:
    Burger(string n, int g, string l) : Produs(n, g), listaingred(l) {
        string aux = "";

        for(int i = 0; i < l.size(); i++){
            if (l[i] != ' '){
                aux += l[i];
            }
            else{
                if(aux != ""){
                    nrIngred++;
                    
                }
                aux = "";
            }
        }
        nrIngred++;
    }

    int calcValEnerg() const override;
};

int Burger :: calcValEnerg() const{
    return gramaj / 4 * nrIngred;
}


class Comanda{
private:
    static int cont;
    int id;
    vector<shared_ptr<Produs>> produse;
    int val;

    int valEnerg() const;

public:
    Comanda(vector<shared_ptr<Produs>> p) {
        id = cont;
        cont ++;

        for(auto elem : p){
            produse.push_back(elem);
        }

        val = valEnerg();
    }

    void adaugaProdus(shared_ptr<Produs> p);

    int getID() const;

    int getVal(){
        return val;
    }
};

void Comanda :: adaugaProdus(shared_ptr<Produs> p){
    produse.push_back(p);

    val = valEnerg();
}

int Comanda :: getID() const{
    return id;
}

int Comanda :: cont = 100;

int Comanda :: valEnerg() const{
    int total = 0;
    for(auto elem : produse){
        total += elem -> calcValEnerg();
    }

    return total;
}


class Angajat{
protected:
    int pctEnerg;

public:
    Angajat() : pctEnerg(100) {}
    virtual ~Angajat() = default;

    virtual void setPct();

    void scadeNormal(int& energ, int tip);
    virtual void scadePerk(int& energ, int tip) = 0;
};

void Angajat :: setPct(){
    pctEnerg = 100;
}

void Angajat :: scadeNormal(int& energ, int tip){

    if(tip == 2){
        if (energ > pctEnerg){
            pctEnerg -= 100;
            energ -= 100;
        }
        else{
            pctEnerg -= energ;
            energ = 0;
        }
    }
    else{
        pctEnerg -= 100;
    }
}


class Casier : public Angajat{

public:
    void scadePerk(int& energ, int tip);
};

void Casier :: scadePerk(int& energ, int tip){
    if(tip == 1){
        pctEnerg -= 25;
    }
    else{
        scadeNormal(energ, tip);
    }
}


class Livrator : public Angajat{

public:
    void scadePerk(int& energ, int tip);
};

void Livrator :: scadePerk(int& energ, int tip){
    if(tip == 3){
        pctEnerg -= 25;
    }
    else{
        scadeNormal(energ, tip);
    }
}


class Bucatar : public Angajat{

public:
    void scadePerk(int& energ, int tip);

    void setPct() override;
};

void Bucatar :: setPct(){
    pctEnerg += 100;
}

void Bucatar :: scadePerk(int& energ, int tip){
    if(tip == 2){
        if(energ > 2 * pctEnerg){
            energ -= 2 * pctEnerg;
            pctEnerg = 0;
        }
        else{
            pctEnerg -= energ / 2;
            energ = 0;
        }
    }
    else{
        scadeNormal(energ, tip);
    }
}


class Menu{
    Menu() = default;
    Menu(const Menu& m) = delete;
    Menu& operator=(const Menu& m) = delete;

    vector<shared_ptr<Angajat>> angajati;
    vector<shared_ptr<Comanda>> comenzi;

public:
    static Menu& getInstance(){
        static Menu m;
        return m;
    }


    void print() const;
    void afisareNrAng();

    vector<shared_ptr<Produs>> adaugaProduse();
    void adaugaComanda();
    void simulare();
};


void Menu :: print() const{
    cout << "Magazin nebun\n";
    cout << "1. Afișarea numărului de angajați pentru fiecare tip în parte\n";
    cout << "2. Implementarea simulării și afișarea unui ciclu\n";
    cout << "Choose your option: ";
}

void Menu :: afisareNrAng(){
    int c = 0;
    int l = 0;
    int b = 0;

    for(auto elem : angajati){
        shared_ptr<Casier> ob1 = dynamic_pointer_cast<Casier>(elem);

        if(ob1){
            c++;
        }

        shared_ptr<Livrator> ob1 = dynamic_pointer_cast<Livrator>(elem);

        if(ob1){
            l++;
        }

        shared_ptr<Bucatar> ob1 = dynamic_pointer_cast<Bucatar>(elem);

        if(ob1){
            b++;
        }

    }


    cout << "   -> casier, livrator, bucatar: " << c << ' ' << l << ' ' << b << '\n';  
}


vector<shared_ptr<Produs>> Menu :: adaugaProduse(){
    vector<shared_ptr<Produs>> produse;

    while(true){
        cout << "Ce vrei sa adaugi la comanda: \n";
        cout << "1. Bautura\n";
        cout << "2. Desert\n";
        cout << "3. Burger\n";

        int tip;
        cin >> tip;

        shared_ptr<Produs> ob = nullptr;

        if (tip == 1){
            string nume;
            cout << "Nume: ";
            getline(cin >> ws, nume);

            int gram;
            cout << "Gramaj: ";
            cin >> gram;

            string sticla;
            cout << "Este la sticla: ";
            getline(cin >> ws, sticla);

            ob = make_shared<Bautura>(nume, gram, sticla);
        }
        else if(tip == 2){
            string nume;
            cout << "Nume: ";
            getline(cin >> ws, nume);

            int gram;
            cout << "Gramaj: ";
            cin >> gram;

            string format;
            cout << "In ce format (felie, portie, cupa): ";
            getline(cin >> ws, format);

            ob = make_shared<Desert>(nume, gram, format);
        }
        else if(tip == 3){
            string nume;
            cout << "Nume: ";
            getline(cin >> ws, nume);

            int gram;
            cout << "Gramaj: ";
            cin >> gram;

            string format;
            cout << "Ce lista de ingrediente are: ";
            getline(cin >> ws, format);

            ob = make_shared<Burger>(nume, gram, format);
        }
        else{
            return;
        }

        produse.push_back(ob);
    }

    return produse;
}


void Menu :: adaugaComanda(){

    vector<shared_ptr<Produs>> produse = adaugaProduse();

    shared_ptr<Comanda> com = make_shared<Comanda>(produse);

    comenzi.push_back(com);
}


void Menu :: simulare(){

    int comenziNoi = 0;

    while(true){
        cout << "Adauga comanda (1/0): ";
        int tip;
        cin >> tip;
        
        if(tip == 1){
            adaugaComanda();
            comenziNoi ++;
        }
        else{
            break;
        }
    }


    for (int i = 0;i < angajati.size(); i++){
    }
}
