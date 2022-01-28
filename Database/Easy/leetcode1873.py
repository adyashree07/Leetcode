# https://leetcode.com/problems/calculate-special-bonus/

# Table: Employees

# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | employee_id | int     |
# | name        | varchar |
# | salary      | int     |
# +-------------+---------+
# employee_id is the primary key for this table.
# Each row of this table indicates the employee ID, employee name, and salary.

# Write an SQL query to calculate the bonus of each employee. The bonus of an employee is 100% of their salary if the ID of the employee is an odd number and the employee name does not start with the character 'M'. The bonus of an employee is 0 otherwise.
# Return the result table ordered by employee_id.

# My Solution
SELECT EMPLOYEE_ID,
CASE WHEN NAME NOT LIKE "M%" AND EMPLOYEE_ID%2!=0 THEN SALARY
ELSE 0
END AS BONUS FROM EMPLOYEES;

