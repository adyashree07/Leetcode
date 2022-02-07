# https://leetcode.com/problems/reported-posts/

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
 
# Write an SQL query that reports the number of posts reported yesterday for each report reason. Assume today is 2019-07-05.
# Return the result table in any order.

# My Solution
SELECT DISTINCT EXTRA AS REPORT_REASON, 
      COUNT(DISTINCT POST_ID, EXTRA) AS REPORT_COUNT 
FROM ACTIONS 
WHERE ACTION_DATE = "2019-07-04" AND (ACTION="report")
GROUP BY EXTRA;

