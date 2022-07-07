# https://leetcode.com/problems/single-number-iii/

# Given an integer array nums, in which exactly two elements appear only once and all the other elements appear exactly twice. Find the two elements that appear only once. You can return the answer in any order.
# You must write an algorithm that runs in linear runtime complexity and uses only constant extra space.

# My Solution
class Solution:
    def singleNumber(self, nums: List[int]) -> List[int]:
        xor = 0
        
        for i in nums:
            xor ^= i
            
        x = 0
        y = 0
        pos = 0
        
        while (xor & (2**pos))==0:
            pos += 1
         
        for i in nums:
            if (i&(2**pos))>0:
                x ^= i
            else:
                y ^= i
                
        return [x,y]
      
      
# Alternate Solution
class Solution:
    def singleNumber(self, nums: List[int]) -> List[int]:
        xor = 0
        
        for i in nums:
            xor ^= i
            
        x = 0
        y = 0
        
        xor = xor & (xor - 1) ^ xor
        
        for i in nums:
            if xor & i:
                x ^= i
            else:
                y ^= i
              
        return [x,y]
      
      
