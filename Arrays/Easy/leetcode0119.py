# https://leetcode.com/problems/pascals-triangle-ii/

# Given an integer rowIndex, return the rowIndexth (0-indexed) row of the Pascal's triangle.
# In Pascal's triangle, each number is the sum of the two numbers directly above it.

# My Solution
class Solution:
    def getRow(self, rowIndex: int) -> List[int]:
        ans =[]
        ans.append([1])
        ans.append([1,1])
            
        for i in range(2,rowIndex+1):
            res = ans[-1]
            res1 = [0]*(i+1)
            res1[0] = 1
            res1[-1] = 1
            for j in range(1,i):
                res1[j] = res[j] + res[j-1]    
            ans.append(res1)
           
        return ans[rowIndex]
      
      
# Optimal Solution
class Solution:
    def getRow(self, rowIndex: int) -> List[int]:
        row = [1]
        for i in range(rowIndex):
            row = [0] + row
            for j in range(len(row)-1):
                row[j] += row[j + 1]
        return row
      
      
