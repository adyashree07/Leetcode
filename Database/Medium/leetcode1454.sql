# https://leetcode.com/problems/active-users/

# Table: Accounts
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | id            | int     |
# | name          | varchar |
# +---------------+---------+
# id is the primary key for this table.
# This table contains the account id and the user name of each account.
 
# Table: Logins
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | id            | int     |
# | login_date    | date    |
# +---------------+---------+
# There is no primary key for this table, it may contain duplicates.
# This table contains the account id of the user who logged in and the login date. A user may log in multiple times in the day.
 
# Active users are those who logged in to their accounts for five or more consecutive days.
# Write an SQL query to find the id and the name of active users.
# Return the result table ordered by id.

# My Solution
WITH T1 AS (
    SELECT DISTINCT * 
    FROM LOGINS),
T2 AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY ID ORDER BY LOGIN_DATE) AS RNK1
    FROM (
        SELECT *,
              LAG(LOGIN_DATE) OVER (PARTITION BY ID ORDER BY LOGIN_DATE) AS LAG_DATE
        FROM T1) T
    WHERE LAG_DATE IS NOT NULL),
T3 AS (
    SELECT *,
           RNK1 - ROW_NUMBER() OVER (PARTITION BY ID ORDER BY LOGIN_DATE) AS DIFF 
    FROM T2
    WHERE DATEDIFF(LOGIN_DATE,LAG_DATE)=1)
   
SELECT DISTINCT T3.ID, A.NAME
FROM T3 JOIN ACCOUNTS A
ON T3.ID = A.ID
GROUP BY T3.ID, DIFF
HAVING COUNT(*)>=4
ORDER BY T3.ID;


# Alternate Solution
with distinctlogin as(select distinct id,login_date
from logins)
select distinct a.id,a.name
from accounts as a
inner join (select id, login_date, lead(login_date,4) over(partition by id order by login_date) as next_date
from distinctlogin)tbl
on a.id = tbl.id
where next_date is not null and next_date = date_add(login_date,interval 4 day)
order by a.id;

