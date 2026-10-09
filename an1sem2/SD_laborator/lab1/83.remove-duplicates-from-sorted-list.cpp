/*
 * @lc app=leetcode id=83 lang=cpp
 *
 * [83] Remove Duplicates from Sorted List
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
    ListNode* deleteDuplicates(ListNode* head) {
        ListNode* curr = head;
        if (head == nullptr || curr -> next == nullptr) {
            return curr;
        }
        ListNode* nextNode = curr -> next;
        while (nextNode != nullptr){
            if (curr -> val == nextNode -> val){
                curr -> next = nextNode -> next;
                nextNode = curr -> next;
            }
            else{
                curr = nextNode;
                nextNode = nextNode -> next;
            }
        }
        return head;
    }
};


// @lc code=end
