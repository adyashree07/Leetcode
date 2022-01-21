# https://leetcode.com/problems/reverse-linked-list/

# Given the head of a singly linked list, reverse the list, and return the reversed list.

# My Solution
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def reverseList(self, head: Optional[ListNode]) -> Optional[ListNode]:
        prev = None
        ahead = None
        current = head
        
        while current:
            ahead = current.next
            current.next = prev
            prev = current
            current = ahead
            
        head = prev
        
        return head
            
        
# Optimal Solution
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def reverseList(self, head: Optional[ListNode]) -> Optional[ListNode]:
        prev = None
        cur = head
        while cur:
            if not cur.next:
                cur.next = prev
                return cur
            temp = cur.next
            cur.next = prev
            prev = cur
            cur = temp
            
            
