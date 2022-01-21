# https://leetcode.com/problems/palindrome-linked-list/

# Given the head of a singly linked list, return true if it is a palindrome.

# My Solution
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def isPalindrome(self, head: Optional[ListNode]) -> bool:
        S = ""
        
        while head:
            S +=str(head.val)
            head = head.next
            
        if S == S[::-1]:
            return True
        else:
            return False
        
        
# Optimal Solution
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def isPalindrome(self, head: Optional[ListNode]) -> bool:
        
        prev=None
        slow=fast=head
        while fast and fast.next:
            fast=fast.next.next
            slow.next,prev,slow=prev,slow,slow.next
            
        if fast:
            slow=slow.next
        
        while slow:
            if slow.val!=prev.val: return False
            slow=slow.next
            prev=prev.next
        return True
        
