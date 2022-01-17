# https://leetcode.com/problems/word-pattern/

# Given a pattern and a string s, find if s follows the same pattern.
# Here follow means a full match, such that there is a bijection between a letter in pattern and a non-empty word in s.

# My Solution
class Solution:
    def wordPattern(self, pattern: str, s: str) -> bool:
        s = s.split(" ")
        if len(s)!= len(pattern):
            return False
        
        word = list(dict.fromkeys(s))
        unique = list(OrderedDict((k, True) for k in pattern).keys())
        
        if len(unique) != len(word):
            return False
        
        ele = dict()
        for i in range(len(word)):
            ele[unique[i]] = word[i]
            
        for i in range(len(s)):
            if s[i]!=ele[pattern[i]]:
                return False
            
        return True
    
        
# Optimal Solution
class Solution:
    def wordPattern(self, pattern: str, s: str) -> bool:
        s = s.split(' ')
        d = {}
        if len(s) != len(pattern):
            return False
        for i in range(len(pattern)):
            if pattern[i] in d.keys():
                if s[i] != d[pattern[i]]:
                    return False
            else:
                if s[i] in d.values():
                    return False
                d[pattern[i]] = s[i]
        return True
      
      
