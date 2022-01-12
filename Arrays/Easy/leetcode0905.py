# https://leetcode.com/problems/sort-array-by-parity/
  
# Given an integer array nums, move all the even integers at the beginning of the array followed by all the odd integers.
# Return any array that satisfies this condition.

# My Solution
class Solution:
    def sortArrayByParity(self, nums: List[int]) -> List[int]:
        n = len(nums)
        
        ans = []
        
        for i in range(n):
            if nums[i]%2==0:
                ans.append(nums[i])
        
        for i in range(n):
            if nums[i]%2:
                ans.append(nums[i])
                
        return ans
        
        
# Optimal Solution
class Solution:
    def sortArrayByParity(self, nums: List[int]) -> List[int]:
        return [
            number for number in nums if not number % 2
        ] + [
            number for number in nums if number % 2
        ]
      
      
