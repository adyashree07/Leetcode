# https://leetcode.com/problems/add-binary/

# Given two binary strings a and b, return their sum as a binary string.

# My Solution
class Solution:
    def addBinary(self, a: str, b: str) -> str:
        if len(a)<len(b):
            for i in range(len(a),len(b)):
                a = "0" + a
        else:
            for i in range(len(b),len(a)):
                b = "0" + b
                
        n = len(a)
                
        if int(a[n-1]) + int(b[n-1]) <= 1:
            carry = 0
            ans = str(int(a[n-1]) + int(b[n-1]))
        else:
            carry = 1
            ans = str((int(a[n-1]) + int(b[n-1]))%2)
         
        for i in range(n-2,-1,-1):
            if (int(a[i]) + int(b[i]) + carry) <= 1:
                ans = str(int(a[i]) + int(b[i]) + carry) + ans
                carry = 0
            else:
                ans = str((int(a[i]) + int(b[i]) + carry)%2) + ans
                carry = 1
                
                
        if carry==1:
            ans = "1"+ans
                               
        return ans
                
                      
# Optimal Solution
class Solution:
    def addBinary(self, a: str, b: str) -> str: 
        
        x = int(a, 2)
        y = int(b, 2)
        
        while y:
            value = x ^ y
            carry = (x & y) << 1
            
            x = value
            y = carry
        
        return bin(x)[2:]
      
      
