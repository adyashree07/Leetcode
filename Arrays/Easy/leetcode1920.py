#https://leetcode.com/problems/build-array-from-permutation/

class Solution:
    def buildArray(self, nums: List[int]) -> List[int]:
        ans = list()
        for i in range(len(nums)):
            ans.append(nums[nums[i]])
            
        return ans
            
