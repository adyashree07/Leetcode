# https://leetcode.com/problems/minimum-cost-to-move-chips-to-the-same-position/

# We have n chips, where the position of the ith chip is position[i].
# We need to move all the chips to the same position. In one step, we can change the position of the ith chip from position[i] to:
# 1. position[i] + 2 or position[i] - 2 with cost = 0.
# 2. position[i] + 1 or position[i] - 1 with cost = 1.
# Return the minimum cost needed to move all the chips to the same position.

# My Solution
class Solution:
    def minCostToMoveChips(self, position: List[int]) -> int:
        n = len(position)
        even = 0
        odd = 0
        for i in range(n):
            if position[i]%2:
                odd += 1
            else:
                even += 1
                
        return min(odd,even)
                
        
# Optimal Solution
class Solution:
    def minCostToMoveChips(self, position: List[int]) -> int:
        evens = 0
        odds = 0
        
        for p in position:
            evens += (p % 2 == 0)
            odds += (p % 2 == 1)
            
        return min(odds, evens)
      
      
