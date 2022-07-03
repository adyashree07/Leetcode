# https://leetcode.com/problems/count-operations-to-obtain-zero/

# You are given two non-negative integers num1 and num2.
# 1. In one operation, if num1 >= num2, you must subtract num2 from num1, otherwise subtract num1 from num2.

# For example, if num1 = 5 and num2 = 4, subtract num2 from num1, thus obtaining num1 = 1 and num2 = 4. However, if num1 = 4 and num2 = 5, after one operation, num1 = 4 and num2 = 1.
# Return the number of operations required to make either num1 = 0 or num2 = 0.

# My Solution
class Solution:
    def countOperations(self, num1: int, num2: int) -> int:
        count = 0
        
        while num1 and num2:
            if num1>num2:
                num1 -= num2
            else:
                num2 -= num1
            count += 1
            
        return count
      
      
# Optimal Solution
def countOperations(self, num1: int, num2: int) -> int:
        cnt = 0
        while min(num1, num2) > 0:
            if num1 < num2:
                num1, num2 = num2, num1
            ops, num1 = divmod(num1, num2)    
            cnt += ops
        return cnt
      
      
