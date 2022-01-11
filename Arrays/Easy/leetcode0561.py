# https://leetcode.com/problems/array-partition-i/
  
# Given an integer array nums of 2n integers, group these integers into n pairs (a1, b1), (a2, b2), ..., (an, bn) such that the sum of min(ai, bi) for all i is maximized. Return the maximized sum.

#My Solution
class Solution:
    def arrayPairSum(self, nums: List[int]) -> int:
        nums.sort()
        n = len(nums)
        
        sum = 0
        for i in range(0,n-1,2):
            sum += nums[i]
            
        return sum
        
      
#Optimal Solution
class Solution:
    def arrayPairSum(self, nums: List[int]) -> int:
        return sum(sorted(nums)[::2])
      
