# https://leetcode.com/problems/maximize-distance-to-closest-person/

# You are given an array representing a row of seats where seats[i] = 1 represents a person sitting in the ith seat, and seats[i] = 0 represents that the ith seat is empty (0-indexed).
# There is at least one empty seat, and at least one person sitting.
# Alex wants to sit in the seat such that the distance between him and the closest person to him is maximized. 
# Return that maximum distance to the closest person.

# My Solution
class Solution:
    def maxDistToClosest(self, seats: List[int]) -> int:
        n = len(seats)
        
        first = seats.index(1)
            
        diff = first
        seat_1 = first
        
        if seats.count(1)==1:
            return max(first, n-first-1)
        
        for i in range(n):
            if seats[i]==1:
                diff = max(diff,i-first)
                first = i
        
        
        return max(diff//2,n-1-first,seat_1)
                
                
# Optimal Solution
class Solution:
    def maxDistToClosest(self, seats: List[int]) -> int:
        max_dist = 1
        last_seat = -float('inf')
        for i, seat in enumerate(seats):
            if seat == 1:
                if last_seat < 0:
                    dist = i
                else:
                    dist = (i - last_seat)//2
                max_dist = max(max_dist, dist)
                last_seat = i

        if seats[-1] == 0:
            max_dist = max(max_dist, len(seats) - last_seat - 1)
            
        return max_dist
      
      
