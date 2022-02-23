# https://leetcode.com/problems/students-with-invalid-departments/

# Table: Departments
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | id            | int     |
# | name          | varchar |
# +---------------+---------+
# id is the primary key of this table.
# The table has information about the id of each department of a university.
 
# Table: Students
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | id            | int     |
# | name          | varchar |
# | department_id | int     |
# +---------------+---------+
# id is the primary key of this table.
# The table has information about the id of each student at a university and the id of the department he/she studies at.
 
# Write an SQL query to find the id and the name of all students who are enrolled in departments that no longer exist.
# Return the result table in any order.


# My Solution
SELECT ID, NAME FROM STUDENTS
WHERE DEPARTMENT_ID NOT IN (SELECT ID FROM DEPARTMENTS);


# Alternate Solution
select s.id, s.name
from students s
left join departments d
on s.department_id=d.id
Where d.id is Null;

