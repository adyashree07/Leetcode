#https://leetcode.com/problems/build-array-from-permutation/

#Given a zero-based permutation nums (0-indexed), build an array ans of the same length where ans[i] = nums[nums[i]] for each 0 <= i < nums.length and return it.
#A zero-based permutation nums is an array of distinct integers from 0 to nums.length - 1 (inclusive).

#My Solution
class Solution:
    def buildArray(self, nums: List[int]) -> List[int]:
        ans = list()
        for i in range(len(nums)):
            ans.append(nums[nums[i]])
            
        return ans

#Optimal Solution
class Solution:
    def buildArray(self, nums: List[int]) -> List[int]:
        lst = [nums[i] for i in nums]

        return lst
