# https://leetcode.com/problems/can-place-flowers/

# You have a long flowerbed in which some of the plots are planted, and some are not. However, flowers cannot be planted in adjacent plots.
# Given an integer array flowerbed containing 0's and 1's, where 0 means empty and 1 means not empty, and an integer n, return if n new flowers can be planted in the flowerbed without violating the no-adjacent-flowers rule.

# My Solution
class Solution:
    def canPlaceFlowers(self, flowerbed: List[int], n: int) -> bool:
        m = len(flowerbed)
        count = 0
        if n==0:
            return True
        
        if m==1:
            if flowerbed[0]==0:
                return True
            else:
                return False
        
        if flowerbed[0]==0 and flowerbed[1]==0:
            flowerbed[0] = 1
            n -= 1

        if flowerbed[m-1]==0 and flowerbed[m-2]==0:
            flowerbed[m-1] = 1
            n -= 1
        
        for i in range(1,m-1):
            if flowerbed[i]==0 and flowerbed[i-1]==0 and flowerbed[i+1]==0:
                flowerbed[i] = 1
                n -= 1

        if n>0:
            return False

        return True
      
      
# Optimal Solution
class Solution:
    def canPlaceFlowers(self, flowerbed: List[int], n: int) -> bool:
        if len(flowerbed) == 1:
            if n == 0: return True
            if flowerbed[0] == 0: return True
            if flowerbed[0] == 1: return False
        k = 0
        
        if flowerbed[0] == flowerbed[1] == 0:
            flowerbed[0] = 1
            k+=1
        if k == 0: to_start = 1
        else: to_start = k+1
        for i in range(to_start, len(flowerbed)-1):
            if flowerbed[i-1] == 0 and flowerbed[i] == 0 and flowerbed[i+1] == 0:
                flowerbed[i] = 1
                k+=1
        if flowerbed[-1] == flowerbed[-2]== 0 and flowerbed[-3] == 1:
            k+=1
        return k >= n
      
      
