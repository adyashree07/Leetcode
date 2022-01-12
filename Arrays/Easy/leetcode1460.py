# https://leetcode.com/problems/make-two-arrays-equal-by-reversing-sub-arrays/
  
# You are given two integer arrays of equal length target and arr. In one step, you can select any non-empty sub-array of arr and reverse it. You are allowed to make any number of steps.
# Return true if you can make arr equal to target or false otherwise.

# My Solution
class Solution:
    def canBeEqual(self, target: List[int], arr: List[int]) -> bool:
        arr.sort()
        target.sort()
        
        return target==arr
        
        
# Optimal Solution
from collections import Counter
class Solution:
    def canBeEqual(self, target: List[int], arr: List[int]) -> bool:
        return Counter(target)==Counter(arr)
      
      
