//
// Created by ababe on 2/27/2026.
//


#include <bits/stdc++.h>

using namespace std;

struct Node{
    int info;
    Node* next;
};

void adaugaInceput(Node* &head, Node* &tail, int x){

    Node* p = new Node();

    p -> info = x;
    p -> next = nullptr;

    if(tail == nullptr){
        head = tail = p;
    }
    else{
        p -> next = head;
        head = p;
    }
}

void afisare(Node* &head){

    while(head != nullptr){
        cout << head -> info << ' ';
        head = head -> next;
    }
}

void adaugaFinal(Node* &head, Node* &tail, int x){
    Node* p = new Node();

    p -> info = x;
    p -> next = nullptr;

    if (tail == nullptr){
        head = tail = p;
    }
    else{
        tail -> next = p;
        tail = p;
    }
}

void adaugare(Node* &head, Node* &last, int pos, int x){
    if (pos == 0){
        adaugaInceput(head, last, x);
    }
    else{
        Node* r = head;
        for (int i = 0; i < pos - 1 && r != nullptr; i++){
            r = r -> next;
        }

        if (r == nullptr){
            std::cout << "Pozitie invalida";
            return;
        }
        else{
            if (r -> next == nullptr){
                adaugaFinal(head, last, x);
            }
            else{
                Node* p = new Node();
                p -> info = x;

                p -> next = r -> next;
                r -> next = p;
            }
        }
    }
}

int main() {
    Node* head = nullptr;
    Node* tail = nullptr;

    for(int i = 0; i < 10; i++){
        adaugaInceput(head, tail, i);
    }

    afisare(head);


    return 0;
}