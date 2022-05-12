# https://leetcode.com/problems/reverse-string/

# Write a function that reverses a string. The input string is given as an array of characters s.
# You must do this by modifying the input array in-place with O(1) extra memory.

# My Solution
class Solution:    
    def reverse(self, s, start, end):
        if start<end:
            s[start],s[end] = s[end],s[start]
            self.reverse(s,start+1,end-1)
            
    def reverseString(self, s: List[str]) -> None:
        """
        Do not return anything, modify s in-place instead.
        """
        n = len(s)
        self.reverse(s,0,n-1)
   
