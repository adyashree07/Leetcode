# https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/

# Table: Employees

# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | id            | int     |
# | name          | varchar |
# +---------------+---------+
# id is the primary key for this table.
# Each row of this table contains the id and the name of an employee in a company.
 
# Table: EmployeeUNI

# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | id            | int     |
# | unique_id     | int     |
# +---------------+---------+
# (id, unique_id) is the primary key for this table.
# Each row of this table contains the id and the corresponding unique id of an employee in the company.
 
# Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just show null.
# Return the result table in any order.

# My Solution
SELECT EU.UNIQUE_ID, E.NAME FROM EMPLOYEES E LEFT JOIN EMPLOYEEUNI EU ON E.ID=EU.ID;
