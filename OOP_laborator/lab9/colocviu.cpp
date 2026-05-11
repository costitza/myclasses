#include <bits/stdc++.h>

using namespace std;


class IO{
public:
    IO() {};
    virtual ~IO() = default;
    virtual void afisare() const = 0;
    friend ostream& operator<<(ostream& os, const IO& ob);
};

ostream& operator<<(ostream& os, const IO& ob){
    ob.afisare();
    return os;
}


class Proba : public IO {
    int dist;
    string tip;
public:
    Proba(int d, string i) : dist(d), tip(i) {}
    virtual ~Proba() = default;

    string getType();
    virtual double calculateScore() = 0;
};


string Proba :: getType(){
    return this -> tip;
}

class Sprint : public Proba{
    double time;
public:
    Sprint(int d, double tim) : Proba(100, "sprint"), time(tim) {}

    double calculateScore() override;
    void afisare() const override;
};

double Sprint :: calculateScore() {
    if (time < 10) return 10;
    return 90 / time;
}

void Sprint :: afisare() const {
    cout << "[Proba] - sprint, timp personal (in secunde): " << time << '\n'; 
}


class Cros : public Proba{
    double time; 
public:
    Cros(double tim) : Proba(10000, "cros"), time(tim) {}

    double calculateScore() override;
    void afisare() const override;
};

double Cros :: calculateScore() {
    if (time < 30) return 10;
    return 120 / time;
}


void Cros :: afisare() const {
    cout << "[Proba] - cros, timp personal (in minute): " << time << '\n'; 
}


class Semi : public Proba{
    double distance;
public:
    Semi(double d) : Proba(21000, "semi"), distance(d) {}

    double calculateScore() override;
    void afisare() const override;
};

double Semi :: calculateScore(){
    if (distance > 50) return 10;
    return distance / 5;
}

void Semi :: afisare() const {
    cout << "[Proba] - semi, distanta (in km): " << distance << '\n'; 
}


class Marathon : public Proba{
    double distance;
public:
    Marathon(double d) : Proba(42000, "maraton"), distance(d) {}

    double calculateScore() override;
    void afisare() const override;
};

double Marathon :: calculateScore(){
    if (distance > 50) return 10;
    return distance / 5;
}

void Marathon :: afisare() const {
    cout << "[Proba] - maraton, distanta (in km): " << distance << '\n'; 
}


class Candidat {
    string nume, prenume;
    string data_nastere;
    shared_ptr<Proba> proba;

public:
    Candidat(string n, string p, string d, shared_ptr<Proba>& prob) : nume(n), prenume(p), data_nastere(d), proba(prob) {}
    virtual ~Candidat() = default;
    double getScore() const{
        return this -> proba -> calculateScore();
    }

    void afisare() const{

        cout << "Nume: " << nume << ", prenume: " << prenume << ", data nastere: " << data_nastere 
            << "\n<Scor obtinut> :" << getScore() << '\n   ';
        this -> proba -> afisare();
    }

    friend ostream& operator<<(ostream& os, const Candidat& ob){
        ob.afisare();
        return os;
    }
};


