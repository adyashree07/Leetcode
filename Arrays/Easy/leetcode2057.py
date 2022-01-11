#https://leetcode.com/problems/smallest-index-with-equal-value/

# Given a 0-indexed integer array nums, return the smallest index i of nums such that i mod 10 == nums[i], or -1 if such index does not exist.
# x mod y denotes the remainder when x is divided by y.

#My Solution
class Solution:
    def smallestEqual(self, nums: List[int]) -> int:
        n = len(nums)
        
        for i in range(n):
            if i%10 == nums[i]:
                return i
            
        return -1
        
    
#Optimal Solution
class Solution:
    def smallestEqual(self, nums: List[int]) -> int:
        for i,num in enumerate(nums):
            if i % 10 == num:
                return i
        return -1
      
 
