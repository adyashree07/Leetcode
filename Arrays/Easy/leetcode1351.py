#https://leetcode.com/problems/count-negative-numbers-in-a-sorted-matrix/

#Given a m x n matrix grid which is sorted in non-increasing order both row-wise and column-wise, return the number of negative numbers in grid.

#My solution
class Solution:
    def countNegatives(self, grid: List[List[int]]) -> int:
        n = len(grid)
        
        count = 0
        for i in range(n):
            for j in range(len(grid[i])-1,-1,-1):
                if grid[i][j] < 0:
                    count+=1
                else:
                    break
                    
        return count
        
        
#Optimal Solution
class Solution:
    def countNegatives(self, grid: List[List[int]]) -> int:
        r,c = len(grid),len(grid[0])
        i,j = r-1,0
        cnt=0
        while i>=0 and j<c:
            if grid[i][j]<0:
                cnt+=c-j
                i-=1
            else:
                j+=1
        return cnt
        
