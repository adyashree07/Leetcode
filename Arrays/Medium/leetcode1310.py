# https://leetcode.com/problems/xor-queries-of-a-subarray/

# You are given an array arr of positive integers. You are also given the array queries where queries[i] = [lefti, righti].
# For each query i compute the XOR of elements from lefti to righti (that is, arr[lefti] XOR arr[lefti + 1] XOR ... XOR arr[righti] ).
# Return an array answer where answer[i] is the answer to the ith query.

# My Solution
class Solution:
    def xorQueries(self, arr: List[int], queries: List[List[int]]) -> List[int]:
        n = len(arr)
        prefix = [0]*n
        prefix[0] = arr[0]
        
        for i in range(1,n):
            prefix[i] = prefix[i-1]^arr[i]
            
        ans = []
            
        for i in range(len(queries)):
            if queries[i][0]==0:
                ans.append(prefix[queries[i][1]])
            else:
                ans.append(prefix[queries[i][0]-1]^prefix[queries[i][1]])
        
        return ans

      
