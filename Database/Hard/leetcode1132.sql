# https://leetcode.com/problems/reported-posts-ii/

# Table: Actions
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | user_id       | int     |
# | post_id       | int     |
# | action_date   | date    | 
# | action        | enum    |
# | extra         | varchar |
# +---------------+---------+
# There is no primary key for this table, it may have duplicate rows.
# The action column is an ENUM type of ('view', 'like', 'reaction', 'comment', 'report', 'share').
# The extra column has optional information about the action, such as a reason for the report or a type of reaction.
 
# Table: Removals
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | post_id       | int     |
# | remove_date   | date    | 
# +---------------+---------+
# post_id is the primary key of this table.
# Each row in this table indicates that some post was removed due to being reported or as a result of an admin review.
 
# Write an SQL query to find the average daily percentage of posts that got removed after being reported as spam, rounded to 2 decimal places.

# My Solution
WITH T1 AS (
    SELECT POST_ID, ACTION_DATE
    FROM ACTIONS 
    WHERE EXTRA="spam"),
T2 AS (
    SELECT T1.ACTION_DATE, 
           COUNT(DISTINCT T1.POST_ID) AS TOTAL,
           COALESCE(COUNT(DISTINCT R.POST_ID),0) AS REMOVED
    FROM T1 LEFT JOIN REMOVALS R
    ON T1.POST_ID = R.POST_ID
    GROUP BY T1.ACTION_DATE)

SELECT ROUND(AVG(REMOVED_PERCENT),2) AS AVERAGE_DAILY_PERCENT 
FROM (
    SELECT ACTION_DATE, (REMOVED/TOTAL)*100 AS REMOVED_PERCENT
    FROM T2
    GROUP BY ACTION_DATE) T;
    
   
# Alternate Solution
select round(avg(daily_percent),2) average_daily_percent from(
select a.action_date, count(distinct r.post_id)/count(distinct a.post_id)*100 as daily_percent
from Actions a
left join Removals r
on a.post_id=r.post_id
where extra ='spam'
group by a.action_date) t;

