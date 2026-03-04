/*
 * @lc app=leetcode id=147 lang=cpp
 *
 * [147] Insertion Sort List
 */


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
    ListNode* insertionSortList(ListNode* head) {
        if (head == nullptr){
            return nullptr;
        }

        ListNode* curr = head;
        ListNode* anchor = new ListNode(head -> val);
        ListNode* dummy = new ListNode;
        dummy -> next = anchor;


        if (head -> next == nullptr){
            return anchor;
        }
        curr = curr -> next;
        while (curr != nullptr){
            ListNode* nextnode = curr -> next;
            int x = curr -> val;
            ListNode* prev = dummy;

            while (prev -> next != nullptr && prev -> next -> val < x){
                prev = prev -> next;
            }

            curr -> next = prev -> next;
            prev -> next = curr;

            // update curr
            curr = nextnode;

        }

        return dummy -> next;

    }
};
// @lc code=end

