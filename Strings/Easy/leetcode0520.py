# https://leetcode.com/problems/detect-capital/submissions/

# We define the usage of capitals in a word to be right when one of the following cases holds:
# 1. All letters in this word are capitals, like "USA".
# 2. All letters in this word are not capitals, like "leetcode".
# 3. Only the first letter in this word is capital, like "Google".
# Given a string word, return true if the usage of capitals in it is right.

# My Solution
class Solution:
    def detectCapitalUse(self, word: str) -> bool:
        n = len(word)
        
        if ord(word[0])>=65 and ord(word[0])<=90:
            for i in range(2,n):
                if ord(word[i])>=97 and ord(word[i])<=122 and ord(word[i-1])>=65 and ord(word[i-1])<=90:
                    return False
                elif ord(word[i-1])>=97 and ord(word[i-1])<=122 and ord(word[i])>=65 and ord(word[i])<=90:
                    return False
                else:
                    continue
            return True
        else:
            for i in range(1,n):
                if ord(word[i])>=65 and ord(word[i])<=90:
                        return False
                else:
                    continue
            return True
            
            
# Optimal Solution
class Solution:
    def detectCapitalUse(self, word: str) -> bool:
        # if all capital letters
        if word.upper() == word:
            return True
        # if all lowercase
        elif word.lower() == word:
            return True
        #if first cap and rest lowercase
        elif word[0].upper() == word[0] and word[1:].lower() ==            word[1:]:
            return True
        else:
            return False
          
          
