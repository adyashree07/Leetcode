# https://leetcode.com/problems/page-recommendations/

# Table: Friendship
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | user1_id      | int     |
# | user2_id      | int     |
# +---------------+---------+
# (user1_id, user2_id) is the primary key for this table.
# Each row of this table indicates that there is a friendship relation between user1_id and user2_id.
 
# Table: Likes
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | user_id     | int     |
# | page_id     | int     |
# +-------------+---------+
# (user_id, page_id) is the primary key for this table.
# Each row of this table indicates that user_id likes page_id.
 
# Write an SQL query to recommend pages to the user with user_id = 1 using the pages that your friends liked. It should not recommend pages you already liked.
# Return result table in any order without duplicates.

# My Solution
WITH T1 AS (
    SELECT USER1_ID AS USER_ID FROM FRIENDSHIP WHERE USER2_ID=1
    UNION 
    SELECT USER2_ID AS USER_ID FROM FRIENDSHIP WHERE USER1_ID=1)
SELECT DISTINCT L.PAGE_ID AS RECOMMENDED_PAGE 
FROM T1 INNER JOIN LIKES L 
ON T1.USER_ID=L.USER_ID 
WHERE PAGE_ID NOT IN (SELECT PAGE_ID FROM LIKES WHERE USER_ID=1);

