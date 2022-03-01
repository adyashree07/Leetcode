# https://leetcode.com/problems/counting-bits/

# Given an integer n, return an array ans of length n + 1 such that for each i (0 <= i <= n), ans[i] is the number of 1's in the binary representation of i.

# My Solution
class Solution:
    def set_bit(self, A):
        count = 0
        while A>0:
            A = A & A-1
            count += 1
        return count
    
    def countBits(self, n: int) -> List[int]:
        ans = []
        
        for i in range(n+1):
            ans.append(self.set_bit(i))
            
        return ans
        
        
# Optimized Solution
class Solution:
    def countBits(self, n: int) -> List[int]:
        ans = [0] * (n + 1)
        x = 0
        b = 1
        
        # [0, b) is calculated
        while b <= n:
            # generate [b, 2b) or [b, n) from [0, b)
            while x < b and x + b <= n:
                ans[x + b] = ans[x] + 1
                x += 1
            x = 0 # reset x
            b <<= 1 # b = 2b
            
        return ans               
      
      
