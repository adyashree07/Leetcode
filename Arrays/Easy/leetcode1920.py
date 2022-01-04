#https://leetcode.com/problems/build-array-from-permutation/

#My submitted solution
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
