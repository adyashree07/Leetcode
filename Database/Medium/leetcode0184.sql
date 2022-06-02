# https://leetcode.com/problems/department-highest-salary/

# Table: Employee
# +--------------+---------+
# | Column Name  | Type    |
# +--------------+---------+
# | id           | int     |
# | name         | varchar |
# | salary       | int     |
# | departmentId | int     |
# +--------------+---------+
# id is the primary key column for this table.
# departmentId is a foreign key of the ID from the Department table.
# Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.
 
# Table: Department
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | id          | int     |
# | name        | varchar |
# +-------------+---------+
# id is the primary key column for this table.
# Each row of this table indicates the ID of a department and its name.
 
# Write an SQL query to find employees who have the highest salary in each of the departments.
# Return the result table in any order.

# My Solution
SELECT DEPARTMENT,
       EMPLOYEE,
       SALARY
FROM (
    SELECT D.NAME AS DEPARTMENT, 
           E.NAME AS EMPLOYEE, 
           SALARY,
           DENSE_RANK() OVER (PARTITION BY E.DEPARTMENTID ORDER BY SALARY DESC) AS RNK 
    FROM DEPARTMENT D JOIN EMPLOYEE E
    ON D.ID = E.DEPARTMENTID) T
WHERE RNK=1;


# Alternate Solution
SELECT
    Department.name AS 'Department',
    Employee.name AS 'Employee',
    Salary
FROM
    Employee
        JOIN
    Department ON Employee.DepartmentId = Department.Id
WHERE
    (Employee.DepartmentId , Salary) IN
    (   SELECT
            DepartmentId, MAX(Salary)
        FROM
            Employee
        GROUP BY DepartmentId
    );

