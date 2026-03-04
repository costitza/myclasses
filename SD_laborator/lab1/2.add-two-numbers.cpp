/*
 * @lc app=leetcode id=2 lang=cpp
 *
 * [2] Add Two Numbers
 */
// Definition for singly-linked list.


struct ListNode {
    int val;
    ListNode *next;
    ListNode() : val(0), next(nullptr) {}
    ListNode(int x) : val(x), next(nullptr) {}
    ListNode(int x, ListNode *next) : val(x), next(next) {}
};


// @lc code=start


class Solution {
public:
    ListNode* addTwoNumbers(ListNode* l1, ListNode* l2) {
        ListNode* result = new ListNode(0);
        ListNode* curr = result;

        int carry = 0;

        while(l1 || l2 || carry != 0){
            
            int x = (l1 != nullptr) ? l1 -> val : 0;
            int y = (l2 != nullptr) ? l2 -> val : 0;

            int sum = x + y + carry;
            if (sum >= 10){
                sum = sum % 10;
                carry = 1;
            }
            else{
                carry = 0;
            }

            ListNode* nextnode = new ListNode(sum);
            curr -> next = nextnode;

            curr = nextnode;
            if (l1 != nullptr) l1 = l1 -> next;
            if (l2 != nullptr) l2 = l2 -> next;

        }

        return result -> next;
    }
};
// @lc code=end

