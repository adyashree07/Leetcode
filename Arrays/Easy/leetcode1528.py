# https://leetcode.com/problems/shuffle-string/

# You are given a string s and an integer array indices of the same length. The string s will be shuffled such that the character at the ith position moves to indices[i] in the shuffled string.
# Return the shuffled string.

# My Solution
class Solution:
    def restoreString(self, s: str, indices: List[int]) -> str:
        ans = [None]*len(s)
        res = ""

        for i in range(len(s)):
            ans[indices[i]] = s[i]
            
        for i in ans:
            res+=i
        return res
        
        
# Optimal Solution
class Solution:
    def restoreString(self, s: str, indices: List[int]) -> str:
        new_ls=[None for _ in range(len(s))]
        for i in range(len(s)):
            new_ls[indices[i]]=s[i]
        return "".join(new_ls)
      
      
