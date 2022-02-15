# https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/

# Table: Employees
# +-------------+----------+
# | Column Name | Type     |
# +-------------+----------+
# | employee_id | int      |
# | name        | varchar  |
# | reports_to  | int      |
# | age         | int      |
# +-------------+----------+
# employee_id is the primary key for this table.
# This table contains information about the employees and the id of the manager they report to. Some employees do not report to anyone (reports_to is null). 
 
# For this problem, we will consider a manager an employee who has at least 1 other employee reporting to them.
# Write an SQL query to report the ids and the names of all managers, the number of employees who report directly to them, and the average age of the reports rounded to the nearest integer.
# Return the result table ordered by employee_id.

# My Solution
SELECT REPORTS_TO AS EMPLOYEE_ID, 
        MANAGER AS NAME,
        COUNT(EMPLOYEE_ID) AS REPORTS_COUNT, 
        ROUND(AVG(AGE)) AS AVERAGE_AGE
FROM (
    SELECT E1.*, E2.NAME AS MANAGER
    FROM EMPLOYEES E1 JOIN EMPLOYEES E2 
    ON E1.REPORTS_TO = E2.EMPLOYEE_ID) T
GROUP BY REPORTS_TO
ORDER BY EMPLOYEE_ID;


# Alternate Solution
select  e1.reports_to as employee_id,
        e.name as name,count(*) as reports_count,
        round(avg(e1.age)) as average_age
from Employees as e1
join Employees as e
on e1.reports_to=e.employee_id
where e1.reports_to is not null
group by 1
order by 1;

