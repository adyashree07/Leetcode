# https://leetcode.com/problems/median-employee-salary/

# Table: Employee
# +--------------+---------+
# | Column Name  | Type    |
# +--------------+---------+
# | id           | int     |
# | company      | varchar |
# | salary       | int     |
# +--------------+---------+
# id is the primary key column for this table.
# Each row of this table indicates the company and the salary of one employee.
 
# Write an SQL query to find the median salary of each company.
# Return the result table in any order.

# My Solution
WITH CTE AS (
    SELECT *, 
           ROW_NUMBER() OVER (PARTITION BY COMPANY ORDER BY SALARY) AS RNK,
           COUNT(*) OVER (PARTITION BY COMPANY) AS CNT
    FROM EMPLOYEE
)
SELECT CTE.ID, COMPANY, SALARY FROM CTE WHERE CNT%2=1 AND RNK = FLOOR(CNT/2)+1
UNION
SELECT CTE.ID, COMPANY, SALARY FROM CTE WHERE CNT%2=0 AND (RNK= CNT/2 OR RNK=CNT/2+1);

