# https://leetcode.com/problems/contains-duplicate/

# Given an integer array nums, return true if any value appears at least twice in the array, and return false if every element is distinct.

# My Solution
class Solution:
    def containsDuplicate(self, nums: List[int]) -> bool:
        freq = collections.Counter(nums)
        
        for k,v in freq.items():
            if v>=2:
                return True
            
        return False
        
        
