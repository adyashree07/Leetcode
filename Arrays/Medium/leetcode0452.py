# https://leetcode.com/problems/minimum-number-of-arrows-to-burst-balloons/

# There are some spherical balloons taped onto a flat wall that represents the XY-plane. The balloons are represented as a 2D integer array points where points[i] = [xstart, xend] denotes a balloon whose horizontal diameter stretches between xstart and xend. You do not know the exact y-coordinates of the balloons.
# Arrows can be shot up directly vertically (in the positive y-direction) from different points along the x-axis. A balloon with xstart and xend is burst by an arrow shot at x if xstart <= x <= xend. There is no limit to the number of arrows that can be shot. A shot arrow keeps traveling up infinitely, bursting any balloons in its path.
# Given the array points, return the minimum number of arrows that must be shot to burst all balloons.

# My Solution
class Solution:
    def findMinArrowShots(self, points: List[List[int]]) -> int:
        ans = sorted(points,key = (lambda x: x[0]))
        
        start = ans[0][0]
        end = ans[0][1]
        count = 1
        
        for i in range(1,len(ans)):
            if ans[i][0] > end:
                count+=1
            if ans[i][0]>= start:
                start = ans[i][0]
            if end > ans[i][1] or end<start:
                end = ans[i][1]
         
        return count
      
     
# Optimal Solution
class Solution:
    def findMinArrowShots(self, points: List[List[int]]) -> int:
        points = sorted(points, key = lambda x: x[1])
        res, end = 0, float("-inf")
        for interval in points:
            if interval[0] > end:
                res += 1
                end = interval[1]
        return res
      
      
                
        
