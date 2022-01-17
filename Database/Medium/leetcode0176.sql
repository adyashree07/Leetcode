# https://leetcode.com/problems/second-highest-salary/

# My Solution
SELECT (SELECT DISTINCT SALARY AS SECONDHIGHESTSALARY FROM EMPLOYEE ORDER BY SALARY DESC limit 1,1) AS SECONDHIGHESTSALARY;


# Optimal Solution
SELECT
    IFNULL(
      (SELECT DISTINCT Salary
       FROM Employee
       ORDER BY Salary DESC
        LIMIT 1 OFFSET 1),
    NULL) AS SecondHighestSalary;
