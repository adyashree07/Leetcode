# https://leetcode.com/problems/maximum-nesting-depth-of-the-parentheses/

# A string is a valid parentheses string (denoted VPS) if it meets one of the following:
# 1. It is an empty string "", or a single character not equal to "(" or ")",
# 2. It can be written as AB (A concatenated with B), where A and B are VPS's, or
# 3. It can be written as (A), where A is a VPS.

# We can similarly define the nesting depth depth(S) of any VPS S as follows:
# 1. depth("") = 0
# 2. depth(C) = 0, where C is a string with a single character not equal to "(" or ")".
# 3. depth(A + B) = max(depth(A), depth(B)), where A and B are VPS's.
# 4. depth("(" + A + ")") = 1 + depth(A), where A is a VPS.

# For example, "", "()()", and "()(()())" are VPS's (with nesting depths 0, 1, and 2), and ")(" and "(()" are not VPS's.
# Given a VPS represented as string s, return the nesting depth of s.

# My Solution
class Solution:
    def maxDepth(self, s: str) -> int:
        curr_count = 0
        max_count = 0
        
        for i in s:
            if i=='(':
                curr_count +=1
            elif i==')':
                curr_count -=1
                
            max_count = max(curr_count,max_count)
            
        return max_count
   

# Alternate Solution
class Solution:
    def maxDepth(self, s: str) -> int:
        stack = []
        answer = 0
        for c in s:
            if c == '(':
                stack.append(c)
            elif c == ')':
                answer = max(answer, len(stack))
                stack.pop()
        return answer
    
    
