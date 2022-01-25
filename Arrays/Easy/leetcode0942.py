# https://leetcode.com/problems/di-string-match/

# A permutation perm of n + 1 integers of all the integers in the range [0, n] can be represented as a string s of length n where:
# 1. s[i] == 'I' if perm[i] < perm[i + 1], and
# 2. s[i] == 'D' if perm[i] > perm[i + 1].
# Given a string s, reconstruct the permutation perm and return it. If there are multiple valid permutations perm, return any of them.

# My Solution
class Solution:
    def diStringMatch(self, s: str) -> List[int]:
        n = len(s)
        j = len(s)
        i = 0
        ans = []
        
        for k in range(n):
            if s[k]=="I":
                ans.append(i)
                i += 1
            else:
                ans.append(j)
                j -= 1
                
        ans.append(i)
                
        return ans
        
        
# Optimal Solution
class Solution:
    def diStringMatch(self, s: str) -> List[int]:
        i, j, ans = 0, len(s), []
        for x in s:
            if x=='I':
                ans.append(i)
                i+=1
            else:
                ans.append(j)
                j-=1   
        ans.append(j) 
        return ans
      
      
      
        
