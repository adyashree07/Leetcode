# https://leetcode.com/problems/minimum-absolute-difference/

# Given an array of distinct integers arr, find all pairs of elements with the minimum absolute difference of any two elements.
# Return a list of pairs in ascending order(with respect to pairs), each pair [a, b] follows
# 1. a, b are from arr
# 2. a < b
# 3. b - a equals to the minimum absolute difference of any two elements in arr

# My Solution
class Solution:
    def minimumAbsDifference(self, arr: List[int]) -> List[List[int]]:
        arr.sort()
        n = len(arr)
        
        min_diff = arr[n-1]-arr[0]
        
        for i in range(1,n):
            if arr[i] - arr[i-1] < min_diff:
                min_diff = (arr[i]- arr[i-1])
        
        ans = []
        for i in range(1,n):
            if arr[i] - arr[i-1] == min_diff:
                ans.append([arr[i-1],arr[i]])
                
        return ans
      
     
# Optimal Solution
class Solution:
    def minimumAbsDifference(self, arr: List[int]) -> List[List[int]]:
        arr.sort()
        ans = [[arr[0], arr[1]]]
        m = arr[1] - arr[0]
        for i in range(1, len(arr) - 1):
            if arr[i+1] - arr[i] > m:
                continue
            elif arr[i+1] - arr[i] < m:
                ans, m = [], arr[i+1] - arr[i]
            ans.append([arr[i], arr[i+1]])
        return ans
      
      
