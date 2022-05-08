# https://leetcode.com/problems/valid-anagram/

# Given two strings s and t, return true if t is an anagram of s, and false otherwise.
# An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.

# My Solution
class Solution:
    def isAnagram(self, s: str, t: str) -> bool:
        freq1 = collections.Counter(s)
        freq2 = collections.Counter(t)
        
        if len(freq1)!= len(freq2):
            return False
        
        for k in freq1.keys():
            if k not in freq2:
                return False
            else:
                if freq1[k]!= freq2[k]:
                    return False
                
        return True
        
        
