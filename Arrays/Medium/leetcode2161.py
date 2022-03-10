# https://leetcode.com/problems/partition-array-according-to-given-pivot/

# You are given a 0-indexed integer array nums and an integer pivot. Rearrange nums such that the following conditions are satisfied:
# 1. Every element less than pivot appears before every element greater than pivot.
# 2. Every element equal to pivot appears in between the elements less than and greater than pivot.
# 3. The relative order of the elements less than pivot and the elements greater than pivot is maintained.
#    i. More formally, consider every pi, pj where pi is the new position of the ith element and pj is the new position of the jth element. For elements less than pivot, if i < j and nums[i] < pivot and nums[j] < pivot, then pi < pj. Similarly for elements greater than pivot, if i < j and nums[i] > pivot and nums[j] > pivot, then pi < pj.
# Return nums after the rearrangement.

# My Solution
class Solution:
    def pivotArray(self, nums: List[int], pivot: int) -> List[int]:
        left = []
        right = []
        
        for i in nums:
            if i<pivot:
                left.append(i)
            elif i>pivot:
                right.append(i)
                
        return left+[pivot]*nums.count(pivot)+right
      
      
