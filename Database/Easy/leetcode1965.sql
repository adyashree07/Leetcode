# https://leetcode.com/problems/employees-with-missing-information/

# Table: Employees
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | employee_id | int     |
# | name        | varchar |
# +-------------+---------+
# employee_id is the primary key for this table.
# Each row of this table indicates the name of the employee whose ID is employee_id.
 
# Table: Salaries
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | employee_id | int     |
# | salary      | int     |
# +-------------+---------+
# employee_id is the primary key for this table.
# Each row of this table indicates the salary of the employee whose ID is employee_id.
 
# Write an SQL query to report the IDs of all the employees with missing information. The information of an employee is missing if:
# 1. The employee's name is missing, or
# 2. The employee's salary is missing.
# Return the result table ordered by employee_id in ascending order.

# My Solution
SELECT E.EMPLOYEE_ID AS EMPLOYEE_ID
FROM EMPLOYEES E LEFT JOIN SALARIES S
ON E.EMPLOYEE_ID= S.EMPLOYEE_ID
WHERE S.SALARY IS NULL 
UNION
SELECT S.EMPLOYEE_ID
FROM SALARIES S LEFT JOIN EMPLOYEES E
ON S.EMPLOYEE_ID=E.EMPLOYEE_ID
WHERE E.NAME IS NULL
ORDER BY 1;


# Alternate Solution
SELECT a.employee_id 
from(
  SELECT employee_id from employees
  union all
  SELECT employee_id from salaries) as a
GROUP BY employee_id
Having count(employee_id) = 1
order by employee_id asc;

