# https://leetcode.com/problems/can-make-arithmetic-progression-from-sequence/

# A sequence of numbers is called an arithmetic progression if the difference between any two consecutive elements is the same.
# Given an array of numbers arr, return true if the array can be rearranged to form an arithmetic progression. Otherwise, return false.

# My Solution
class Solution:
    def canMakeArithmeticProgression(self, arr: List[int]) -> bool:
        arr.sort()
        n = len(arr)
        
        for i in range(1,n-1):
            if (arr[i] - arr[i-1]) != (arr[i+1]-arr[i]):
                return False
            
        return True
        
        
# Optimal Solution
class Solution:
    def canMakeArithmeticProgression(self, arr: List[int]) -> bool:
        
        arr.sort()
        
        diff = arr[1] - arr[0] 
        for i in range(1, len(arr)-1): 
            if arr[i+1] - arr[i] != diff:
                return False 
        return True
      
      
