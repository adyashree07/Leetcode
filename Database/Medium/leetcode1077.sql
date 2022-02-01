# https://leetcode.com/problems/project-employees-iii/

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
 
# Write an SQL query that reports the most experienced employees in each project. In case of a tie, report all employees with the maximum number of experience years.
# Return the result table in any order.

# My Solution
SELECT T.PROJECT_ID, T.EMPLOYEE_ID FROM
(SELECT P.PROJECT_ID, 
        E.EMPLOYEE_ID, 
        DENSE_RANK() OVER (PARTITION BY P.PROJECT_ID ORDER BY E.EXPERIENCE_YEARS DESC) AS RNK 
 FROM PROJECT P INNER JOIN EMPLOYEE E ON P.EMPLOYEE_ID = E.EMPLOYEE_ID) T WHERE T.RNK=1;


# Alternate Solution
elect project_id, employee_id
from
(select p.project_id, e.employee_id,
      rank() over (partition by project_id order by experience_years desc) as rnk
from Project p
     join Employee e on e.employee_id = p.employee_id) t
where rnk = 1;

