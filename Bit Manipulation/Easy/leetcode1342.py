# https://leetcode.com/problems/number-of-steps-to-reduce-a-number-to-zero/

# Given an integer num, return the number of steps to reduce it to zero.
# In one step, if the current number is even, you have to divide it by 2, otherwise, you have to subtract 1 from it.

# My Solution
class Solution:
    def numberOfSteps(self, num: int) -> int:
        count = 0
        
        while num>0:
            if num%2==0:
                num = num//2
            else:
                num -= 1
            count += 1
            
        return count
                

# Optimal Solution
class Solution:
    def numberOfSteps (self, num: int) -> int: 
        steps = 0
        binary = bin(num)[2:]

        for bit in binary:
            if bit == "1": 
                steps = steps + 2 
            else: # bit == "0"
                steps = steps + 1 

        return steps - 1
    
    
# Optimal Solution-2 
class Solution:
    def numberOfSteps (self, num: int) -> int:
        if num == 0: return 0

        steps = 0
        power_of_two = 1

        while power_of_two <= num:
            if (power_of_two & num) != 0:
                steps = steps + 2
            else:
                steps = steps + 1
            power_of_two = power_of_two * 2

        return steps - 1
    
    
