# https://leetcode.com/problems/build-an-array-with-stack-operations/

# You are given an array target and an integer n.
# In each iteration, you will read a number from list = [1, 2, 3, ..., n].
# Build the target array using the following operations:
# 1. "Push": Reads a new element from the beginning list, and pushes it in the array.
# 2. "Pop": Deletes the last element of the array.
# 3. If the target array is already built, stop reading more elements.
# Return a list of the operations needed to build target. The test cases are generated so that the answer is unique.

# My Solution
class Solution:
    def buildArray(self, target: List[int], n: int) -> List[str]:
        m = len(target)
        ans = []
        j = 0
        
        for i in range(1,n+1):
            if i<=target[m-1]:
                if i==target[j]:
                    ans.append("Push")
                    j += 1
                else:
                    ans.append("Push")
                    ans.append("Pop")
            else:
                break
                
        return ans
                
        
# Optimal Solution
class Solution:
    def buildArray(self, target: List[int], n: int) -> List[str]:
        output=[]
        for i in range(1,n+1):
            if i>target[-1]:
                break
            output.append("Push")
            if i not in target:
                output.append("Pop")
        return output
      
      
