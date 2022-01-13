# https://leetcode.com/problems/sort-integers-by-the-number-of-1-bits/

# You are given an integer array arr. Sort the integers in the array in ascending order by the number of 1's in their binary representation and in case of two or more integers have the same number of 1's you have to sort them in ascending order.
# Return the array after sorting it.

# My Solution
class Solution:
    def countSetBit(self, A):
        count = 0
        while A>0:
            A = A & A-1
            count+= 1
        return count
    
    def sortByBits(self, arr: List[int]) -> List[int]:
        arr.sort(key = lambda x: (self.countSetBit(x), x))
        
        return arr
      
   
# Optimal Solution
class Solution:
    def sortByBits(self, arr: List[int]) -> List[int]:
        return sorted(arr, key=lambda x: (bin(x).count('1'), x))
      
        
