#include <bits/stdc++.h>

using namespace std;


template <typename T, int R, int C>
class Matrice{
    T date[R][C] = {};

public:

    void setElement(int pozi, int pozj, const T& val){
        date[pozi][pozj] = val;
    }

    T getElement(int pozi, int pozj) const{
        return date[pozi][pozj];
    }

    Matrice<T, R, C> operator+(const Matrice<T, R, C>& other){
        Matrice<T, R, C> rez;
        for(int i = 0;i < R; i++){
            for(int j = 0;j < C; j++){
                rez.setElement(i, j, date[i][j] + other.getElement(i, j));
            }
        }

        return rez;
    }

    // inmultire cu scalar
    Matrice<T, R, C> operator*(const T& scalar){
        Matrice<T, R, C> rez;
        for(int i = 0;i < R; i++){
            for(int j = 0;j < C; j++){
                rez.setElement(i, j, date[i][j] * scalar);
            }
        }

        return rez;
    }

    // inmultire intre matr
    template <int K>
    Matrice<T, R, K> operator*(const Matrice<T, C, K>& other){
        Matrice<T, R, K> rez;

        for (int i = 0;i < R; i++){
            for(int j = 0;j < K; j++){
                T suma = 0;
                for (int k = 0;k < C; k++){
                    suma += date[i][k] * other.getElement(k, j);
                }

                rez.setElement(i, j, suma);
            }
        }

        return rez;
    }


    void afisare() const {
        for (int i = 0; i < R; ++i) {
            for (int j = 0; j < C; ++j) {
                cout << date[i][j] << " ";
            }
            cout << "\n";
        }
    }

};



template <typename T, int R, int C>
class Matrice<T*, R, C> {
    T* date[R][C] = {nullptr};

public:

    void setElement(int pozi, int pozj, T* val) {
        date[pozi][pozj] = val;
    }

    Matrice<T, R, C> operator+(const Matrice<T*, R, C>& alta) const {
        Matrice<T, R, C> rez;


        for (int i = 0; i < R; ++i) {
            for (int j = 0; j < C; ++j) {
                T v1 = (date[i][j] != nullptr) ? *date[i][j] : 0;
                T v2 = (alta.date[i][j] != nullptr) ? *alta.date[i][j] : 0;

                rez.setElement(i, j, v1 + v2);
            }
        }

        return rez;
    }

    void afisare() const {
        for (int i = 0; i < R; ++i) {
            for (int j = 0; j < C; ++j) {
                if (date[i][j]) {
                    std::cout << *date[i][j] << " ";
                } else {
                    std::cout << "NULL ";
                }
            }
            std::cout << "\n";
        }
    }
};


int main(){
    Matrice<int, 2, 2> m1, m2;
    m1.setElement(0, 0, 1); 
    m1.setElement(0, 1, 2);
    m1.setElement(1, 0, 3); 
    m1.setElement(1, 1, 4);
    
    m2.setElement(0, 0, 2);
    m2.setElement(0, 1, 0);
    m2.setElement(1, 0, 1);
    m2.setElement(1, 1, 2);

    std::cout << "Adunare m1 + m2:\n";
    (m1 + m2).afisare();

    std::cout << "Inmultire m1 * m2:\n";
    (m1 * m2).afisare();


}