#include <cmath>
#include <cstdio>
#include <vector>
#include <iostream>
#include <algorithm>
using namespace std;


struct Node{
    Node* next;

    string val;

    Node(string v){
        next = nullptr;
        val = v;
    }
}*root;


void push(Node* &root, string x){
    if (root == nullptr){
        root = new Node(x);
    }
    else{
        Node* temp = new Node(x);

        temp -> next = root;
        root = temp;
    }
}


void pop(Node* &root){
    if(root == nullptr) return;

    if(root -> next == nullptr){
        return;
    }
    else{
        Node* temp = root;
        root = root -> next;
        delete temp;
    }
}

int main() {
    int n;
    cin >> n;

    push(root, "/");

    for (int i = 0;i < n;i++){
        string c;
        cin >> c;

        if(c == "cd"){
            string t;
            cin >> t;

            if(t == ".."){
                pop(root);
            }
            else{
                push(root, t);
            }
        }
        else if(c == "pwd"){
            
            cout << root -> val << '\n';
        }
    }

    return 0;
}
