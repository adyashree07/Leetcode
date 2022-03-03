# https://leetcode.com/problems/calculate-salaries/

# Table Salaries:
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | company_id    | int     |
# | employee_id   | int     |
# | employee_name | varchar |
# | salary        | int     |
# +---------------+---------+
# (company_id, employee_id) is the primary key for this table.
# This table contains the company id, the id, the name, and the salary for an employee.
 
# Write an SQL query to find the salaries of the employees after applying taxes. Round the salary to the nearest integer.
# The tax rate is calculated for each company based on the following criteria:
# 1. 0% If the max salary of any employee in the company is less than $1000.
# 2. 24% If the max salary of any employee in the company is in the range [1000, 10000] inclusive.
# 3. 49% If the max salary of any employee in the company is greater than $10000.
# Return the result table in any order.

# My Solution
SELECT COMPANY_ID,
       EMPLOYEE_ID,
       EMPLOYEE_NAME,
       CASE WHEN MAX(SALARY) OVER (PARTITION BY COMPANY_ID)<1000 THEN ROUND(SALARY)
            WHEN MAX(SALARY) OVER (PARTITION BY COMPANY_ID) BETWEEN 1000 AND 10000 THEN ROUND(SALARY - 0.24*SALARY)
            ELSE ROUND(SALARY- 0.49*SALARY)
       END AS SALARY
FROM SALARIES;


# Alternate Solution
with t1 as (select company_id, case when max(salary) < 1000 Then 0
when max(salary) <= 10000 and max(salary)>=1000  Then 0.24
when max(salary) > 10000 Then 0.49
end as tax_rate
from salaries
group by company_id)

select company_id,employee_id,employee_name, round(salary*(1-tax_rate),0) as salary from salaries
left join t1 using(company_id);

