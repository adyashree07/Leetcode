# https://leetcode.com/problems/low-quality-problems/

# Table: Problems
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | problem_id  | int  |
# | likes       | int  |
# | dislikes    | int  |
# +-------------+------+
# problem_id is the primary key column for this table.
# Each row of this table indicates the number of likes and dislikes for a LeetCode problem.
 
# Write an SQL query to report the IDs of the low-quality problems. A LeetCode problem is low-quality if the like percentage of the problem (number of likes divided by the total number of votes) is strictly less than 60%.
# Return the result table ordered by problem_id in ascending order.

# My Solution
SELECT PROBLEM_ID FROM PROBLEMS 
WHERE LIKES/(LIKES+DISLIKES)<0.6 
ORDER BY PROBLEM_ID;

