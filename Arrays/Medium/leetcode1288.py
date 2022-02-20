# https://leetcode.com/problems/remove-covered-intervals/

# Given an array intervals where intervals[i] = [li, ri] represent the interval [li, ri), remove all intervals that are covered by another interval in the list.
# The interval [a, b) is covered by the interval [c, d) if and only if c <= a and b <= d.
# Return the number of remaining intervals.

# My Solution
class Solution:
    def removeCoveredIntervals(self, intervals: List[List[int]]) -> int:
        sort_intervals = sorted(intervals,key=lambda x: x[0])
        n = len(sort_intervals)
        count = 0
        number = sort_intervals[0]
        
        print(sort_intervals)
        
        for i in range(1,n):
            if  number[1] < sort_intervals[i][1]:
                if number[0] !=sort_intervals[i][0]:
                    count += 1
                number = sort_intervals[i]
        
        return count+1
      
      
# Alternate Solution
class Solution:
    def removeCoveredIntervals(self, intervals: List[List[int]]) -> int:
        
        def canCover(a,b) -> bool:
            # Ture if a can cover b
            return a[0] <= b[0] and a[1] >= b[1]
        
        intervals.sort(key=lambda x:x[0])
        stack = [intervals[0]]
        for next_interval in intervals:
            
            top = stack.pop()
            if canCover(top,next_interval):
                stack.append(top)
                continue
            elif canCover(next_interval,top):
                stack.append(next_interval)
            else:
                stack.append(top)
                stack.append(next_interval)
        
        return len(stack)
      
      
