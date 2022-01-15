# https://leetcode.com/problems/sort-array-by-parity-ii/

# Given an array of integers nums, half of the integers in nums are odd, and the other half are even.
# Sort the array so that whenever nums[i] is odd, i is odd, and whenever nums[i] is even, i is even.
# Return any answer array that satisfies this condition.

# My Solution
class Solution:
    def sortArrayByParityII(self, nums: List[int]) -> List[int]:
        n = len(nums)
        
        odd = []
        even = []
        
        for i in range(n):
            if nums[i]%2==0:
                even.append(nums[i])
            else:
                odd.append(nums[i])
        
        even_point = 0
        odd_point = 0
        for i in range(n):
            if i%2:
                nums[i] = odd[odd_point]
                odd_point +=1
            else:
                nums[i] = even[even_point]
                even_point += 1
                
        return nums
        
        
# Optimal Solution
class Solution:
    def sortArrayByParityII(self, nums: List[int]) -> List[int]:
        even = 0
        odd = 1
        arr = [None]*len(nums)
        for i in nums:
            if i%2==0:
                arr[even] = i
                even += 2
            else:
                arr[odd] = i
                odd += 2
        return arr
      
      
