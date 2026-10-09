#include <bits/stdc++.h>

using namespace std;

class Stiva{
private:
    struct Node{
        char info;
        Node* next;

        Node(char i) : info(i), next(nullptr) {}
    };

    Node* head = nullptr;


public:

    bool empty(){
        if(head == nullptr) return true;
        return false;
    }

    char top(){
        if(head != nullptr){
            return head -> info;
        }
        else{
            return '0';
        }
    }


    void push(char ch){
        Node* temp = new Node(ch);
        temp -> next = head;
        head = temp;
    }

    void pop(){
        if(head != nullptr){
            Node *temp = head;

            head = head -> next;
            delete temp;
        }
    }
};


int main(){

    Stiva st;

    string str;

    cin >> str;
    int index = 0;

    for(int i = 0;i < str.size();i++){
        if(str[i] == '<'){
            st.push(str[i]);
        }
        else{
            if(!st.empty()){
                st.pop();
            }
            else{
                break;
            }
        }

        if(st.empty()){
            index = i + 1;
        }
    }

    for(int i = 0;i < index; i++){
        cout << str[i];
    }

    return 0;
}