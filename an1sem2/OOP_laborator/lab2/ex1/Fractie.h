#pragma once 
#include <iostream> 

class Fractie
{
private:
    int numitor, numarator;

public:
    Fractie();
    Fractie(int x, int y);
    Fractie(const Fractie& other);
    
    Fractie& operator=(const Fractie& other);
    friend bool operator==(const Fractie& a, const Fractie& b);
    friend Fractie operator+(const Fractie& a, const Fractie& b);

    Fractie& operator++();
    Fractie operator++(int);

    // indexare
    int& operator[](int index);
    
    // output
    friend std::ostream& operator<<(std::ostream& out, const Fractie& f);

    // input 
    friend std::istream& operator>>(std::istream& in, Fractie& f);
};

