# https://leetcode.com/problems/delete-columns-to-make-sorted/

# You are given an array of n strings strs, all of the same length.
# The strings can be arranged such that there is one on each line, making a grid. For example, strs = ["abc", "bce", "cae"] can be arranged as:
# abc
# bce
# cae
# You want to delete the columns that are not sorted lexicographically. In the above example (0-indexed), columns 0 ('a', 'b', 'c') and 2 ('c', 'e', 'e') are sorted while column 1 ('b', 'c', 'a') is not, so you would delete column 1.
# Return the number of columns that you will delete.

# My solution
class Solution:
    def minDeletionSize(self, strs: List[str]) -> int:
        n = len(strs[0])
        m = len(strs)
        
        count = 0
        
        for j in range(n):
            for i in range(m-1):
                if ord(strs[i][j])>ord(strs[i+1][j]):
                    count += 1
                    break
                    
        return count
      
     
# Optimal Solution
class Solution:
    def minDeletionSize(self, strs: List[str]) -> int:
        ret = 0
        
        for c in zip(*strs): 
            if list(c) != sorted(c): 
                ret += 1
                
        return ret
      
      
