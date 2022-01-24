# https://leetcode.com/problems/the-k-weakest-rows-in-a-matrix/

# You are given an m x n binary matrix mat of 1's (representing soldiers) and 0's (representing civilians). The soldiers are positioned in front of the civilians. That is, all the 1's will appear to the left of all the 0's in each row.
# A row i is weaker than a row j if one of the following is true:
# 1. The number of soldiers in row i is less than the number of soldiers in row j.
# 2. Both rows have the same number of soldiers and i < j.
# Return the indices of the k weakest rows in the matrix ordered from weakest to strongest.

# My Solution
class Solution:
    def kWeakestRows(self, mat: List[List[int]], k: int) -> List[int]:
        n = len(mat)
        count = dict()
        
        for i in range(n):
            count[i] = mat[i].count(1)
            
        count = {k:v for k,v in sorted(count.items(),key= lambda item: item[1])}
        
        ans = list(count.keys())[:k]
        return ans
        
        
# Optimal Solution
class Solution:
    def kWeakestRows(self, mat: List[List[int]], k: int) -> List[int]:
        count = {}
        for row in range(len(mat)):
            count[row] = sum(mat[row])
        return sorted(count, key = count.get)[:k]
      
      
