/*
 * @lc app=leetcode id=206 lang=cpp
 *
 * [206] Reverse Linked List
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
    void addFirst(ListNode* &head, int x){
        ListNode* p = new ListNode(x);

        if (head == nullptr){
            head -> val = x;
        }
        else {
            p -> next = head;
            head = p;
        }
    }

    ListNode* reverseList(ListNode* head) {

        ListNode* result = new ListNode();
        if (head != nullptr){
            result -> val = head -> val;

            head = head -> next;
        }
        else{
            return head;
        }

        while (head != nullptr){
            
            addFirst(result, head -> val);
            head = head -> next;

        }

        return result; 
    }
};
// @lc code=end

