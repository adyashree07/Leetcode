# https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/

# Table: RequestAccepted
# +----------------+---------+
# | Column Name    | Type    |
# +----------------+---------+
# | requester_id   | int     |
# | accepter_id    | int     |
# | accept_date    | date    |
# +----------------+---------+
# (requester_id, accepter_id) is the primary key for this table.
# This table contains the ID of the user who sent the request, the ID of the user who received the request, and the date when the request was accepted.
 
# Write an SQL query to find the people who have the most friends and the most friends number.
# The test cases are generated so that only one person has the most friends.

# My Solution
WITH T1 AS (
    SELECT REQUESTER_ID AS REQUEST_ID, 
           ACCEPTER_ID AS ACCEPT_ID
    FROM REQUESTACCEPTED),
T2 AS (
    SELECT ACCEPTER_ID AS REQUEST_ID,
           REQUESTER_ID AS ACCEPT_ID       
    FROM REQUESTACCEPTED)
    
SELECT DISTINCT REQUEST_ID AS ID,
                COUNT(REQUEST_ID) OVER (PARTITION BY REQUEST_ID) AS NUM 
FROM (
    SELECT DISTINCT * FROM T1
    UNION
    SELECT DISTINCT * FROM T2) T
ORDER BY NUM DESC
LIMIT 1;

