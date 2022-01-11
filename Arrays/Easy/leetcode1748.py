# https://leetcode.com/problems/sum-of-unique-elements/
  
# You are given an integer array nums. The unique elements of an array are the elements that appear exactly once in the array.
# Return the sum of all the unique elements of nums.

#My Solution
class Solution:
    def sumOfUnique(self, nums: List[int]) -> int:
        n = len(nums)
        
        ele = dict()
        for i in range(n):
            if nums[i] not in ele:
                ele[nums[i]] =1
            else:
                ele[nums[i]] +=1
        
        sum = 0
        for k,v in ele.items():
            if v==1:
                sum+=k
        
        return sum
        
       
#Optimal Solution
class Solution:
    def sumOfUnique(self, nums: List[int]) -> int:
        c=0
        for i in nums:
            if nums.count(i)==1:
                c+=i
        return c
