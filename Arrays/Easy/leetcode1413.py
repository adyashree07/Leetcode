# https://leetcode.com/problems/minimum-value-to-get-positive-step-by-step-sum/

# Given an array of integers nums, you start with an initial positive value startValue.
# In each iteration, you calculate the step by step sum of startValue plus elements in nums (from left to right).
# Return the minimum positive value of startValue such that the step by step sum is never less than 1.

# My Solution
class Solution:
    def minStartValue(self, nums: List[int]) -> int:
        n = len(nums)
        pre_sum = [0]*n
        pre_sum[0] = nums[0]
        
        for i in range(1,n):
            pre_sum[i] = pre_sum[i-1] + nums[i]
            
        min_value = min(pre_sum)
        
        if min_value <= 0:
            return abs(min_value) +1
        else:
            return 1
        
        
# Optimal Solution
class Solution:
    def minStartValue(self, nums: List[int]) -> int:
        m = nums[0]
        c = nums[0]
        for x in nums[1:]:
            c += x
            m = min(m, c)
        return 1 - m if m <= 0 else 1
      
      
