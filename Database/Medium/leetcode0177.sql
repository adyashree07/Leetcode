# https://leetcode.com/problems/nth-highest-salary/

# Table: Employee
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | id          | int  |
# | salary      | int  |
# +-------------+------+
# id is the primary key column for this table.
# Each row of this table contains information about the salary of an employee.
 
# Write an SQL query to report the nth highest salary from the Employee table. If there is no nth highest salary, the query should report null.

# My Solution
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
    SET N = N-1;
  RETURN (
      # Write your MySQL query statement below.
      SELECT DISTINCT SALARY FROM EMPLOYEE ORDER BY SALARY DESC LIMIT N,1
  );
END


# Alternate Solution
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      # Write your MySQL query statement below.
      select salary  from
      (select distinct salary,dense_rank() over(order by salary desc) rnk from Employee)t
      where rnk=N
      
  );
END

