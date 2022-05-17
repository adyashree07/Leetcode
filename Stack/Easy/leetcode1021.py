# https://leetcode.com/problems/remove-outermost-parentheses/

# A valid parentheses string is either empty "", "(" + A + ")", or A + B, where A and B are valid parentheses strings, and + represents string concatenation.
# For example, "", "()", "(())()", and "(()(()))" are all valid parentheses strings.
# A valid parentheses string s is primitive if it is nonempty, and there does not exist a way to split it into s = A + B, with A and B nonempty valid parentheses strings.
# Given a valid parentheses string s, consider its primitive decomposition: s = P1 + P2 + ... + Pk, where Pi are primitive valid parentheses strings.
# Return s after removing the outermost parentheses of every primitive string in the primitive decomposition of s.

# My Solution
class Solution:
    def removeOuterParentheses(self, s: str) -> str:
        stack =[]
        ans = ""
        res = ""
        
        for i in s:
            if i=='(':
                stack.append(i)
                ans += i
            elif i==')':
                stack.pop()
                ans += i
                
            if len(stack)==0:
                res += ans[1:len(ans)-1]
                ans = ""
                
        return res
      
      
# Alternate Solution
class Solution:
    def removeOuterParentheses(self, s: str) -> str:
        stack = []
        cnt = 0
        for i in s:
            if i == '(':
                if cnt:
                    stack.append(i)
                cnt += 1
            else:
                cnt-=1
                if cnt:
                    stack.append(i)
        return ''.join(stack)

      
