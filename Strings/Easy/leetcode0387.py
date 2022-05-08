# https://leetcode.com/problems/first-unique-character-in-a-string/

# Given a string s, find the first non-repeating character in it and return its index. If it does not exist, return -1.

# My Solution
class Solution:
    def firstUniqChar(self, s: str) -> int:
        freq = collections.Counter(s)
        n = len(s)
        
        for i in range(n):
            if freq[s[i]]==1:
                return i
            
        return -1
      
      
# Optimal Solution
class Solution:
    def firstUniqChar(self, s: str) -> int:
        duplicates = set()
        for i in range(len(s)):
            if s[i] in duplicates:
                continue
            if s[i] not in s[i+1:]:
                return i
            duplicates.add(s[i])
        return -1
      
      
