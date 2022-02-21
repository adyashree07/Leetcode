# https://leetcode.com/problems/xor-operation-in-an-array/

# You are given an integer n and an integer start.
# Define an array nums where nums[i] = start + 2 * i (0-indexed) and n == nums.length.
# Return the bitwise XOR of all elements of nums.

# My Solution
class Solution:
    def xorOperation(self, n: int, start: int) -> int:
        ans = 0
        
        for i in range(n):
            ans = ans ^ (start+(2*i))
            
        return ans
      
      
# Optimal Solution
class Solution:
    def xorOperation(self, n: int, start: int) -> int:
        if n==1:
            return start
        last = start + (n-1) * 2
        if start % 4 <= 1:
            if n % 4 == 0:
                return 0
            elif n % 4 == 1:
                return last
            elif n % 4 == 2:
                return 2
            else:
                return last ^ 2
        else:
            if (n-1) % 4 == 0:
                return start
            elif (n-1) % 4 == 1:
                return start ^ last
            elif (n-1) % 4 == 2:
                return start ^ 2
            else:
                return last ^ 2 ^ start
              
              
