# https://leetcode.com/problems/the-number-of-seniors-and-juniors-to-join-the-company-ii/

# Table: Candidates
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | employee_id | int  |
# | experience  | enum |
# | salary      | int  |
# +-------------+------+
# employee_id is the primary key column for this table.
# experience is an enum with one of the values ('Senior', 'Junior').
# Each row of this table indicates the id of a candidate, their monthly salary, and their experience.
# The salary of each candidate is guaranteed to be unique.
 
# A company wants to hire new employees. The budget of the company for the salaries is $70000. The company's criteria for hiring are:
# 1. Keep hiring the senior with the smallest salary until you cannot hire any more seniors.
# 2. Use the remaining budget to hire the junior with the smallest salary.
# 3. Keep hiring the junior with the smallest salary until you cannot hire any more juniors.
# Write an SQL query to find the ids of seniors and juniors hired under the mentioned criteria.
# Return the result table in any order.

# My Solution
WITH T1 AS(
    SELECT SENIOR, 
           SUM(SALARY) OVER (ORDER BY SN_RNK) AS SAL_SN 
    FROM (
        SELECT EMPLOYEE_ID AS SENIOR,
               SALARY,
               ROW_NUMBER() OVER (PARTITION BY EXPERIENCE ORDER BY SALARY) AS SN_RNK
        FROM CANDIDATES
        WHERE EXPERIENCE="Senior") T),
T2 AS(
    SELECT JUNIOR, 
           SUM(SALARY) OVER (ORDER BY JN_RNK) AS SAL_JN 
    FROM (
        SELECT EMPLOYEE_ID AS JUNIOR,
               SALARY,
               ROW_NUMBER() OVER (PARTITION BY EXPERIENCE ORDER BY SALARY) AS JN_RNK
        FROM CANDIDATES
        WHERE EXPERIENCE="Junior") T
),
T3 AS (
    SELECT CASE WHEN SAL_SN<=70000 THEN SAL_SN 
           ELSE 0
           END AS SAL_SN
    FROM T1)   
SELECT SENIOR AS EMPLOYEE_ID FROM T1 WHERE SAL_SN<=70000
UNION
SELECT JUNIOR AS EMPLOYEE_ID FROM T2 WHERE SAL_JN <= 70000-(SELECT SAL_SN FROM T3 ORDER BY SAL_SN DESC LIMIT 1);


# Alternate Solution
with ranking as (
    select employee_id, experience, sum(salary) over (partition by experience order by salary) count_salary
    from candidates c
),
senior_table as (
    select count_salary, employee_id
    from ranking
    where experience = "Senior" and count_salary <= 70000
), 
junior_table as (
    select employee_id from ranking 
    where experience = 'Junior' 
    and count_salary <= (select 70000 - ifnull(max(count_salary), 0) from senior_table)
)
select employee_id from senior_Table 
union all
select employee_id from junior_table;

