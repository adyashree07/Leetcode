# https://leetcode.com/problems/average-salary-departments-vs-company/

# Table: Salary
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | id          | int  |
# | employee_id | int  |
# | amount      | int  |
# | pay_date    | date |
# +-------------+------+
# id is the primary key column for this table.
# Each row of this table indicates the salary of an employee in one month.
# employee_id is a foreign key from the Employee table.
 
# Table: Employee
# +---------------+------+
# | Column Name   | Type |
# +---------------+------+
# | employee_id   | int  |
# | department_id | int  |
# +---------------+------+
# employee_id is the primary key column for this table.
# Each row of this table indicates the department of an employee.
 
# Write an SQL query to report the comparison result (higher/lower/same) of the average salary of employees in a department to the company's average salary.
# Return the result table in any order.

# My Solution
WITH T1 AS (
    SELECT DATE_FORMAT(PAY_DATE,"%Y-%m") AS PAY_MONTH,
           AVG(AMOUNT) AS COMPANY_SAL
    FROM SALARY
    GROUP BY PAY_MONTH),
T2 AS (
    SELECT DATE_FORMAT(S.PAY_DATE,"%Y-%m") AS PAY_MONTH,
           E.DEPARTMENT_ID, 
           COALESCE(AVG(S.AMOUNT),0) AS DEPT_SAL
    FROM EMPLOYEE E LEFT JOIN SALARY S
    ON E.EMPLOYEE_ID= S.EMPLOYEE_ID
    GROUP BY E.DEPARTMENT_ID, PAY_MONTH)
    
SELECT T1.PAY_MONTH,
       DEPARTMENT_ID,
       CASE WHEN COMPANY_SAL>DEPT_SAL THEN "lower"
            WHEN COMPANY_SAL=DEPT_SAL THEN "same"
            ELSE "higher"
       END AS COMPARISON
FROM T1 JOIN T2 
ON T1.PAY_MONTH=T2.PAY_MONTH;

