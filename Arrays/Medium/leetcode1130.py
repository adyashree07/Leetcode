# https://leetcode.com/problems/sequential-digits/

# An integer has sequential digits if and only if each digit in the number is one more than the previous digit.
# Return a sorted list of all the integers in the range [low, high] inclusive that have sequential digits.

# My Solution
class Solution:
    def sequentialDigits(self, low: int, high: int) -> List[int]:
        ans = []
        
        s = "123456789"
        
        for i in range(8):
            string = ""
            for j in range(i,9):
                string = string+s[j]
                num = int(string)
                
                if num>=low and num<=high:
                    ans.append(num)
                    
        ans.sort()
        return ans
      
      
# Optimal Solution
class Solution:
    def sequentialDigits(self, low: int, high: int) -> List[int]:
        l = []
        def find(seed:int):
            next_ = seed % 10 + 1
            if next_ >= 10:
                return
            new = seed*10 + next_
            if new < low:
                find(new)
            elif new<=high:
                l.append(new)
                find(new)
        for i in range(1, 9):
            find(i)
        l.sort()
        return l
      
      
