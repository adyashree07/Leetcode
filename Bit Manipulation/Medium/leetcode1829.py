# https://leetcode.com/problems/maximum-xor-for-each-query/

# You are given a sorted array nums of n non-negative integers and an integer maximumBit. You want to perform the following query n times:
# 1. Find a non-negative integer k < 2^maximumBit such that nums[0] XOR nums[1] XOR ... XOR nums[nums.length-1] XOR k is maximized. k is the answer to the ith query.
# 2. Remove the last element from the current array nums.
# Return an array answer, where answer[i] is the answer to the ith query.

# My Solution
class Solution:
    def getMaximumXor(self, nums: List[int], maximumBit: int) -> List[int]:
        max_limit = (2**maximumBit)-1
        prefix_xor = [0]*(len(nums))
        prefix_xor[0] = nums[0]
        
        for i in range(1,len(nums)):
            prefix_xor[i] = prefix_xor[i-1]^nums[i]
            
        ans = []
        
        for i in range(len(nums)-1,-1,-1):
            ans.append(max_limit^(prefix_xor[i]))
            
        return ans
    
    
# Alternate Solution
class Solution:
    def getMaximumXor(self, nums: List[int], maximumBit: int) -> List[int]:        
        return list(accumulate([nums[0] ^ (1 << maximumBit) - 1] + nums[1:], ixor))[::-1]
    
    
