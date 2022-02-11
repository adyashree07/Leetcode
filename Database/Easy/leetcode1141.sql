# https://leetcode.com/problems/user-activity-for-the-past-30-days-i/

# Table: Activity
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | user_id       | int     |
# | session_id    | int     |
# | activity_date | date    |
# | activity_type | enum    |
# +---------------+---------+
# There is no primary key for this table, it may have duplicate rows.
# The activity_type column is an ENUM of type ('open_session', 'end_session', 'scroll_down', 'send_message').
# The table shows the user activities for a social media website. 
# Note that each session belongs to exactly one user.
 
# Write an SQL query to find the daily active user count for a period of 30 days ending 2019-07-27 inclusively. A user was active on someday if they made at least one activity on that day.
# Return the result table in any order.

# My Solution
WITH RECURSIVE R AS (
SELECT "2019-07-27" AS DATE
UNION 
SELECT DATE - INTERVAL 1 DAY FROM R WHERE DATE>"2019-06-28")

SELECT ACTIVITY_DATE AS DAY, 
       COUNT(DISTINCT USER_ID) AS ACTIVE_USERS
FROM ACTIVITY
WHERE ACTIVITY_DATE IN (SELECT DATE FROM R)
GROUP BY ACTIVITY_DATE;


# Alternate Solution
select activity_date day ,count(distinct user_id) active_users 
from Activity
where activity_date between '2019-06-28' and '2019-07-27'
group by activity_date;

