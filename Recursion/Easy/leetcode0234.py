# https://leetcode.com/problems/palindrome-linked-list/

# Given the head of a singly linked list, return true if it is a palindrome.

# My Solution
class Solution:
    def isPalindrome(self, head: Optional[ListNode]) -> bool:
        ele = []
        while head:
            ele.append(head.val)
            head = head.next
            
        def palindrome(ele, start, end):
            if start>end:
                return True
            else:
                if ele[start] != ele[end]:
                    return False
                return palindrome(ele,start+1,end-1)
        
        return palindrome(ele,0,len(ele)-1)
        
        
# Optimized Solution
class Solution:
    def isPalindrome(self, head: Optional[ListNode]) -> bool:
        self.left = ListNode(-1,head)
        def isPal(head):
            if not head: return True
            right = isPal(head.next)
            self.left = self.left.next
            return right and self.left.val == head.val
        return isPal(head)
      
      
