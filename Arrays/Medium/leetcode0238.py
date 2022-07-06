# https://leetcode.com/problems/product-of-array-except-self/

# Given an integer array nums, return an array answer such that answer[i] is equal to the product of all the elements of nums except nums[i].
# The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.
# You must write an algorithm that runs in O(n) time and without using the division operation.

# My Solution
class Solution:
    def productExceptSelf(self, nums: List[int]) -> List[int]: 
        n = len(nums)
        sufix = [0]*n
        sufix[n-1] = nums[n-1]
        
        for i in range(n-2,-1,-1):
            sufix[i] = sufix[i+1]*nums[i]
            
        prod = 1
            
        for i in range(n-1):
            sufix[i] = sufix[i+1]*prod
            prod = prod*nums[i]
            
        sufix[n-1] = prod
        
        return sufix
            
        
# Alternate Solution
class Solution:
    def productExceptSelf(self, nums: List[int]) -> List[int]:
        n = len(nums)
        res = [1 for i in range(n)]
        
        left,right = nums[0],nums[n-1]
        
        for i in range(1,n):
            res[i] *= left
            left *= nums[i]
            
        for i in range(n-2,-1,-1):
            res[i] *= right
            right *= nums[i]
            
        return res
      
      
