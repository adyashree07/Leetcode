# https://leetcode.com/problems/shortest-distance-in-a-plane/

# Table: Point2D
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | x           | int  |
# | y           | int  |
# +-------------+------+
# (x, y) is the primary key column for this table.
# Each row of this table indicates the position of a point on the X-Y plane.
 
# The distance between two points p1(x1, y1) and p2(x2, y2) is sqrt((x2 - x1)2 + (y2 - y1)2).
# Write an SQL query to report the shortest distance between any two points from the Point2D table. Round the distance to two decimal points.

# My Solution
SELECT MIN(DIST) AS SHORTEST FROM (
    SELECT P1.X AS X1,
           P2.X AS X2,
           P1.Y AS Y1,
           P2.Y AS Y2,
           ROUND(SQRT(POWER((P1.X-P2.X),2) + POWER((P1.Y-P2.Y),2)),2) AS DIST
    FROM POINT2D P1 JOIN POINT2D P2) T
WHERE DIST!=0;


# Alternate Solution
select round(sqrt((abs(t1.x-t2.x))*(abs(t1.x-t2.x))+abs(t1.y-t2.y)*abs(t1.y-t2.y)),2) shortest
from Point2D t1
left join Point2D t2
on t1.x<>t2.x or t1.y<>t2.y
order by shortest
limit 1;

