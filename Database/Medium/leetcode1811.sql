# https://leetcode.com/problems/find-interview-candidates/

# Table: Contests
# +--------------+------+
# | Column Name  | Type |
# +--------------+------+
# | contest_id   | int  |
# | gold_medal   | int  |
# | silver_medal | int  |
# | bronze_medal | int  |
# +--------------+------+
# contest_id is the primary key for this table.
# This table contains the LeetCode contest ID and the user IDs of the gold, silver, and bronze medalists.
# It is guaranteed that any consecutive contests have consecutive IDs and that no ID is skipped.
 
# Table: Users
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | user_id     | int     |
# | mail        | varchar |
# | name        | varchar |
# +-------------+---------+
# user_id is the primary key for this table.
# This table contains information about the users.
 
# Write an SQL query to report the name and the mail of all interview candidates. A user is an interview candidate if at least one of these two conditions is true:
# 1. The user won any medal in three or more consecutive contests.
# 2. The user won the gold medal in three or more different contests (not necessarily consecutive).
# Return the result table in any order.

# My Solution
WITH CTE AS (
    SELECT U.USER_ID, 
           U.MAIL,
           U.NAME,
           C.CONTEST_ID,
           CASE WHEN U.USER_ID IN (C.GOLD_MEDAL) OR U.USER_ID IN (C.SILVER_MEDAL) OR U.USER_ID IN (C.BRONZE_MEDAL) THEN 1
                ELSE 0 
           END AS MEDAL_WON
FROM USERS U, CONTESTS C 
ORDER BY U.USER_ID, C.CONTEST_ID),
T AS (
SELECT USER_ID, 
       NAME, 
       MAIL,
       CONTEST_ID-ROW_NUMBER() OVER (PARTITION BY USER_ID ORDER BY CONTEST_ID) AS CNT 
FROM CTE WHERE MEDAL_WON=1)

SELECT DISTINCT NAME, MAIL FROM (
    SELECT USER_ID, 
           NAME, 
           MAIL, 
           CNT,
           COUNT(*) OVER (PARTITION BY USER_ID, CNT) AS NEW_CNT FROM T) T1
WHERE T1.NEW_CNT>=3
UNION 
SELECT U.NAME, U.MAIL FROM CONTESTS C
JOIN USERS U ON C.GOLD_MEDAL = U.USER_ID
GROUP BY C.GOLD_MEDAL
HAVING COUNT(C.GOLD_MEDAL)>=3;


# Alternate Solution
with t1 as(
    select user_id, (contest_id - row_number() over(partition by user_id order by contest_id)) diff
    from
    (
        select contest_id 
            ,gold_medal as user_id
            ,'gold_medal' as medal
        from Contests
        union
        select contest_id 
            ,silver_medal as user_id
            ,'silver_medal' as medal
        from Contests
        union
        select contest_id 
            ,bronze_medal as user_id
            ,'bronze_medal' as medal
        from Contests
    )t
)
select name,  mail 
from
(
    select distinct user_id from(
    select user_id, count(*) over(partition by user_id,diff) as cnt
    from t1)t2
    where cnt>=3
    union
    select distinct gold_medal as user_id from Contests 
    group by gold_medal
    having count(gold_medal)>=3
)temp
left join Users u
on u.user_id=temp.user_id;


# Alternate Solution-2
WITH a AS(SELECT contest_id, gold_medal as user_id
FROM Contests
UNION ALL 
SELECT contest_id, silver_medal as user_id
FROM Contests
UNION ALL 
SELECT contest_id, bronze_medal as user_id
FROM Contests),

b AS(SELECT a.user_id
FROM a
JOIN a b
ON a.contest_id = b.contest_id - 1 AND a.user_id = b.user_id
JOIN a c
ON b.contest_id = c.contest_id - 1 AND b.user_id = c.user_id
UNION 
SELECT gold_medal as user_id
FROM Contests
GROUP BY 1
HAVING COUNT(*)>=3)

SELECT name, mail
FROM Users
WHERE user_id IN (SELECT * FROM b);

