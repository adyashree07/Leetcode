# https://leetcode.com/problems/longest-consecutive-sequence/

# Given an unsorted array of integers nums, return the length of the longest consecutive elements sequence.
# You must write an algorithm that runs in O(n) time.

# My Solution
class Solution:
    def longestConsecutive(self, nums: List[int]) -> int:
        nums = list(set(nums))
        nums.sort()
        
        if len(nums)==0:
            return 0
        
        curr_count = 1
        max_count = 1
        
        for i in range(1,len(nums)):
            if nums[i]==(nums[i-1]+1):
                curr_count += 1
            else:
                curr_count = 1         
            max_count = max(curr_count,max_count)
            
        return max_count
      
      
# Optimal Solution
class Solution:
    def longestConsecutive(self, nums):
        longest_streak = 0
        num_set = set(nums)

        for num in num_set:
            if num - 1 not in num_set:
                current_num = num
                current_streak = 1

                while current_num + 1 in num_set:
                    current_num += 1
                    current_streak += 1

                longest_streak = max(longest_streak, current_streak)

        return longest_streak
      
      
            
        
