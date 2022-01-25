# https://leetcode.com/problems/valid-mountain-array/

# Given an array of integers arr, return true if and only if it is a valid mountain array.
# Recall that arr is a mountain array if and only if:
# 1. arr.length >= 3
# 2. There exists some i with 0 < i < arr.length - 1 such that:
#    i. arr[0] < arr[1] < ... < arr[i - 1] < arr[i]
#    ii. arr[i] > arr[i + 1] > ... > arr[arr.length - 1]

# My Solution
class Solution:
    def validMountainArray(self, arr: List[int]) -> bool:
        n = len(arr)
        if n<3:
            return False
        
        increasing = 0
        decreasing = 0
    
        for i in range(1,n):
            if arr[i]==arr[i-1]:
                return False
            if i!=n-1 and arr[i]<arr[i-1] and arr[i]<arr[i+1]:
                return False
            elif arr[i-1]<arr[i]:
                increasing +=1
            else:
                decreasing += 1
                
        if increasing==n-1 or decreasing==n-1:
            return False
        
        return True
      
      
# Optimal Solution
class Solution(object):
    def validMountainArray(self, A):
        N = len(A)
        i = 0

        # walk up
        while i+1 < N and A[i] < A[i+1]:
            i += 1

        # peak can't be first or last
        if i == 0 or i == N-1:
            return False

        # walk down
        while i+1 < N and A[i] > A[i+1]:
            i += 1

        return i == N-1
      
      
                    
        
