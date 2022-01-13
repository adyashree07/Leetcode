# https://leetcode.com/problems/check-if-every-row-and-column-contains-all-numbers/
  
# An n x n matrix is valid if every row and every column contains all the integers from 1 to n (inclusive).
# Given an n x n integer matrix matrix, return true if the matrix is valid. Otherwise, return false.

# My Solution
class Solution:
    def checkValid(self, matrix: List[List[int]]) -> bool:
        
        n = len(matrix)
        
        for i in range(n):
            d = dict()
            for j in range(n):
                if matrix[i][j] not in d:
                    d[matrix[i][j]] = 1
                else:
                    return False
                
        for j in range(n):
            d = dict()
            for i in range(n):
                if matrix[i][j] not in d:
                    d[matrix[i][j]] = 1
                else:
                    return False
                
        return True
                
        
 # Optimal Solution
class Solution:
    def checkValid(self, matrix: List[List[int]]) -> bool:
        n = len(matrix)
        
        for r in range(n):
            if len(set(matrix[r])) != n:
                return False
        for c in range(n):
            if len({matrix[r][c] for r in range(n)}) != n:
                return False
        return True
      
