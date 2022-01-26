# https://leetcode.com/problems/pascals-triangle/

# Given an integer numRows, return the first numRows of Pascal's triangle.
# In Pascal's triangle, each number is the sum of the two numbers directly above it.

# My Solution
class Solution:
    def generate(self, numRows: int) -> List[List[int]]:
        ans =[]
        ans.append([1])
        if numRows==1:
            return ans
        ans.append([1,1])
            
        for i in range(2,numRows):
            res = ans[-1]
            res1 = [0]*(i+1)
            res1[0] = 1
            res1[-1] = 1
            for j in range(1,i):
                res1[j] = res[j] + res[j-1]    
            ans.append(res1)
           
        return ans
                
                
# Optimal Solution
class Solution:
    def generate(self, numRows: int) -> List[List[int]]:
        l=[0]*numRows
        for i in range(numRows):
            l[i]=[0]*(i+1)
            l[i][0]=1
            l[i][i]=1
            for j in range(1,i):
                l[i][j]=l[i-1][j-1]+l[i-1][j]
        return l
      
      
        
