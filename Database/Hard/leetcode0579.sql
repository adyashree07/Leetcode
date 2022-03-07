# https://leetcode.com/problems/find-cumulative-salary-of-an-employee/

# Table: Employee
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | id          | int  |
# | month       | int  |
# | salary      | int  |
# +-------------+------+
# (id, month) is the primary key for this table.
# Each row in the table indicates the salary of an employee in one month during the year 2020.
 
# Write an SQL query to calculate the cumulative salary summary for every employee in a single unified table.
# The cumulative salary summary for an employee can be calculated as follows:
# 1. For each month that the employee worked, sum up the salaries in that month and the previous two months. This is their 3-month sum for that month. If an employee did not work for the company in previous months, their effective salary for those months is 0.
# 2. Do not include the 3-month sum for the most recent month that the employee worked for in the summary.
# 3. Do not include the 3-month sum for any month the employee did not work.
# Return the result table ordered by id in ascending order. In case of a tie, order it by month in descending order.

# My Solution
WITH T1 AS (
    SELECT E1.ID, 
           E1.MONTH,
           E1.SALARY + COALESCE(E2.SALARY,0) + COALESCE(E3.SALARY,0) AS SALARY
    FROM EMPLOYEE E1 LEFT JOIN EMPLOYEE E2
    ON E1.ID = E2.ID AND E1.MONTH=E2.MONTH+1
    LEFT JOIN EMPLOYEE E3
    ON E1.ID = E3.ID AND E1.MONTH=E3.MONTH+2),
T2 AS (
    SELECT ID, 
           MAX(MONTH) AS END_MONTH 
    FROM EMPLOYEE
    GROUP BY ID)
    
SELECT T1.* 
FROM T1 JOIN T2
ON T1.ID = T2.ID AND T1.MONTH!=T2.END_MONTH
ORDER BY 1, 2 DESC;


# Alternate Solution
select e1.id 
    ,e1.month 
    ,sum(e2.salary) salary
from Employee e1
join Employee e2
on e1.id = e2.id
and e1.month - e2.month BETWEEN 0 AND 2 
where concat(e1.id,",",e1.month) not in (select concat(id,",",max(month)) from Employee group by id order by month  )
group by e1.id,e1.month
order by id,month desc;

