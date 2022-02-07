# https://leetcode.com/problems/managers-with-at-least-5-direct-reports/

# Table: Employee
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | id          | int     |
# | name        | varchar |
# | department  | varchar |
# | managerId   | int     |
# +-------------+---------+
# id is the primary key column for this table.
# Each row of this table indicates the name of an employee, their department, and the id of their manager.
# If managerId is null, then the employee does not have a manager.
# No employee will be the manager of themself.
 
# Write an SQL query to report the managers with at least five direct reports.
# Return the result table in any order.

# My Solution
WITH CTE AS (
    SELECT MANAGERID, 
           ROW_NUMBER() OVER (PARTITION BY MANAGERID ) AS RNK 
     FROM EMPLOYEE)
SELECT NAME FROM EMPLOYEE 
WHERE ID IN (SELECT MANAGERID FROM CTE WHERE RNK>=5);
