#include <bits/stdc++.h>

class ExceptieCampus : public std :: runtime_error{
public:
    ExceptieCampus(const char* mesaj = "eroare pentru campus") 
        : std::runtime_error(mesaj) {}
};

class ExceptieValidareMedie : public std :: logic_error{
public:
    ExceptieValidareMedie(float nota) : std :: logic_error("nota nu este in intervalul dorit") {}
};


class ExceptieBugetSalarii : public std :: runtime_error{
public:
    ExceptieBugetSalarii(double salariu) : std :: runtime_error("salariul nu este in intervalul dorit") {}
};


class MembruCampus{
    static int id;
    std::string nume;
    int idObiect;
public:
    MembruCampus() {
        idObiect = id ++;
    }
    MembruCampus(std :: string n) : nume(n){
        idObiect = id ++;
    }

    int getId(){
        return idObiect;
    }

    virtual void afisare(){
        std::cout << "id: " << idObiect << ", nume: " << nume;
    }

    friend std::ostream& operator<<(std::ostream& os, MembruCampus member) {
        member.afisare();
        return os;
    }   
};

int MembruCampus ::  id = 0;


class Student : virtual public MembruCampus{
    float medie;
public:
    Student() : MembruCampus() {}
    Student(float m, std :: string n) : MembruCampus(n), medie(m){}
};


class Angajat : virtual public MembruCampus{
    double salariu;
public:
    static double salariuTotal;

    Angajat() : MembruCampus() {}
    Angajat(double s, std :: string n) : MembruCampus(n), salariu(s) {
        salariuTotal += s;
    }
    ~Angajat(){
        salariuTotal -= salariu;
    }

    double getSalariu() const {
        return salariu;
    }

    void setSalariu(double sal){
        if(sal < 0 || sal > 10000){
            throw ExceptieBugetSalarii(sal);
        }
        salariuTotal -= salariu;
        salariu = sal;
        salariuTotal += sal;
    }

};

double Angajat :: salariuTotal = 0.0;

class AsistentDoctorand : public Angajat, public Student{
public:
    AsistentDoctorand() : MembruCampus(), Angajat(), Student() {}
    AsistentDoctorand(double s, float m, std :: string n) : MembruCampus(n), Angajat(s, n), Student(m, n) {}

};


class ApplicationMenu {
private:
    std::vector<MembruCampus*> membri;

    ApplicationMenu() {} 
    static ApplicationMenu* instance;

public:
    static ApplicationMenu* getInstance() {
        if (instance == nullptr){
            instance = new ApplicationMenu();
        }
        return instance;
    }

    void adaugaMembru(MembruCampus* membru) {
        membri.push_back(membru);
    }

    void afiseazaTotiMembrii() {
        for (const auto& membru : membri) {
            std::cout << *membru << "\n";
        }
        std::cout << "Buget total salarii curent: " << Angajat::salariuTotal << "\n";
    }

    void modificaSalariuDupaID(int idCautat, double noulSalariu) {
        bool gasit = false;
        for (auto& membru : membri) {
            
            if (membru->getId() == idCautat) {
                gasit = true;
                
                Angajat* angajat = dynamic_cast<Angajat*>(membru);

                if (angajat != nullptr) {
                    angajat->setSalariu(noulSalariu);
                    std::cout << "Salariu actualizat cu succes!\n";
                } else {
                    std::cout << "Eroare: Membrul cu acest ID nu este un angajat!\n";
                }
                break;
            }
        }
        if (!gasit) {
            std::cout << "Membrul cu ID-ul " << idCautat << " nu a fost gasit.\n";
        }
    }
};


ApplicationMenu* ApplicationMenu:: instance = nullptr;


void ruleazaMeniu() {
    ApplicationMenu* meniu = ApplicationMenu::getInstance();

    try {
        
        double salariuCitit;
        std::cout << "Introdu salariul: ";
        std::cin >> salariuCitit;
        

        meniu -> modificaSalariuDupaID(1, salariuCitit); 

    } catch (const ExceptieBugetSalarii& e) {
        std::cerr << "Exceptie prinsa: " << e.what() << "\n";
    } catch (const ExceptieValidareMedie& e) {
        std::cerr << "Exceptie prinsa: " << e.what() << "\n";
    } catch (const ExceptieCampus& e) {
        std::cerr << "O eroare generala a aparut: " << e.what() << "\n";
    }
}


int main() {
    ApplicationMenu* meniu = ApplicationMenu::getInstance();

    Student* s1 = new Student(9.5, "Ana Popescu");
    Angajat* a1 = new Angajat(3500.0, "Ion Vasilescu");
    AsistentDoctorand* ad1 = new AsistentDoctorand(4500.0, 9.8, "Maria Ionescu");

    meniu -> adaugaMembru(s1);
    meniu -> adaugaMembru(a1);
    meniu -> adaugaMembru(ad1);

    meniu -> afiseazaTotiMembrii();

    ruleazaMeniu(); 
    meniu -> afiseazaTotiMembrii(); 

    ruleazaMeniu();

    ruleazaMeniu();

    delete s1;
    delete a1;
    delete ad1;

    return 0;
}