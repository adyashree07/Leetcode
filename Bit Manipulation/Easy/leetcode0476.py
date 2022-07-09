# https://leetcode.com/problems/number-complement/

# The complement of an integer is the integer you get when you flip all the 0's to 1's and all the 1's to 0's in its binary representation.
# 1. For example, The integer 5 is "101" in binary and its complement is "010" which is the integer 2.
# Given an integer num, return its complement.

# My Solution
import math
class Solution:
    def findComplement(self, num: int) -> int:
        no = int(math.log(num,2))+1
        
        ans = num ^ ((2**no)-1)
        
        return ans
      
      
# Alternate Solution
class Solution:
    def findComplement(self, num: int) -> int:
        
        step = num
        mask = 1
        while step > 0:
            num = num ^ mask
            mask <<= 1
            step >>= 1
            
        return num
      
      
