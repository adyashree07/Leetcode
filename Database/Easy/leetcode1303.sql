# https://leetcode.com/problems/find-the-team-size/

# Table: Employee
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | employee_id   | int     |
# | team_id       | int     |
# +---------------+---------+
# employee_id is the primary key for this table.
# Each row of this table contains the ID of each employee and their respective team.

# Write an SQL query to find the team size of each of the employees.
# Return result table in any order.

# My Solution
SELECT E.EMPLOYEE_ID, 
       T.CNT AS TEAM_SIZE 
FROM EMPLOYEE E LEFT JOIN (
    SELECT TEAM_ID,
           COUNT(TEAM_ID) AS CNT 
    FROM EMPLOYEE GROUP BY TEAM_ID) T 
ON E.TEAM_ID = T.TEAM_ID;

