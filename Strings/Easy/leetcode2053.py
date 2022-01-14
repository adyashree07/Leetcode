#https://leetcode.com/problems/kth-distinct-string-in-an-array/

#A distinct string is a string that is present only once in an array.
#Given an array of strings arr, and an integer k, return the kth distinct string present in arr. If there are fewer than k distinct strings, return an empty string "".
#Note that the strings are considered in the order in which they appear in the array.

#My Solution
class Solution:
    def kthDistinct(self, arr: List[str], k: int) -> str:
        n = len(arr)
        
        string = dict()
        
        for i in range(n):
            if arr[i] not in string:
                string[arr[i]] = 1
            else:
                string[arr[i]] +=1
        
        ans = []
        count = 0
        for key,val in string.items():
            if val==1:
                ans.append(key)
                count+=1
                
        if count<k:
            return ""
        else:
            return ans[k-1]
          
          
#Optimal Solution
import collections
class Solution:
    def kthDistinct(self, arr: List[str], k: int) -> str:
        count = collections.Counter(arr)
        for i in range(len(arr)):
            if count[arr[i]] == 1:
                k -= 1
                if k == 0:
                    return arr[i]
        return ""
      
        
