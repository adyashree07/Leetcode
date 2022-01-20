# https://leetcode.com/problems/koko-eating-bananas/

# Koko loves to eat bananas. There are n piles of bananas, the ith pile has piles[i] bananas. The guards have gone and will come back in h hours.
# Koko can decide her bananas-per-hour eating speed of k. Each hour, she chooses some pile of bananas and eats k bananas from that pile. If the pile has less than k bananas, she eats all of them instead and will not eat any more bananas during this hour.
# Koko likes to eat slowly but still wants to finish eating all the bananas before the guards return.
# Return the minimum integer k such that she can eat all the bananas within h hours.

# My Solution
class Solution:
    def minEatingSpeed(self, piles: List[int], h: int) -> int:
        piles.sort()
        n = len(piles)
        low = 1
        high = piles[n-1]
        mid = (low+high)//2
        
        ans = high
        while low<=high:
            count = 0
            for i in range(n):
                if piles[i]%mid==0:
                    count+=(piles[i]//mid)
                else:
                    count+=(piles[i]//mid + 1)
            if count<=h:
                high = mid-1
                ans = min(ans,mid)
            else:
                low = mid+1


            mid = (low+high)//2  
            
        return ans
      
      
# Optimal Solution
class Solution:
    def minEatingSpeed(self, piles: List[int], h: int) -> int:
        
        if len(piles) == h:
            return max(piles)
        
        s = sum(piles)
        l,r = (s - 1) // h + 1, (s - 1) // (h - len(piles)) + 1
        
        def isViable(cap):
            return sum((p-1)//cap + 1 for p in piles) <= h
        while l < r:
            
            m = (l + r) // 2
            if isViable(m):
                r = m
            else:
                l = m + 1
        return l
      
      
