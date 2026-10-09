#include <iostream>

using namespace std;

struct ABC {
    int info;
    ABC* left;
    ABC* right;
};

void inserare(ABC* &root, int val) {
    if(root == NULL) {
        root = new ABC;
        root -> info = val;
        root -> left = NULL;
        root -> right = NULL;
    } else {
        if(val < root -> info) {
            inserare(root -> left, val);
        } else {
            inserare(root -> right, val);
        }
    }
}

int test_case(ABC* root);

int main() {
    int n;
    cin >> n;
    ABC* root = NULL;
    for(int i = 1; i <= n; i++) {
        int x;
        cin >> x;
        inserare(root, x);
    }
    int sol = test_case(root);
    cout << sol;
    return 0;
}

// MODIFY START

int test_case(ABC* root) {
    ABC* stanga = root;
    ABC* dreapta = root;

    while(stanga -> left != nullptr){
        stanga = stanga -> left;
    }

    while(dreapta -> right != nullptr){
        dreapta = dreapta -> right;
    }


    return dreapta -> info - stanga -> info;
}


