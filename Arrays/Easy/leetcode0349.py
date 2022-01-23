# https://leetcode.com/problems/intersection-of-two-arrays/

# Given two integer arrays nums1 and nums2, return an array of their intersection. Each element in the result must be unique and you may return the result in any order.

# My Solution
class Solution:
    def intersection(self, nums1: List[int], nums2: List[int]) -> List[int]:
        ans = list(set(nums1)-set(nums2))
        
        res = list(set(nums1)-set(ans))
        
        return res
        
        
# Optimal Solution
class Solution:
    def intersection(self, nums1: List[int], nums2: List[int]) -> List[int]:
        return set(nums1).intersection(set(nums2))
        
        
