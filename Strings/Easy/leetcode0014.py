# https://leetcode.com/problems/longest-common-prefix/

# Write a function to find the longest common prefix string amongst an array of strings.
# If there is no common prefix, return an empty string "".

# My Solution
class Solution:
    def longestCommonPrefix(self, strs: List[str]) -> str:
        n = len(strs)
        min_str  = 200
        
        for i in strs:
            min_str = min(min_str,len(i))
            
        output = ""
        flag = True
        
        for j in range(min_str):
            s = strs[0][j]
            for i in range(1,n):
                if s!=strs[i][j]:
                    flag = False
                    break
                
            if flag:
                output += s
                
        return output
                    
                    
# Optimal Solution
class Solution:
    def longestCommonPrefix(self, strs: List[str]) -> str:
        if len(strs) == 0:
            return ""
        else:
            s1, s2 = max(strs), min(strs)
            i, match = 0, 0
            while i < len(s1) and i < len(s2) and s1[i] == s2[i]:
                i, match = i+1, match + 1
            return s1[0:match]
          
          
