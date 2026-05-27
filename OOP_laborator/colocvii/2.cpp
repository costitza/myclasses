// 4 iunie 2024


#include <bits/stdc++.h>

using namespace std;


class Element{
protected:
    static int cont;
    const int id;

public:
    Element() : id(cont ++){
    }
    virtual ~Element() = default;

    int getID() const;

    virtual int costUpgrade() const = 0;
    virtual void upgrade() = 0;

    virtual void afis(ostream& os) const = 0;
    friend ostream& operator<<(ostream& os, const Element& ob);
};

int Element :: cont = 100;

int Element :: getID() const {
    return id;
}


ostream& operator<<(ostream& os, const Element& ob){
    os << "ID: " << ob.id;

    ob.afis(os);
    return os;
}



class Zid : public Element{
private:
    float gros;
    int inalt, lung;

public:
    Zid(int i, int l, float g) : Element(), inalt(i), lung(l), gros(g){}

    int costUpgrade() const;
    void upgrade();

    void afis(ostream& os) const;
};


int Zid :: costUpgrade() const{
    return int(100 * lung * inalt * gros);
}

void Zid :: upgrade(){
    lung += 1;
    inalt += 1;
    gros += 1;
}

void Zid :: afis(ostream& os) const{
    os << ", Zid, inaltime: " << inalt << ", lungime: " << lung << ", grosime: " << gros;

}


class Turn : public Element{
private:
    int putere;

public:
    Turn(int p) : Element(), putere(p) {}

    int costUpgrade() const;
    void upgrade();

    void afis(ostream& os) const;
};


int Turn :: costUpgrade() const{
    return 500 * putere;
}

void Turn :: upgrade(){
    putere += 500;
}

void Turn :: afis(ostream& os) const{
    os << ", Turn, putere laser: " << putere;

}


class Robot : public Element{
protected:
    int damage;
    int nivel;
    int viata;

public: 
    Robot(int d, int n, int v) : Element(), damage(d), nivel(n), viata(v) {}

    void afis(ostream& os) const;
};


void Robot :: afis(ostream& os) const{
    os << ", Robot, damage: " << damage << ", nivel: " << nivel << ", viata: " << viata; 
}


class RobotAerian : public Robot{
private:
    int autonomie;

public:
    RobotAerian(int d, int n, int v, int a): Robot(d, n, v), autonomie(a) {}
    
    int costUpgrade() const;
    void upgrade();

    void afis(ostream& os) const override;
};

int RobotAerian :: costUpgrade() const{
    return 50 * autonomie;
}

void RobotAerian :: upgrade(){
    autonomie ++;
    nivel ++;
    damage += 25;
}

void RobotAerian :: afis(ostream& os) const{
    Robot :: afis(os);
    os << ", autonomie: " << autonomie;
}


class RobotTerestru : public Robot{
private:
    int gloante;
    string scut;
public:
    RobotTerestru(int d, int n, int v, int g, string s): Robot(d, n, v), gloante(g), scut(s) {}

    int costUpgrade() const;
    void upgrade();

    void afis(ostream& os) const override;
};

int RobotTerestru :: costUpgrade() const{
    return 10 * gloante;
}

void RobotTerestru :: upgrade(){
    gloante += 100;
    nivel ++;
    damage += 50;

    if(nivel >= 5){
        if(scut == "nu"){
            scut = "da";
            viata += 50;
        }
    }
}

void RobotTerestru :: afis(ostream& os) const{
    Robot :: afis(os);
    os << ", gloante: " << gloante << ", scut: " << scut;
}


class Menu{
private:
    Menu() = default;
    Menu(const Menu& m) = delete;
    Menu& operator=(const Menu& m) = delete;

    vector<shared_ptr<Element>> elemente;
    int puncte = 50000;

public:
    static Menu& getInstance(){
        static Menu menu;
        return menu;
    }

    void print();
    void run();
    void adaugaElement();
    void upgradeElement();
    void afisareDupaCost();
    void afisareRoboti();
    void sell();
    void afisareElemente();
};


void Menu :: print(){
    cout << "Joc Octipus\n";
    cout << "1. Adauga element\n";
    cout << "2. Upgrade element\n";
    cout << "3. Afisare elemente dupa cost\n";
    cout << "4. Afisare toti robotii\n";
    cout << "5. Sell element\n";
}


void Menu :: afisareElemente(){
    for(auto elem : elemente){
        cout << *elem;
        cout << '\n';
    } 
}


void Menu :: adaugaElement(){
    cout << "Punctele tale: " << puncte << '\n';

    cout << "Zid, turn, robot aerian sau robot terestru (1, 2, 3, 4): ";
    int tip;
    cin >> tip;

    shared_ptr<Element> ob = nullptr;

    if(tip == 1){
        puncte -= 300;
        ob = make_shared<Zid>(2, 1, 0.5);
    }
    else if(tip == 2){
        puncte -= 500;
        ob = make_shared<Turn>(1000);
    }
    else if(tip == 3){
        puncte -= 100;
        ob = make_shared<RobotAerian>(100, 1, 100, 10);
    }
    else if(tip == 4){
        puncte -= 50;
        ob = make_shared<RobotTerestru>(100, 1, 100, 500, "nu");
    }

    elemente.push_back(ob);
}


void Menu :: upgradeElement(){
    afisareElemente();

    cout << "Introdu id la care vrei sa modifici: ";
    int input;
    cin >> input;

    for(auto& elem : elemente){
        if(elem -> getID() == input){
            if(elem -> costUpgrade() <= puncte){
                puncte -= elem -> costUpgrade();

                elem -> upgrade();
            }
        }
    }
}


void Menu :: afisareDupaCost(){
    vector<shared_ptr<Element>> sortare;
    for(auto& elem : elemente){
        sortare.push_back(elem);
    }

    sort(sortare.begin(), sortare.end(), [](const shared_ptr<Element>& a, const shared_ptr<Element>& b){
        return a -> costUpgrade() > b -> costUpgrade();
    });

    for (auto elem : sortare){
        cout << *elem;
        cout << '\n';
    }
}


void Menu :: afisareRoboti(){
    for(auto elem : elemente){
        shared_ptr<Robot> robo = dynamic_pointer_cast<Robot>(elem);

        if (robo){
            cout << *robo;
            cout << '\n';
        }
    }
}


void Menu :: sell(){
    afisareElemente();

    cout << "Introdu id pe cine vrei sa vinzi: ";
    int input;
    cin >> input;

    for(int i = 0;i < elemente.size(); i++){
        if(elemente[i] -> getID() == input){
            elemente.erase(elemente.begin() + i);
            puncte += 500;
            return;
        }
    }
}


void Menu :: run(){
    while(true){
        print();

        int tip;
        cin >> tip;
        switch (tip)
        {
        case 1:
            adaugaElement();
            break;

        case 2:
            upgradeElement();
            break;

        case 3:
            afisareDupaCost();
            break;

        case 4:
            afisareRoboti();
            break;

        case 5:
            sell();
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

