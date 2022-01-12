# https://leetcode.com/problems/unique-number-of-occurrences/
  
# Given an array of integers arr, return true if the number of occurrences of each value in the array is unique, or false otherwise.

# My Solution
class Solution:
    def uniqueOccurrences(self, arr: List[int]) -> bool:
        freq  = dict()
        
        n = len(arr)
        
        for i in range(n):
            if arr[i] not in freq:
                freq[arr[i]] = 1
            else:
                freq[arr[i]] += 1
            
        
        if len(set(freq.values()))==len(freq.keys()):
            return True
        else:
            return False
        
        
# Optimal Solution
class Solution:
    def uniqueOccurrences(self, arr: List[int]) -> bool:
        
        uniques = {}
        for elt in arr:
            uniques[elt] = uniques.get(elt, 0) + 1
        # print(uniques)
        vals = list( uniques.values() )
        return len(vals) == len(set(vals))
      
      
