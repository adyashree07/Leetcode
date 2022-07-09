# https://leetcode.com/problems/minimum-flips-to-make-a-or-b-equal-to-c/

# Given 3 positives numbers a, b and c. Return the minimum flips required in some bits of a and b to make ( a OR b == c ). (bitwise OR operation).
# Flip operation consists of change any single bit 1 to 0 or change the bit 0 to 1 in their binary representation.

# My Solution
class Solution:
    def minFlips(self, a: int, b: int, c: int) -> int:
        res_or = a | b
        no = max(int(math.log(res_or,2))+1, int(math.log(c,2))+1)
        
        
        res_xor = res_or ^ c
        
        pos = 0
        ans = 0
        
        while no>0:
            if res_xor & (2**pos):
                if c & (2**pos)!=0:
                    ans += 1
                else:
                    if (a & (2**pos)) & (b & (2**pos)) ==0:
                        ans += 1
                    else:
                        ans += 2       
                
            pos += 1
            no -= 1
            
        return ans
            
        
# Alternate Solution
class Solution:
    def minFlips(self, a: int, b: int, c: int) -> int:
        res = 0
        for i in range(33):
            if c & 1 == 0:
                if ((a & 1 == 1 and b & 1 == 0)
                    or (a & 1 == 0 and b & 1 == 1)):
                    res += 1
                elif a & 1 == 1 and b & 1 == 1:
                    res += 2
            elif c & 1:
                if a & 1 == 0 and b & 1 == 0:
                    res += 1
                    
            a = a >> 1
            b = b >> 1
            c = c >> 1
        return res
      
      
