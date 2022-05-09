# https://leetcode.com/problems/valid-parentheses/

# Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.
# An input string is valid if:
# 1. Open brackets must be closed by the same type of brackets.
# 2. Open brackets must be closed in the correct order.


# My Solution
class Solution:
    def isValid(self, s: str) -> bool:
        parenthesis = {"(":")", "[":"]", "{":"}"}
        stack = []
        
        for i in s:
            if i in parenthesis:
                stack.append(i)
                continue
                
            if stack and i == parenthesis[stack[-1]]:
                stack.pop()
            else:
                return False
          
        if len(stack)==0:
            return True
        
        return False
        
        
# Another Solution
ass Solution:
    def isValid(self, s: str) -> bool:
        stack = []
        for bracket in s:
            match bracket:
                case '(' | '{' | '[':
                    stack.append(bracket)
                case ')':
                    if len(stack) == 0:
                        return False
                    letter = stack.pop()
                    if letter != '(':
                        return False
                case '}':
                    if len(stack) == 0:
                        return False
                    letter = stack.pop()
                    if letter != '{':
                        return False
                case ']':
                    if len(stack) == 0:
                        return False
                    letter = stack.pop()
                    if letter != '[':
                        return False
        return len(stack) == 0
                    
            
