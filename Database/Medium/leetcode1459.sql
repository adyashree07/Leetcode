# https://leetcode.com/problems/rectangles-area/

# Table: Points
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | id            | int     |
# | x_value       | int     |
# | y_value       | int     |
# +---------------+---------+
# id is the primary key for this table.
# Each point is represented as a 2D coordinate (x_value, y_value).
 
# Write an SQL query to report all possible axis-aligned rectangles with a non-zero area that can be formed by any two points from the Points table.
# Each row in the result should contain three columns (p1, p2, area) where:
# 1. p1 and p2 are the id's of the two points that determine the opposite corners of a rectangle.
# 2. area is the area of the rectangle and must be non-zero.
# Return the result table ordered by area in descending order. If there is a tie, order them by p1 in ascending order. If there is still a tie, order them by p2 in ascending order.

# My Solution
SELECT T.* FROM (
    SELECT T1.ID AS P1, 
       T2.ID AS P2,
       ABS(T1.X_VALUE-T2.X_VALUE)*ABS(T1.Y_VALUE-T2.Y_VALUE) AS AREA
    FROM POINTS T1 LEFT JOIN  POINTS T2 
    ON T1.ID<T2.ID 
    WHERE T2.ID IS NOT NULL) T
WHERE T.AREA!=0 
ORDER BY T.AREA DESC, P1 ASC, P2 ASC;

