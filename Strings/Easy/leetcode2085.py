# https://leetcode.com/problems/count-common-words-with-one-occurrence/

# Given two string arrays words1 and words2, return the number of strings that appear exactly once in each of the two arrays.

# My Solution
class Solution:
    def countWords(self, words1: List[str], words2: List[str]) -> int:
        n1 = len(words1)
        n2 = len(words2)
        
        word = dict()
        
        for i in range(n1):
            if words1[i] not in word:
                word[words1[i]] = 1
                
            else:
                word[words1[i]] += 1
         
        count = 0
        for j in range(n2):
            if words2[j] in word:
                if word[words2[j]]==1 and words2.count(words2[j])==1:
                    count += 1
            else:
                pass
            
        return count
        
        
# Optimal Solution
class Solution:
    def countWords(self, words1: List[str], words2: List[str]) -> int:
        c1=Counter(words1)
        c2=Counter(words2)
        #print(c1,c2)
        ans = 0
        for k in c1:
            if k in c2 and c1[k]==1 and c2[k]==1:
                ans+=1
        return ans
      
      
