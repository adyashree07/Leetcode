# https://leetcode.com/problems/summary-ranges/

# You are given a sorted unique integer array nums.
# Return the smallest sorted list of ranges that cover all the numbers in the array exactly. That is, each element of nums is covered by exactly one of the ranges, and there is no integer x such that x is in one of the ranges but not in nums.
# Each range [a,b] in the list should be output as:
# 1. "a->b" if a != b
# 2. "a" if a == b

# My Solution
class Solution:
    def summaryRanges(self, nums: List[int]) -> List[str]:
        n = len(nums)
        ans1 = []
        ans2 = []
        S = ""
        
        for i in range(n):
            if i!=(n-1) and nums[i]==nums[i+1]-1:
                if i==0 or nums[i] != nums[i-1]+1:
                    S=str(nums[i])+"->"
                    ans1.append(S)
            else:
                S = str(nums[i])
                ans2.append(S)
            
        
        i = 0
        j = 0
        res = []
        while i<len(ans1) and j<len(ans2):
            if i==0 and j==0 and int(ans2[j])<int(ans1[i][:ans1[i].find("->")]):
                res.append(ans2[j])
                j += 1
            if int(ans1[i][:ans1[i].find("->")])<int(ans2[j]):
                res.append(ans1[i]+ans2[j])
                i += 1
                j += 1
            else:
                res.append(ans2[j])
                j += 1
        
        while j<len(ans2):
            res.append(ans2[j])
            j += 1
            
        return res
                
        
# Alternate Solution
class Solution:
  def summaryRanges(self, nums: List[int]) -> List[str]:
    if len(nums) == 0: return nums
    
    left = right = nums[0]
    res = []
    for i in range(1, len(nums)):
      num = nums[i]
      if num - 1 == right:
        right = num
      
      elif num - 1 != right:
        if left != right:
          res.append(str(left)+"->"+str(right))
        else:
          res.append(str(left))
        
        left = right = num
    
    if left != right:
      res.append(str(left)+"->"+str(right))
    else:
      res.append(str(left))
    return res
  
  
