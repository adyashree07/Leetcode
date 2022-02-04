# https://leetcode.com/problems/the-latest-login-in-2020/

# Table: Logins
# +----------------+----------+
# | Column Name    | Type     |
# +----------------+----------+
# | user_id        | int      |
# | time_stamp     | datetime |
# +----------------+----------+
# (user_id, time_stamp) is the primary key for this table.
# Each row contains information about the login time for the user with ID user_id.
 
# Write an SQL query to report the latest login for all users in the year 2020. Do not include the users who did not login in 2020.
# Return the result table in any order.

# My Solution
SELECT T.USER_ID, T.LAST_STAMP FROM (
    SELECT USER_ID, 
           TIME_STAMP AS LAST_STAMP, 
           DENSE_RANK() OVER (PARTITION BY USER_ID ORDER BY TIME_STAMP DESC) AS RNK 
    FROM LOGINS WHERE YEAR(TIME_STAMP)=2020) T
WHERE RNK=1;


# Alternate Solution
select user_id,max(time_stamp) as last_stamp
from Logins
where time_stamp like '2020%'
group by user_id;

