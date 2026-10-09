/*
 * @lc app=leetcode id=84 lang=cpp
 *
 * [84] Largest Rectangle in Histogram
 */

#include <bits/stdc++.h>
using namespace std;

// @lc code=start
class Solution {
public:
    int largestRectangleArea(vector<int>& heights) {
        // dr[i] = pozitia primului element de la dreapta lui i mai mic decat a[i]
        stack<int> st;
        int n = heights.size();
        vector<int> dr(n);

        for (int i = n - 1; i >= 0; i--){
            while(!st.empty() && heights[i] <= heights[st.top()]){
                st.pop();
            }
            if(st.empty()){
                dr[i] = n - 1;
            }
            else{
                dr[i] = st.top() - 1;
            }
            st.push(i);
        }
        while(!st.empty()){
            st.pop();
        }
        //st[i] = pozitia primului elem de la stanga lui i mai mic decat a[i]

        vector<int> st1(n);

        for (int i = 0;i < n;i ++){
            while(!st.empty() && heights[i] <= heights[st.top()]){
                st.pop();
            }
            if (st.empty()){
                st1[i] = 0;
            }
            else{
                st1[i] = st.top() + 1;
            }
            st.push(i);
        }
        while(!st.empty()){
            st.pop();
        }

        int mx = 0;
        for(int i = 0;i < n;i++){
            int area = heights[i] * (dr[i] - st1[i] + 1);
            mx = max(mx, area); 
        }
        

        return mx;
    }
};
// @lc code=end

