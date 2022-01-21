# https://leetcode.com/problems/convert-binary-number-in-a-linked-list-to-integer/

# Given head which is a reference node to a singly-linked list. The value of each node in the linked list is either 0 or 1. The linked list holds the binary representation of a number.
# Return the decimal value of the number in the linked list.

# My Solution
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def getDecimalValue(self, head: ListNode) -> int:
        p = head
        count = 0
        while head:
            count += 1
            head = head.next
            
        
        ans = 0
        power = count
        while p:
            ans = ans + (p.val)*(pow(2,power-1))
            power -= 1
            p = p.next
            
        return ans
            
            
# Optimal Solution
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def getDecimalValue(self, head: ListNode) -> int:
        result = 0
        while head is not None:
            result = result * 2 + head.val
            head = head.next
        return result
      
      
