# https://leetcode.com/problems/widest-vertical-area-between-two-points-containing-no-points/

# Given n points on a 2D plane where points[i] = [xi, yi], Return the widest vertical area between two points such that no points are inside the area.
# A vertical area is an area of fixed-width extending infinitely along the y-axis (i.e., infinite height). The widest vertical area is the one with the maximum width.
# Note that points on the edge of a vertical area are not considered included in the area.

# My Solution
class Solution:
    def maxWidthOfVerticalArea(self, points: List[List[int]]) -> int:
        sort_x = sorted(points, key=lambda x:x[0])
        
        max_diff = 0
        
        for i in range(1,len(sort_x)):
            max_diff = max(max_diff,sort_x[i][0]-sort_x[i-1][0])
        
        return max_diff
      
