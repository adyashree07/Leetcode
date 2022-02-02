# https://leetcode.com/problems/employee-bonus/

# Table: Employee
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | empId       | int     |
# | name        | varchar |
# | supervisor  | int     |
# | salary      | int     |
# +-------------+---------+
# empId is the primary key column for this table.
# Each row of this table indicates the name and the ID of an employee in addition to their salary and the id of their manager.
 
# Table: Bonus
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | empId       | int  |
# | bonus       | int  |
# +-------------+------+
# empId is the primary key column for this table.
# empId is a foreign key to empId from the Employee table.
# Each row of this table contains the id of an employee and their respective bonus.
 
# Write an SQL query to report the name and bonus amount of each employee with a bonus less than 1000.
# Return the result table in any order.

# My Solution
SELECT E.NAME, 
       B.BONUS 
FROM EMPLOYEE E LEFT JOIN BONUS B ON E.EMPID = B.EMPID 
WHERE B.BONUS<1000 OR B.BONUS IS NULL;

