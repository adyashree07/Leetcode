# https://leetcode.com/problems/the-number-of-seniors-and-juniors-to-join-the-company/

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
 
# A company wants to hire new employees. The budget of the company for the salaries is $70000. The company's criteria for hiring are:
# 1. Hiring the largest number of seniors.
# 2. After hiring the maximum number of seniors, use the remaining budget to hire the largest number of juniors.
# Write an SQL query to find the number of seniors and juniors hired under the mentioned criteria.
# Return the result table in any order.

# My Solution
WITH T1 AS (
    SELECT * FROM CANDIDATES 
    WHERE EXPERIENCE="Senior"
    ORDER BY SALARY),
T2 AS (
    SELECT * FROM CANDIDATES 
    WHERE EXPERIENCE="Junior"
    ORDER BY SALARY),
T3 AS (
    SELECT * FROM (
        SELECT EMPLOYEE_ID, 
               EXPERIENCE,
               SUM(SALARY) OVER (ORDER BY SALARY,EMPLOYEE_ID ASC) AS TOT_SAL
    FROM T1) T
    WHERE TOT_SAL<=70000)

SELECT COALESCE(EXPERIENCE,"Senior") AS EXPERIENCE, 
       COUNT(EMPLOYEE_ID) AS ACCEPTED_CANDIDATES 
FROM T3
UNION
SELECT COALESCE(EXPERIENCE,"Junior") AS EXPERIENCE,
       COUNT(EMPLOYEE_ID) AS ACCEPTED_CANDIDATES FROM (
    SELECT EMPLOYEE_ID, 
           EXPERIENCE, 
           SUM(SALARY) OVER (ORDER BY SALARY) AS TOT_SAL
FROM T2) T
WHERE TOT_SAL<= (70000-(SELECT COALESCE(MAX(TOT_SAL),0) FROM T3));


# Alterante Solution
with cte as (select employee_id, experience,salary, sum(salary) over(partition by experience order by salary) as rs from Candidates)

select 'Senior' as experience, count(employee_id) as accepted_candidates from cte c where c.experience = 'Senior' and rs <= 70000
union all
select 'Junior' as experience, count(employee_id) as accepted_candidates from cte c where c.experience = 'Junior' and rs <= 70000 - ifnull((select max(rs) from cte where experience = 'Senior' and rs<=70000 ),0);


# Alternate Solution-2
with t as(
    select experience
           ,sum(salary) over(partition by experience order by salary,employee_id) as sal_cum
    from Candidates
)
,temp as(
    select experience,count(experience) as accepted_candidates, max(sal_cum) as sal
    from t
    where sal_cum<=70000 and experience='Senior'
)
,temp2 as(
    select t.experience,count(t.experience) as accepted_candidates
    from t,temp
    where sal_cum<=(70000-coalesce(sal,0)) and t.experience='Junior'
)

select coalesce(experience,'Senior') experience, accepted_candidates from temp
union
select coalesce(experience,'Junior') experience, accepted_candidates from temp2;


