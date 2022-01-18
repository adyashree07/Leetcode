# https://leetcode.com/problems/squares-of-a-sorted-array/

# Given an integer array nums sorted in non-decreasing order, return an array of the squares of each number sorted in non-decreasing order.

# My Solution
class Solution:
    def sortedSquares(self, nums: List[int]) -> List[int]:
        n = len(nums)
        
        for i in range(n):
            nums[i] = nums[i]**2
            
        nums.sort()
        
        return nums
        
        
# Optimal Solution
class Solution:
    def sortedSquares(self, nums: List[int]) -> List[int]:
        return sorted([num * num for num in nums])
      
      
