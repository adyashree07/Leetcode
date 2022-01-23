# https://leetcode.com/problems/shortest-distance-to-a-character/

# Given a string s and a character c that occurs in s, return an array of integers answer where answer.length == s.length and answer[i] is the distance from index i to the closest occurrence of character c in s.
# The distance between two indices i and j is abs(i - j), where abs is the absolute value function.

# My Solution
class Solution:
    def shortestToChar(self, s: str, c: str) -> List[int]:
        n = len(s)
        ans = [0]*n
        index = []
        curr_index = s.find(c)
        for i in range(n):
            if s[i]==c:
                ans[i]=0
                index.append(i)
    
        j = 0
        m = len(index)
        for i in range(n):
            if j==0:
                ans[i] = abs(i-index[j])
            if j!=m-1 and i==index[j]:
                j+=1
            else:
                ans[i] = min(abs(i-index[j-1]),abs(i-index[j]))
                
        return ans
                
            
# Optimal Solution
class Solution:
    def shortestToChar(self, s: str, c: str) -> List[int]:
        prev = float('-inf')
        ans = []
        for i, x in enumerate(s):
                if x == c:
                    prev = i
                ans.append(i - prev)

        prev = float('inf')
        
        for i in range(len(s) - 1, -1, -1):
                if s[i] == c:
                    prev = i
                ans[i] = min(ans[i], prev - i)

        return ans 
      
      
