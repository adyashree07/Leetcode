# https://leetcode.com/problems/prime-number-of-set-bits-in-binary-representation/

# Given two integers left and right, return the count of numbers in the inclusive range [left, right] having a prime number of set bits in their binary representation.
# Recall that the number of set bits an integer has is the number of 1's present when written in binary.
# 1. For example, 21 written in binary is 10101, which has 3 set bits.

# My Solution
class Solution:
    def countSetBit(self, A):
        count = 0
        while A>0:
            A &= (A-1)
            count += 1
        return count
    
    def isPrime(self, A):
        if A==1:
            return False
        for i in range(2,int((A)**0.5)+1):
            if A%i==0:
                return False
        return True
    
    def countPrimeSetBits(self, left: int, right: int) -> int:
        count = 0 
        for i in range(left,right+1):
            if self.isPrime(self.countSetBit(i)):
                count += 1
        
        return count
        
        
# Alternate Solution
class Solution:
    def countPrimeSetBits(self, left: int, right: int) -> int:
        primes = {2,3,5,7,11,13,17,19,23,29}
        
        def countByDigit(length, offset):
            count = 0
            for p in primes:
                i = p - offset
                if i < 0:
                    continue
                elif i <= length:
                    count += factorial(length) // factorial(i) // factorial(length - i)
            return count

        def countPrimeBit(b_str, offset=0):
            if b_str == "0":
                if offset in primes:
                    return 1
                return 0
            elif b_str == "1":
                count = 0
                if offset in primes:
                    count += 1
                if offset + 1 in primes:
                    count += 1
                return count

            b_str_new = str(int(b_str[1:]))
            
            return countByDigit(len(b_str)-1, offset) + countPrimeBit(b_str_new, offset+1)
                    
        return countPrimeBit(bin(right)[2:]) - countPrimeBit(bin(left - 1)[2:])
      
      
