# https://leetcode.com/problems/project-employees-i/

# Table: Project
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | project_id  | int     |
# | employee_id | int     |
# +-------------+---------+
# (project_id, employee_id) is the primary key of this table.
# employee_id is a foreign key to Employee table.
# Each row of this table indicates that the employee with employee_id is working on the project with project_id.
 
# Table: Employee
# +------------------+---------+
# | Column Name      | Type    |
# +------------------+---------+
# | employee_id      | int     |
# | name             | varchar |
# | experience_years | int     |
# +------------------+---------+
# employee_id is the primary key of this table.
# Each row of this table contains information about one employee.
 
# Write an SQL query that reports the average experience years of all the employees for each project, rounded to 2 digits.
# Return the result table in any order.

# My Solution
SELECT P.PROJECT_ID, 
       ROUND(AVG(E.EXPERIENCE_YEARS),2) AS AVERAGE_YEARS 
FROM PROJECT P LEFT JOIN EMPLOYEE E
ON P.EMPLOYEE_ID = E.EMPLOYEE_ID 
GROUP BY P.PROJECT_ID;

