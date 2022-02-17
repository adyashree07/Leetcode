# https://leetcode.com/problems/second-highest-salary/

# Table: Employee
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | id          | int  |
# | salary      | int  |
# +-------------+------+
# id is the primary key column for this table.
# Each row of this table contains information about the salary of an employee.
 
# Write an SQL query to report the second highest salary from the Employee table. If there is no second highest salary, the query should report null.

# My Solution
SELECT (SELECT DISTINCT SALARY AS SECONDHIGHESTSALARY FROM EMPLOYEE ORDER BY SALARY DESC limit 1,1) AS SECONDHIGHESTSALARY;


# Alternate Solution
SELECT
    IFNULL(
      (SELECT DISTINCT Salary
       FROM Employee
       ORDER BY Salary DESC
        LIMIT 1 OFFSET 1),
    NULL) AS SecondHighestSalary;
    
    
# Alternate Solution-2
SELECT Max(Salary) as  SecondHighestSalary
FROM Employee
WHERE Salary < (SELECT MAX(Salary) FROM Employee );

