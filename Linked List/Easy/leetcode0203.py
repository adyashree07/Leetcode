# https://leetcode.com/problems/remove-linked-list-elements/

# Given the head of a linked list and an integer val, remove all the nodes of the linked list that has Node.val == val, and return the new head.

# My Solution
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def removeElements(self, head: Optional[ListNode], val: int) -> Optional[ListNode]:
        if head==None:
            return
        
        if head.val == val:
            head = head.next
            
        p = head
        
        if p==None:
            return 
            
        while head.next:
            if head.next.val==val:
                head.next = head.next.next
            else:
                head = head.next
                
        if p.val == val:
            p = p.next     
                
        return p
        
        
# Optimal Solution
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def removeElements(self, head: Optional[ListNode], val: int) -> Optional[ListNode]:
        prev = None
        curNode = head
        while curNode:
            if curNode.val == val and prev:
                prev.next = curNode.next
            elif curNode.val == val and not prev:
                head = curNode.next
            else:
                prev = curNode
            curNode = curNode.next
        return head
      
      
