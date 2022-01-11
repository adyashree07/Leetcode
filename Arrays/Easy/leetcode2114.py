#https://leetcode.com/problems/maximum-number-of-words-found-in-sentences/

# A sentence is a list of words that are separated by a single space with no leading or trailing spaces.
# You are given an array of strings sentences, where each sentences[i] represents a single sentence.
# Return the maximum number of words that appear in a single sentence.

#My Solution
class Solution:
    def mostWordsFound(self, sentences: List[str]) -> int:
        n = len(sentences)
        
        max_len = 0
        for i in range(n):
            words = sentences[i].split(" ")
            length = len(words)
            
            if length> max_len:
                max_len = length
                
        return max_len
        

#Optimal Solution
class Solution:
    def mostWordsFound(self, sentences: List[str]) -> int:
        ans=0
        for i in sentences:
            ans = max(ans,len(i.split()))
        return ans
      
