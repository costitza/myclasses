#include "Fractie.h"
#include <iostream>

Fractie::Fractie(){
    this -> numarator = 0;
    this -> numitor = 1;
}

// constr cu var
Fractie::Fractie(int a, int b){
    this -> numarator = a;

    if (b != 0){
        this -> numitor = b;
    }
    else{
        this -> numitor = 1;
    }
}

// copy constructor
Fractie::Fractie(const Fractie& other){
    this -> numarator = other.numarator;
    this -> numitor = other.numitor;

}

// overload = 
Fractie& Fractie::operator=(const Fractie& other){
    if(this != &other){
        this -> numarator = other.numarator;
        this -> numitor = other.numitor;
    }
    return *this;
}


// overload ++
Fractie& Fractie::operator++(){
    this -> numarator += this -> numitor;
    return *this;
}

// overload ++ post
Fractie Fractie:: operator++(int){
    Fractie old = *this;
    ++(*this);
    return old;
}

// overload + 
Fractie operator+(const Fractie& a, const Fractie& b){
    int new_nr = a.numarator * b.numitor + b.numarator * a.numitor;
    int new_num = a.numitor * b.numitor;

    return Fractie(new_nr, new_num);
}

// indexare
int& Fractie::operator[](int index){
    if (index == 0) return this -> numarator;
    return this -> numitor;

}

// overload ==
bool operator==(const Fractie& a, const Fractie& b){
    return (a.numarator * b.numitor == a.numitor * b.numarator);
}

// overload <<
std::ostream& operator<<(std::ostream& out, const Fractie& f){
    out << "fractia ta este: " << f.numarator << "/" << f.numitor << '\n';
    return out;
}

// overload >> 
std::istream& operator>>(std::istream& in, Fractie& f){
    
    in >> f.numarator;
    in >> f.numitor;

    if (f.numitor == 0){
        f.numitor = 1;
    }

    return in;
}