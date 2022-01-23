# https://leetcode.com/problems/single-number/

# Given a non-empty array of integers nums, every element appears twice except for one. Find that single one.
# You must implement a solution with a linear runtime complexity and use only constant extra space.

# My Solution
class Solution:
    def singleNumber(self, nums: List[int]) -> int:
        n = len(nums)
        xor = 0
        
        for i in range(n):
            xor = xor ^ nums[i]
            
        return xor
            
        
# Optimal Solution
class Solution:
    def singleNumber(self, nums: List[int]) -> int:
        res = 0
        for num in nums:
            res ^= num
        return res
      
      
