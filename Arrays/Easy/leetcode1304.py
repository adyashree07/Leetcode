# https://leetcode.com/problems/find-n-unique-integers-sum-up-to-zero/

# Given an integer n, return any array containing n unique integers such that they add up to 0.

# My Solution
class Solution:
    def sumZero(self, n: int) -> List[int]:
        ans = []
        
        if n%2:
            for i in range(1,(n//2)+1):
                ans.append(-i)
                ans.append(i)
                
            ans.append(0)
            return ans
        else:
            for i in range(1,(n//2)+1):
                ans.append(-i)
                ans.append(i)
                
            return ans
            
            
# Optimal Solution
class Solution:
    def sumZero(self, n: int) -> List[int]:
        return [x for x in range(1, n)] + [int((1 - n) * n * 0.5)]
      
      
