# https://leetcode.com/problems/peak-index-in-a-mountain-array/

# Let's call an array arr a mountain if the following properties hold:
# 1. arr.length >= 3
# 2. There exists some i with 0 < i < arr.length - 1 such that:
#    i. arr[0] < arr[1] < ... arr[i-1] < arr[i]
#    ii. arr[i] > arr[i+1] > ... > arr[arr.length - 1]
# Given an integer array arr that is guaranteed to be a mountain, return any i such that arr[0] < arr[1] < ... arr[i - 1] < arr[i] > arr[i + 1] > ... > arr[arr.length - 1].

# My Solution
class Solution:
    def peakIndexInMountainArray(self, arr: List[int]) -> int:
        n = len(arr)
        
        for i in range(1,n-1):
            if arr[i]>arr[i-1] and arr[i]>arr[i+1]:
                return i
              
              
# Optimal Solution
class Solution:
    def peakIndexInMountainArray(self, arr: List[int]) -> int:
        l = -1
        r = len(arr)
        while l < r - 1:
            m = (l + r) >> 1
            if arr[m - 1] < arr[m] and arr[m] > arr[m + 1]:
                return m
            elif arr[m - 1] < arr[m]:
                l = m
            else:
                r = m
                
                
