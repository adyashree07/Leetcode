#https://leetcode.com/problems/find-first-palindromic-string-in-the-array/

# Given an array of strings words, return the first palindromic string in the array. If there is no such string, return an empty string "".
# A string is palindromic if it reads the same forward and backward.

#My Solution
class Solution:
    def isPalindrome(self, S: str, start: int, end:int) -> bool:
        if start>=end:
            return True
        
        if S[start]!=S[end]:
            return False
        else:
            return self.isPalindrome(S,start+1,end-1)
        
    def firstPalindrome(self, words: List[str]) -> str:
        n = len(words)
        
        for i in range(n):
            if self.isPalindrome(words[i],0,len(words[i])-1):
                return words[i]
        
        return ""
      
      
#Optimal Solution
class Solution:
    def firstPalindrome(self, words: List[str]) -> str:
        for s in words:
            if s == s[::-1]:
                return s
        return ""
