# https://leetcode.com/problems/count-the-number-of-consistent-strings/

# You are given a string allowed consisting of distinct characters and an array of strings words. A string is consistent if all characters in the string appear in the string allowed.
# Return the number of consistent strings in the array words.

# My Solution
class Solution:
    def countConsistentStrings(self, allowed: str, words: List[str]) -> int:
        allow = collections.Counter(allowed)
        ans = 0
        
        for i in words:
            count = 0
            for j in set(i):
                if j in allow:
                    count += 1
                
                if count == len(set(i)):
                    ans += 1
                    
        return ans
        

# My Solution-2
class Solution:
    def countConsistentStrings(self, allowed: str, words: List[str]) -> int:
        cnt = 0
        for i in range(len(words)):
            character = list(set(words[i]))
            
            if all(allowed.find(x)!=-1 for x in character):
                cnt+=1
                
        return cnt
                

# Optimal Solution
class Solution:
    def countConsistentStrings(self, allowed: str, words: List[str]) -> int:
        allowed = set(allowed)
        count = 0
        
        for word in words:
            for letter in word:
                if letter not in allowed:
                    count += 1
                    break
        
        return len(words) - count
      
      
