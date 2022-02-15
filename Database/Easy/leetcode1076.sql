# https://leetcode.com/problems/project-employees-ii/

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
 
# Write an SQL query that reports all the projects that have the most employees.
# Return the result table in any order.

# My Solution
SELECT PROJECT_ID FROM (
    SELECT PROJECT_ID, 
           COUNT(EMPLOYEE_ID) AS TOTAL_EMPLOYEE,
           DENSE_RANK() OVER (ORDER BY COUNT(EMPLOYEE_ID) DESC) AS RNK
    FROM PROJECT
    GROUP BY PROJECT_ID) T
WHERE RNK=1;


# Alternate Solution
select project_id
from Project
group by project_id
having count(employee_id)=(select count(employee_id)
                          from Project
                          group by project_id
                          order by count(employee_id) desc
                          limit 1);
                          
                          
