# https://leetcode.com/problems/group-employees-of-the-same-salary/

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
 
# A company wants to divide the employees into teams such that all the members on each team have the same salary. The teams should follow these criteria:
# 1. Each team should consist of at least two employees.
# 2. All the employees on a team should have the same salary.
# 3. All the employees of the same salary should be assigned to the same team.
# 4. If the salary of an employee is unique, we do not assign this employee to any team.
# 5. A team's ID is assigned based on the rank of the team's salary relative to the other teams' salaries, where the team with the lowest salary has team_id = 1. Note that the salaries for employees not on a team are not included in this ranking.

# Write an SQL query to get the team_id of each employee that is in a team.
# Return the result table ordered by team_id in ascending order. In case of a tie, order it by employee_id in ascending order.

# My Solution
WITH CTE AS (
    SELECT SALARY 
    FROM EMPLOYEES 
    GROUP BY SALARY 
    HAVING COUNT(SALARY)>1)
SELECT *, DENSE_RANK() OVER (ORDER BY SALARY) AS TEAM_ID FROM EMPLOYEES WHERE SALARY IN (SELECT SALARY FROM CTE);

