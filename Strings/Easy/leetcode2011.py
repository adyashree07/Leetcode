#https://leetcode.com/problems/final-value-of-variable-after-performing-operations/

# There is a programming language with only four operations and one variable X:
# 1. ++X and X++ increments the value of the variable X by 1.
# 2. --X and X-- decrements the value of the variable X by 1.
# Initially, the value of X is 0.
# Given an array of strings operations containing a list of operations, return the final value of X after performing all the operations.

#My Solution
class Solution:
    def finalValueAfterOperations(self, operations: List[str]) -> int:
        X = 0
        
        for i in range(len(operations)):
            if operations[i].find("++")!=-1:
                X+=1
            else:
                X-=1
        
        return X
 
        
#Optimal Solution
class Solution:
    def finalValueAfterOperations(self, operations: List[str]) -> int:
        ans = 0
        for op in operations:
            if '+' in op:
                ans += 1
            else:
                ans -= 1
        return ans
    
    
