# https://leetcode.com/problems/move-zeroes/

# Given an integer array nums, move all 0's to the end of it while maintaining the relative order of the non-zero elements.
# Note that you must do this in-place without making a copy of the array.

# My Solution
class Solution:
    def moveZeroes(self, nums: List[int]) -> None:
        """
        Do not return anything, modify nums in-place instead.
        """
        i = 0
        count = 0
        n = len(nums)
        
        for j in nums:
            if j!=0:
                count += 1
        
        while i<len(nums):
            if nums[i]==0:
                nums.pop(i)
                nums.append(0)
            else:
                i += 1
                
            if i==count:
                break
            
