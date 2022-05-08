# https://leetcode.com/problems/number-of-1-bits/

# Write a function that takes an unsigned integer and returns the number of '1' bits it has (also known as the Hamming weight).

# My Solution
class Solution:
    def hammingWeight(self, n: int) -> int:
        count = 0
        
        while n>0:
            n = n & n-1
            count+= 1
        return count
            
