# https://leetcode.com/problems/divide-array-into-equal-pairs/

# You are given an integer array nums consisting of 2 * n integers.
# You need to divide nums into n pairs such that:
# 1. Each element belongs to exactly one pair.
# 2. The elements present in a pair are equal.
# Return true if nums can be divided into n pairs, otherwise return false.

# My Solution
class Solution:
    def divideArray(self, nums: List[int]) -> bool:
        freq = collections.Counter(nums)
        
        for k,v in freq.items():
            if v%2:
                return False
        
        return True
      
      
# Alternate Solution
class Solution:
    def divideArray(self, nums: List[int]) -> bool:
        a = set()
        
        for x in nums:
            if x not in a:
                a.add(x)
            
            else:
                a.remove(x)
                
        return len(a) == 0
      
      
