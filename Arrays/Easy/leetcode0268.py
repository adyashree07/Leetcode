# https://leetcode.com/problems/missing-number/

# Given an array nums containing n distinct numbers in the range [0, n], return the only number in the range that is missing from the array.

# My Solution
class Solution:
    def missingNumber(self, nums: List[int]) -> int:
        nums.sort()
        n = len(nums)
        
        for i in range(n):
            if i!=nums[i]:
                return i
            
        return i+1
      
      
# Optimal Solution
class Solution:
    def missingNumber(self, nums: List[int]) -> int:
        n = len(nums)
        total = (n + 1) * n / 2
        summary = sum(nums)
        
        return int(total - summary)
      
      
