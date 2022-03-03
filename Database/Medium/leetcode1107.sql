# https://leetcode.com/problems/new-users-daily-count/

# Table: Traffic
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | user_id       | int     |
# | activity      | enum    |
# | activity_date | date    |
# +---------------+---------+
# There is no primary key for this table, it may have duplicate rows.
# The activity column is an ENUM type of ('login', 'logout', 'jobs', 'groups', 'homepage').
 
# Write an SQL query to reports for every date within at most 90 days from today, the number of users that logged in for the first time on that date. Assume today is 2019-06-30.
# Return the result table in any order.

# My Solution
SELECT LOGIN_DATE, 
       COUNT(USER_ID) AS USER_COUNT FROM (
    SELECT ACTIVITY_DATE AS LOGIN_DATE,
           USER_ID,
           ROW_NUMBER() OVER (PARTITION BY USER_ID ORDER BY ACTIVITY_DATE) AS RNK
    FROM TRAFFIC 
    WHERE ACTIVITY="login") T
WHERE RNK=1 AND DATEDIFF("2019-06-30",LOGIN_DATE)<=90
GROUP BY LOGIN_DATE;


# Alternate Solution
select login_date,count(1) as user_count
from (select user_id,min(activity_date) as login_date
     from traffic
     where activity='login'
     group by user_id ) as m
where login_date>=date_add('2019-06-30',interval-90 day) and login_date<='2019-06-30'
group by login_date;

