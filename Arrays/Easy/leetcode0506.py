# https://leetcode.com/problems/relative-ranks/

# ou are given an integer array score of size n, where score[i] is the score of the ith athlete in a competition. All the scores are guaranteed to be unique.
# The athletes are placed based on their scores, where the 1st place athlete has the highest score, the 2nd place athlete has the 2nd highest score, and so on. The placement of each athlete determines their rank:
# 1. The 1st place athlete's rank is "Gold Medal".
# 2. The 2nd place athlete's rank is "Silver Medal".
# 3. The 3rd place athlete's rank is "Bronze Medal".
# 4. For the 4th place to the nth place athlete, their rank is their placement number (i.e., the xth place athlete's rank is "x").
# Return an array answer of size n where answer[i] is the rank of the ith athlete.

# My Solution
class Solution:
    def findRelativeRanks(self, score: List[int]) -> List[str]:
        order = sorted(score, reverse=True)
        
        placement = {}
        
        for i in range(len(order)):
            if i==0:
                placement[order[i]] = "Gold Medal"
            elif i==1:
                placement[order[i]] = "Silver Medal"
            elif i==2:
                placement[order[i]] = "Bronze Medal"
            else:
                placement[order[i]] = str(i+1)
            
        for i in range(len(score)):
            score[i] = placement[score[i]]
        
        return score
            
        
# Optimal Solution
class Solution:
    def findRelativeRanks(self, score: List[int]) -> List[str]:
        the_map = {}
        length = len(score)
        for count, item in enumerate(sorted(score)):
            if count <= length - 4:
                the_map[item] = str(length - count)
            elif count == length - 3:
                the_map[item] = "Bronze Medal"
            elif count == length - 2:
                the_map[item] = "Silver Medal"
            elif count == length - 1:
                the_map[item] = "Gold Medal"
        for i in range(length):
            score[i] = the_map[score[i]]
        return score
      
