# https://leetcode.com/problems/find-the-town-judge/

# In a town, there are n people labeled from 1 to n. There is a rumor that one of these people is secretly the town judge.
# If the town judge exists, then:
# The town judge trusts nobody.
# 1. Everybody (except for the town judge) trusts the town judge.
# 2. There is exactly one person that satisfies properties 1 and 2.
# You are given an array trust where trust[i] = [ai, bi] representing that the person labeled ai trusts the person labeled bi.
# Return the label of the town judge if the town judge exists and can be identified, or return -1 otherwise.

# My Solution
class Solution:
    def findJudge(self, n: int, trust: List[List[int]]) -> int:
        m = len(trust)
        
        if n==1:
            return 1
        elif n>1 and trust==[]:
            return -1
        
        a = dict()
        b = dict()
        
        for i in range(m):
            if trust[i][0] not in a:
                a[trust[i][0]] = 1
            if trust[i][1] not in b:
                b[trust[i][1]] = 1
            else:
                b[trust[i][1]] += 1
        
        for i in range(1,n+1):
            if i not in a and i in b:
                if b[i]==(n-1):
                    return i           
            
        return -1
                
  
# Optimal Solution
class Solution:
    def findJudge(self, n: int, trust: List[List[int]]) -> int:
        if len(trust) == 0: return 1 if n == 1 else -1
        if n == len(trust): return -1
        dic = {}
        for e in trust:
            dic[e[0]] = -1
            dic[e[1]] = dic.get(e[1], 0)+1
        print(n, dic)
        for e in dic:
            if dic[e] == n-1:
                return e
        return -1
      
      
