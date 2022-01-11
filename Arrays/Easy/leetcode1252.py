# https://leetcode.com/problems/cells-with-odd-values-in-a-matrix/
  
# There is an m x n matrix that is initialized to all 0's. There is also a 2D array indices where each indices[i] = [ri, ci] represents a 0-indexed location to perform some increment operations on the matrix.
# For each location indices[i], do both of the following:
# 1. Increment all the cells on row ri.
# 2. Increment all the cells on column ci.
# Given m, n, and indices, return the number of odd-valued cells in the matrix after applying the increment to all locations in indices.

#My Solution
import numpy as np
class Solution:
    def oddCells(self, m: int, n: int, indices: List[List[int]]) -> int:
        
        ans =[]
        for i in range(m):
            res = []
            for j in range(n):
                res.append(0)
            ans.append(res)
        
        for i in range(len(indices)):
            ans[indices[i][0]] = list(map(lambda x:x+1,ans[indices[i][0]]))
            for j in range(m):
                ans[j][indices[i][1]] = ans[j][indices[i][1]] +1
            
        l = np.array(ans)
         
        return len(l[l%2!=0])
            
        
#Optimal Solution
class Solution:
    
    def oddCells(self, m: int, n: int, indices: List[List[int]]) -> int:
        
        row = [0 for i in range(m)]
        col = [0 for i in range(n)]
        
        for i, j in indices:
            row[i] += 1
            col[j] += 1
        
        count = 0
        if m <= n:
            for i in range(m): 
                count += sum([(j + row[i]) % 2 for j in col])
        else:
            for i in range(n):
                count += sum([(j + col[i]) % 2 for j in row])
        
        return count
