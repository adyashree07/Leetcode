# https://leetcode.com/problems/activity-participants/

# Table: Friends
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | id            | int     |
# | name          | varchar |
# | activity      | varchar |
# +---------------+---------+
# id is the id of the friend and primary key for this table.
# name is the name of the friend.
# activity is the name of the activity which the friend takes part in.
 
# Table: Activities
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | id            | int     |
# | name          | varchar |
# +---------------+---------+
# id is the primary key for this table.
# name is the name of the activity.
 
# Write an SQL query to find the names of all the activities with neither the maximum nor the minimum number of participants.
# Each activity in the Activities table is performed by any person in the table Friends.
# Return the result table in any order.

# My Solution
WITH CTE AS (
    SELECT ACTIVITY, COUNT(ACTIVITY) AS CNT FROM FRIENDS GROUP BY ACTIVITY)
SELECT ACTIVITY FROM CTE WHERE CNT != (SELECT MAX(CNT) FROM CTE) AND CNT != (SELECT MIN(CNT) FROM CTE);
