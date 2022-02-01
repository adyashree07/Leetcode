# https://leetcode.com/problems/all-people-report-to-the-given-manager/

# Table: Employees
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | employee_id   | int     |
# | employee_name | varchar |
# | manager_id    | int     |
# +---------------+---------+
# employee_id is the primary key for this table.
# Each row of this table indicates that the employee with ID employee_id and name employee_name reports his work to his/her direct manager with manager_id
# The head of the company is the employee with employee_id = 1.
 
# Write an SQL query to find employee_id of all employees that directly or indirectly report their work to the head of the company.
# The indirect relation between managers will not exceed three managers as the company is small.
# Return the result table in any order.

# My Solution
SELECT E1.EMPLOYEE_ID 
FROM EMPLOYEES E1 INNER JOIN EMPLOYEES E2 ON E1.MANAGER_ID = E2.EMPLOYEE_ID 
INNER JOIN EMPLOYEES E3 ON E2.MANAGER_ID = E3.EMPLOYEE_ID 
WHERE E1.EMPLOYEE_ID<>1 AND 
(E1.MANAGER_ID=1 OR E2.MANAGER_ID=1 OR E3.MANAGER_ID=1) 
ORDER BY E1.EMPLOYEE_ID;


# Alternate Solution
select e1.employee_id
from Employees e1
left join Employees e2
on e1.manager_id=e2.employee_id
left join Employees e3
on e2.manager_id=e3.employee_id
where e3.manager_id='1' 
      and e3.manager_id<>e1.employee_id;
      
      
