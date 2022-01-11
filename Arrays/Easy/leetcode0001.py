#https://leetcode.com/problems/two-sum/

# Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.
# You may assume that each input would have exactly one solution, and you may not use the same element twice.
# You can return the answer in any order.

#My Solution
class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:    
        sort_num = sorted(((v,i) for i,v in enumerate(nums)),reverse=False)
     
        for i in range(len(sort_num)-1):
            num = target - sort_num[i][0]
            
            low = i+1
            high = len(nums)-1
            mid = int((low+high)/2)
            
            while low<=high:
                if num==sort_num[mid][0]:
                    end = sort_num[mid][1]
                    start = sort_num[i][1]
                    break
                elif num>sort_num[mid][0]:
                    low = mid+1
                elif num<sort_num[mid][0]:
                    high = mid-1
                    
                mid = int((low+high)/2)
    
        return [start,end]
   

#Optimal Solution
class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        # for i in range(len(nums)):
        #     ref = nums[i]
        #     for j in range(i+1, len(nums)):
        #         if ref + nums[j] == target:
        #             return [i, j]
        
        prevMap = {}
        
        for i, n in enumerate(nums):
            diff = target - n
            if diff in prevMap:
                return [prevMap[diff], i]
            prevMap[n] = i
        return 
