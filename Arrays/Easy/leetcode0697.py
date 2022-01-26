# https://leetcode.com/problems/degree-of-an-array/

# Given a non-empty array of non-negative integers nums, the degree of this array is defined as the maximum frequency of any one of its elements.
# Your task is to find the smallest possible length of a (contiguous) subarray of nums, that has the same degree as nums.

# My Solution
class Solution:
    def findShortestSubArray(self, nums: List[int]) -> int:
        n = len(nums)
        freq = collections.Counter(nums)
        
        max_freq = max(freq.values())
        max_freq_ele = []
        
        for k,v in freq.items():
            if v==max_freq:
                max_freq_ele.append(k)
     
        res = n
        for j in max_freq_ele:
            initial = n
            final = 0
            for i in range(n):
                if j==nums[i]:
                    initial = min(initial,i)
                    final = max(final,i)
                    ans = final-initial+1
            res = min(res,ans)
                
        return res
        
        
# Optimal Solution
class Solution:
    def findShortestSubArray(self, nums):
        freq = collections.Counter(nums)
        degree = max(freq.values())
        
        if degree == 1:
            return 1
        candidates = [num for num in freq if freq[num] == degree]
        minlen = float("inf")
        for candidate in candidates:
            left = nums.index(candidate)
            right = len(nums) - nums[::-1].index(candidate)
            minlen = min(minlen,right -left +1)
        return minlen-1

      
