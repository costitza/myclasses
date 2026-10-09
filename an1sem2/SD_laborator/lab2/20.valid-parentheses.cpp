/*
 * @lc app=leetcode id=20 lang=cpp
 *
 * [20] Valid Parentheses
 */

#include <bits/stdc++.h>
#include <string>
using namespace std;

// @lc code=start
class Solution {
public:

    struct Stiva{
        int info;
        Stiva* next;
    };

    void push(Stiva* &st, int x){
        Stiva* p = new Stiva();
        p -> info = x;

        p -> next = nullptr;

        if(st == nullptr){
            st = p;
        }
        else{
            p -> next = st;
            st = p;
        }
    }


    void pop(Stiva* &st){
        Stiva* t = st;
        st = st -> next;
        delete t;
    }


    int top(Stiva* st){
        return st -> info;
    }

    bool empty(Stiva* st){
        return st == nullptr;
    }

    bool isValid(string s) {
        Stiva* st = nullptr;

        for(int i = 0;i < s.size();i++){
            if(s[i] == '(' || s[i] == '[' || s[i] == '{'){
                push(st, s[i]);
            }
            else{
                if(s[i] == ')'){
                    if(!empty(st) && top(st) == '('){
                        pop(st);
                    }
                    else{
                        return false;
                    }
                }
                else if(s[i] == ']'){
                    if(!empty(st) && top(st) == '['){
                        pop(st);
                    }
                    else{
                        return false;
                    }
                }
                else if(s[i] == '}'){
                    if(!empty(st) && top(st) == '{'){
                        pop(st);
                    }
                    else{
                        return false;
                    }
                }
            }
        }
        if(empty(st))
            return true;
        return false;
    }
};
// @lc code=end

