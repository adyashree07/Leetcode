# https://leetcode.com/problems/baseball-game/

# You are keeping score for a baseball game with strange rules. The game consists of several rounds, where the scores of past rounds may affect future rounds' scores.
# At the beginning of the game, you start with an empty record. You are given a list of strings ops, where ops[i] is the ith operation you must apply to the record and is one of the following:
# 1. An integer x - Record a new score of x.
# 2. "+" - Record a new score that is the sum of the previous two scores. It is guaranteed there will always be two previous scores.
# 3. "D" - Record a new score that is double the previous score. It is guaranteed there will always be a previous score.
# 4. "C" - Invalidate the previous score, removing it from the record. It is guaranteed there will always be a previous score.
# Return the sum of all the scores on the record.

# My Solution
class Solution:
    def calPoints(self, ops: List[str]) -> int:
        ans = []
        n = len(ops)
        
        for i in range(n):
            if ops[i]=="C":
                ans.pop()
            elif ops[i]=="D":
                ans.append(ans[-1]*2)
            elif ops[i]=="+":
                ans.append(ans[-1]+ans[-2])
            else:
                ans.append(int(ops[i]))
                
        return sum(ans)
        
        
# Optimal Solution
class Solution:
    def calPoints(self, ops: List[str]) -> int:
        result = []
        for i in ops:
            if i == 'C':
                result.pop()
            elif i == '+':
                result.append(result[-1] + result[-2])
            elif i == 'D':
                result.append(result[-1] * 2)
            else:
                result.append(int(i))
        sum = 0
        for i in result:
            sum += i
        
        return sum
      
      
