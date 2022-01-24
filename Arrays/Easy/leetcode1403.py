# https://leetcode.com/problems/minimum-subsequence-in-non-increasing-order/

# Given the array nums, obtain a subsequence of the array whose sum of elements is strictly greater than the sum of the non included elements in such subsequence. 
# If there are multiple solutions, return the subsequence with minimum size and if there still exist multiple solutions, return the subsequence with the maximum total sum of all its elements. A subsequence of an array can be obtained by erasing some (possibly zero) elements from the array. 
# Note that the solution with the given constraints is guaranteed to be unique. Also return the answer sorted in non-increasing order.

# My Solution
class Solution:
    def minSubsequence(self, nums: List[int]) -> List[int]:
        nums.sort(reverse = True)
        n = len(nums)
        ans = [nums[0]]
        res = nums[0]
        total = 0
        
        for i in range(1,n):
            total += nums[i]
            
        for i in range(1,n):
            if res> total:
                break
            else:
                res += nums[i]
                total -= nums[i]
                ans.append(nums[i])
                
        return ans
                
            
# Optimal Solution
class Solution:
    def minSubsequence(self, nums):
        nums.sort(reverse=True)
        sum_n=sum(nums)
        l=len(nums)
        total=0
        ans=[]
        for i in nums:
            total+=i
            ans.append(i)
            if (sum_n-total)<total:
                break
        return ans
      
      
