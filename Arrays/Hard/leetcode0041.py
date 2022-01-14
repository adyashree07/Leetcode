# https://leetcode.com/problems/first-missing-positive/

# Given an unsorted integer array nums, return the smallest missing positive integer.
# You must implement an algorithm that runs in O(n) time and uses constant extra space.

# My Solution
class Solution:
    def firstMissingPositive(self, nums: List[int]) -> int:
        
        n = len(nums)
        i = 0
        
        while(i<n):
            if nums[i]>=1 and nums[i]<=n:
                if nums[i] != nums[nums[i]-1]:
                    nums[nums[i]-1], nums[i] = nums[i],nums[nums[i]-1],
                else:
                    i+=1
            else:
                i+=1
                
        for i in range(n):
            if nums[i] != i+1:
                return (i+1)
            
        return (n+1)
                
        
# Optimal Solution (Violating the question by using extra space)
class Solution:
    def firstMissingPositive(self, nums: List[int]) -> int:
        us = set(nums)
        for i in range(1, len(nums) + 1):
            if i not in us:
                return i
        return len(nums) + 1
