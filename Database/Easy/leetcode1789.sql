# https://leetcode.com/problems/primary-department-for-each-employee/

# Table: Employee

# +---------------+---------+
# | Column Name   |  Type   |
# +---------------+---------+
# | employee_id   | int     |
# | department_id | int     |
# | primary_flag  | varchar |
# +---------------+---------+
# (employee_id, department_id) is the primary key for this table.
# employee_id is the id of the employee.
# department_id is the id of the department to which the employee belongs.
# primary_flag is an ENUM of type ('Y', 'N'). If the flag is 'Y', the department is the primary department for the employee. If the flag is 'N', the department is not the primary.
 
# Employees can belong to multiple departments. When the employee joins other departments, they need to decide which department is their primary department. Note that when an employee belongs to only one department, their primary column is 'N'.
# Write an SQL query to report all the employees with their primary department. For employees who belong to one department, report their only department.
# Return the result table in any order.

# My Solution
SELECT T.EMPLOYEE_ID, T.DEPARTMENT_ID FROM
(SELECT EMPLOYEE_ID, 
 DEPARTMENT_ID, 
 DENSE_RANK() OVER (PARTITION BY EMPLOYEE_ID ORDER BY PRIMARY_FLAG) AS RNK 
 FROM EMPLOYEE) T WHERE T.RNK=1;


# Alternate Solution
select employee_id,department_id from Employee where primary_flag='Y'
union all
select employee_id,department_id from Employee
where primary_flag='N' 
and employee_id not in (select employee_id from Employee where primary_flag='Y')

