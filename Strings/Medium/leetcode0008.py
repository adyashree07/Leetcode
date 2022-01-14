#https://leetcode.com/problems/string-to-integer-atoi/

# Implement the myAtoi(string s) function, which converts a string to a 32-bit signed integer (similar to C/C++'s atoi function).
# The algorithm for myAtoi(string s) is as follows:
# 1. Read in and ignore any leading whitespace.
# 2. Check if the next character (if not already at the end of the string) is '-' or '+'. Read this character in if it is either. This determines if the final result is negative or positive respectively. Assume the result is positive if neither is present.
# 3. Read in next the characters until the next non-digit character or the end of the input is reached. The rest of the string is ignored.
# 4. Convert these digits into an integer (i.e. "123" -> 123, "0032" -> 32). If no digits were read, then the integer is 0. Change the sign as necessary (from step 2).
# 5. If the integer is out of the 32-bit signed integer range [-231, 231 - 1], then clamp the integer so that it remains in the range. Specifically, integers less than -231 should be clamped to -231, and integers greater than 231 - 1 should be clamped to 231 - 1.
# 6. Return the integer as the final result.

#My Solution
class Solution:
    def myAtoi(self, s: str) -> int:
        s = s.lstrip(" ")
        n = len(s)
        
        sign = ["+","-"]
        num = [48,49,50,51,52,53,54,55,56,57]   
        
        if len(s)==0:
            return 0
        
        if (s[0] in sign) and (len(s)==1):
            return 0
        elif (s[0] in sign) and (ord(s[1]) not in num):
            return 0
        elif (s[0] not in sign) and (ord(s[0]) not in num):
            return 0
        else:
            ans = s[0]
        

        for i in range(1,n):
            if (ord(s[i]) in num):
                ans = ans+s[i]
            else:
                break

        print(ans)  

        res = int(ans)

        if res < -2147483648:
            return -2147483648
        elif res > 2147483647:
            return 2147483647
        else:
            return res
        
        
#Optimal Solution
class Solution:
    def myAtoi(self, s: str) -> int:
        
        str=s.strip()
        if len(str)==0:
            
            return 0
        
        tmp='0'
        result=0
        
        i=0
        if str[0] in "+-":
            tmp=str[0]
            i=1
            
        MAX_INT=2147483647
        MIN_INT=-2147483648
        
        for i in range(i, len(str)):
            if str[i].isdigit():
                tmp+=str[i]   
            else:
                break
                
        if len(tmp)>1:
                result=int(tmp)
                
        if result>MAX_INT>0:
            return MAX_INT
            
        elif result<MIN_INT<0:
            return MIN_INT
        else:
            return result

        
