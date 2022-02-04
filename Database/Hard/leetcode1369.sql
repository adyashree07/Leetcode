# https://leetcode.com/problems/get-the-second-most-recent-activity/

# Table: UserActivity
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | username      | varchar |
# | activity      | varchar |
# | startDate     | Date    |
# | endDate       | Date    |
# +---------------+---------+
# There is no primary key for this table. It may contain duplicates.
# This table contains information about the activity performed by each user in a period of time.
# A person with username performed an activity from startDate to endDate.
 
# Write an SQL query to show the second most recent activity of each user.
# If the user only has one activity, return that one. A user cannot perform more than one activity at the same time.
# Return the result table in any order.

# My Solution
WITH CTE AS (
    SELECT T.USERNAME, T.ACTIVITY, T.STARTDATE, T.ENDDATE FROM
    (SELECT *, DENSE_RANK() OVER (PARTITION BY USERNAME ORDER BY ENDDATE DESC) AS RNK FROM USERACTIVITY) T
WHERE RNK=2)

SELECT * FROM USERACTIVITY WHERE USERNAME NOT IN (SELECT USERNAME FROM CTE)
UNION 
SELECT * FROM CTE;

