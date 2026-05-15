#include <bits/stdc++.h>

using namespace std;

class Stiva {
    struct Node {
        string nume;
        Node * next;

        Node(string x) : nume(x), next(nullptr) {}
    };
    
    Node* vf = nullptr;

public:
    bool empty() {
        return vf == nullptr;
    }

    string top(){
        if (empty() == true){
            return "/";
        }
        else{
            return vf -> nume;
        }
    }

    void pop(){
        if(empty() == false){
            Node* temp = vf;
            vf = vf -> next;
            delete temp;
        }
    }


    void push(string s){
        Node *p = new Node(s);

        if (empty() == true) {
            vf = p;
        }
        else{
            p -> next = vf;
            vf = p;
        }
    }
};

int main(){

    int n;
    cin >> n;
    Stiva st;

    for (int i = 0;i < n;i ++){
        string op;
        cin >> op;

        if(op == "pwd"){
            st.top();
        }
        else if(op == "cd"){
            string arg;
            cin >> arg;

            
            if(arg == ".."){
                st.pop();
            }
            else{
                st.push(arg);
            }
        }
    }

    return 0;
}