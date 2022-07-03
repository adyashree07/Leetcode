# https://leetcode.com/problems/minimum-bit-flips-to-convert-number/

# A bit flip of a number x is choosing a bit in the binary representation of x and flipping it from either 0 to 1 or 1 to 0.

# For example, for x = 7, the binary representation is 111 and we may choose any bit (including any leading zeros not shown) and flip it. We can flip the first bit from the right to get 110, flip the second bit from the right to get 101, flip the fifth bit from the right (a leading zero) to get 10111, etc.
# Given two integers start and goal, return the minimum number of bit flips to convert start to goal.

# My Solution
class Solution:
    def minBitFlips(self, start: int, goal: int) -> int:
        xor = start ^ goal
        count = 0
        
        while xor>0:
            xor = xor & (xor-1)
            count += 1
            
        return count
      

# Alternate Solution
class Solution:
    def minBitFlips(self, start: int, goal: int) -> int:
        diff=start^goal
        
        ct=0
        while diff:
            if diff&1:
                ct+=1
            diff>>=1
        return ct
      
      
