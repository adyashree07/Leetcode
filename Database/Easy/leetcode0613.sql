# https://leetcode.com/problems/shortest-distance-in-a-line/

# Table: Point
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | x           | int  |
# +-------------+------+
# x is the primary key column for this table.
# Each row of this table indicates the position of a point on the X-axis.
 
# Write an SQL query to report the shortest distance between any two points from the Point table.

# My Solution
SELECT MIN(ABS(P1.X - P2.X)) AS SHORTEST
FROM POINT P1 JOIN POINT P2
ON P1.X != P2.X;

