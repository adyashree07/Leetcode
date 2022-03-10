# https://leetcode.com/problems/group-the-people-given-the-group-size-they-belong-to/

# There are n people that are split into some unknown number of groups. Each person is labeled with a unique ID from 0 to n - 1.
# You are given an integer array groupSizes, where groupSizes[i] is the size of the group that person i is in. For example, if groupSizes[1] = 3, then person 1 must be in a group of size 3.
# Return a list of groups such that each person i is in a group of size groupSizes[i].
# Each person should appear in exactly one group, and every person must be in a group. If there are multiple answers, return any of them. It is guaranteed that there will be at least one valid solution for the given input.

# My Solution
class Solution:
    def groupThePeople(self, groupSizes: List[int]) -> List[List[int]]:
        n = len(groupSizes)
        size = dict()
        
        for i in range(n):
            if groupSizes[i] not in size:
                size[groupSizes[i]] = [i]
            else:
                size[groupSizes[i]].append(i)
                
        ans = []  
        for k,v in size.items():
            if k==len(v):
                ans.append(v)
            else:
                m = len(v)
                while m>0:
                    ans.append(v[m-k:m])
                    m -= k
        
        return ans
      
      
# Alternate Solution
class Solution:
    def groupThePeople(self, groupSizes: List[int]) -> List[List[int]]:
        dic={}
        res=[]
        for i,num in enumerate(groupSizes):
            if num not in dic:
                dic[num]=[]
            dic[num]+=[i]
            if len(dic[num])==num:
                res.append(dic[num])
                dic[num]=[]
        return res
      
      
