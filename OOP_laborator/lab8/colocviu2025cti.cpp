#include <bits/stdc++.h>

using namespace std;

class Artefact{
protected:
    int id;
    string nume;
    string epoca;
    int pret_initial;
    int pret_achizitie;

public:
    Artefact(int i, string n, string e, int p) : id(i), nume(n), epoca(e), pret_initial(p), pret_achizitie(0){
    }
    virtual ~Artefact() = default;

    int getId() const { return id; }
    double getPretInitial() const { return pret_initial; }
    void setPretAchizitie(double pret) { pret_achizitie = pret; }
    double getPretAchizitie() const { return pret_achizitie; }

    virtual string getTip() const = 0;
    virtual bool esteDeColectie() const = 0;

    virtual void afisare() const {
        cout << "ID: " << id << " | Nume: " << nume << " | Epoca: " << epoca 
             << " | Pret: " << pret_initial << " ";
    }
};


class ArtefactIstoric : public Artefact{
    vector<string> persoane_renumite;
public:
    ArtefactIstoric(int i, string n, string e, double p, vector<string> pers)
        : Artefact(i, n, e, p), persoane_renumite(pers) {}
    

    string getTip() const override { return "istoric"; }
    
    bool esteDeColectie() const override {
        return persoane_renumite.size() > 3;
    }
    
    void afisare() const override {
        Artefact::afisare();
        cout << "[Istoric] Persoane: " << persoane_renumite.size() << "\n";
    }
};



class ArtefactArtistic : public Artefact{
    string tip_artistic;
    string material;
public:
    ArtefactArtistic(int i, string n, string e, double p, string t, string m)
        : Artefact(i, n, e, p), tip_artistic(t) , material(m){}

    string getTip() const override {
        return "artistic";
    }

    bool esteDeColectie() const override{
        return (material == "ulei" || material == "marmura");
    }

    void afisare() const override {
        Artefact::afisare();
        cout << "[Artistic - " << tip_artistic << "] Material: " << material << "\n";
    }
};


class ArtefactPretios : public Artefact{
    string designer;
    int greutate;

public:
    ArtefactPretios(int i, string n, string e, double p, string d, double g)
        : Artefact(i, n, e, p), designer(d), greutate(g) {}

    string getTip() const override { return "pretios"; }

    bool esteDeColectie() const override {
        return greutate > 250 && designer != "Necunoscut";
    }

    void afisare() const override {
        Artefact::afisare();
        cout << "[Pretios] Greutate: " << greutate << "g | Designer: " << designer << "\n";
    }
};


class Participant{
protected:
    static int contor_nr;
    int nr_unic;
    double buget;
    double pas_licitare;
    double valoare_confort;
    string tip_preferat;
    string tip_ignorat;
    vector<shared_ptr<Artefact>> istoric_cumparate;

public:
    Participant(double b, double p, double vc, string pref, string ign)
        : nr_unic(++contor_nr), buget(b), pas_licitare(p), valoare_confort(vc), 
          tip_preferat(pref), tip_ignorat(ign) {}

    virtual ~Participant() = default;

    int getNr() { return nr_unic; }
    int getNrCumparate() {
        return istoric_cumparate.size();
    }

    const vector<shared_ptr<Artefact>> getIstoric() {
        return istoric_cumparate;
    }

    void achizitioneaza(shared_ptr<Artefact> art, double pret_final){
        buget -= pret_final;
        art -> setPretAchizitie(pret_final);
        istoric_cumparate.push_back(art);
    }

    virtual bool oferaPret(shared_ptr<Artefact> art, double pret_curent) = 0;

    virtual void afisare() const {
        cout << "Part. #" << nr_unic << " | Buget: " << buget 
             << " | Cumparate: " << istoric_cumparate.size() << "\n";
    }
};

int Participant :: contor_nr = 100;

class PersoanaFizica : public Participant{
    string nume;

public:
    PersoanaFizica(double b, double p, double vc, string pref, string ign, string n)
        : Participant(b, p, vc, pref, ign), nume(n) {}

    bool oferaPret(shared_ptr<Artefact> art, double pret_curent) override {
        if (art->getTip() == tip_ignorat) return false;
        
        double limita = valoare_confort;
        if (art->getTip() == tip_preferat) limita = buget;
        
        return (pret_curent + pas_licitare <= limita) && (pret_curent + pas_licitare <= buget);
    }


    void afisare() const override {
        cout << "[Pers. Fizica] Nume: " << nume << " | ";
        Participant::afisare();
    }
};


class PersoanaJuridica : public Participant{
    string nume_organizatie;
    vector<shared_ptr<PersoanaFizica>> reprezentanti;

public:
    PersoanaJuridica(double b, double p, double vc, string pref, string ign, string nume_org)
        : Participant(b, p, vc, pref, ign), nume_organizatie(nume_org) {}

    void adaugaReprezentant(shared_ptr<PersoanaFizica> rep) {
        reprezentanti.push_back(rep);
    }


    bool oferaPret(shared_ptr<Artefact> art, double pret_curent) override {
        if (art->getTip() == tip_ignorat) return false;

        int voturi_pozitive = 0;
        for (auto& rep : reprezentanti) {
            if (rep->oferaPret(art, pret_curent)) {
                voturi_pozitive++;
            }
        }

        bool conditie_majoritate = (voturi_pozitive >= reprezentanti.size() / 2.0);
        bool conditie_preferat = (art->getTip() == tip_preferat && voturi_pozitive >= 1);

        bool decizie_finala = conditie_majoritate || conditie_preferat;

        return decizie_finala && (pret_curent + pas_licitare <= buget);
    }

    void afisare() const override {
        cout << "[Pers. Juridica] Organizatie: " << nume_organizatie 
             << " | Reprezentanti: " << reprezentanti.size() << " | ";
        Participant::afisare();
    }
};


class Licitatie {
    vector<shared_ptr<Artefact>> inventar;
    vector<shared_ptr<Participant>> participanti;


public:
    void adaugaArtefact(shared_ptr<Artefact> a) { inventar.push_back(a); }
    void adaugaParticipant(shared_ptr<Participant> p) { participanti.push_back(p); }

    void afiseazaDisponibile() const {
        cout << "\n--- Artefacte Disponibile ---\n";
        for (const auto& a : inventar) a->afisare();
    }

    void afiseazaColectibilitate() const {
        cout << "\n--- Colectibilitate ---\n";
        for (const auto& a : inventar) {
            cout << "ID " << a->getId() << " -> " 
                 << (a->esteDeColectie() ? "Ridicata" : "Scazuta") << "\n";
        }
    }


    void clasamentParticipanti() {
        vector<shared_ptr<Participant>> copie = participanti;
        sort(copie.begin(), copie.end(), [](shared_ptr<Participant> a, shared_ptr<Participant> b) {
            return a->getNrCumparate() > b->getNrCumparate();
        });

        cout << "\n--- Clasament Participanti ---\n";
        for (const auto& p : copie) p->afisare();
    }


    void simuleazaLicitatie(int id_art){
        auto it = find_if(inventar.begin(), inventar.end(), [id_art](shared_ptr<Artefact> a)
        {
            return a -> getId() == id_art;
        });

        if (it == inventar.end()){
            cout << "Artefact negasit\n";
            return;
        }

        shared_ptr<Artefact> art = *it;
        double pret_curent = art->getPretInitial();
        shared_ptr<Participant> castigator = nullptr;

        cout << "\n--- Incepe licitatia pentru ID " << id_art << " ---\n";
        
        bool activ = true;
        while(activ){
            activ = false;
            for (auto& p : participanti){
                if (p -> oferaPret(art, pret_curent)){
                    pret_curent += 10;
                    castigator = p;
                    activ = true;
                }
            }
        }

        if (castigator) {
            cout << "Vandut participantului #" << castigator->getNr() << " pentru " << pret_curent << "!\n";
            castigator->achizitioneaza(art, pret_curent);
            inventar.erase(it);
        } else {
            cout << "Nu s-a vandut.\n";
        }

    }
};



int main() {
    Licitatie casa;

    casa.adaugaArtefact(make_shared<ArtefactIstoric>(1, "Sabie", "Evul Mediu", 1000, vector<string>{"Rege", "Cavaler", "Savant", "Fierar"}));
    casa.adaugaArtefact(make_shared<ArtefactArtistic>(2, "Tablou", "Modern", 500, "pictura", "ulei"));
    casa.adaugaArtefact(make_shared<ArtefactPretios>(3, "Inel", "Antic", 5000, "Necunoscut", 300));

    casa.adaugaParticipant(make_shared<PersoanaFizica>(2000, 50, 1500, "istoric", "pretios", "Ion"));
    casa.adaugaParticipant(make_shared<PersoanaFizica>(1000, 20, 600, "artistic", "nimic", "Maria"));

    casa.afiseazaDisponibile();
    casa.afiseazaColectibilitate();

    casa.simuleazaLicitatie(1);
    
    casa.clasamentParticipanti();

    return 0;
}