# https://leetcode.com/problems/page-recommendations-ii/

# Table: Friendship
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | user1_id      | int     |
# | user2_id      | int     |
# +---------------+---------+
# (user1_id, user2_id) is the primary key for this table.
# Each row of this table indicates that the users user1_id and user2_id are friends.
 
# Table: Likes
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | user_id     | int     |
# | page_id     | int     |
# +-------------+---------+
# (user_id, page_id) is the primary key for this table.
# Each row of this table indicates that user_id likes page_id.
 
# You are implementing a page recommendation system for a social media website. Your system will recommended a page to user_id if the page is liked by at least one friend of user_id and is not liked by user_id.
# Write an SQL query to find all the possible page recommendations for every user. Each recommendation should appear as a row in the result table with these columns:
# 1. user_id: The ID of the user that your system is making the recommendation to.
# 2. page_id: The ID of the page that will be recommended to user_id.
# 3. friends_likes: The number of the friends of user_id that like page_id.
# Return result table in any order.

# My Solution
WITH T1 AS (
    SELECT * FROM FRIENDSHIP
    UNION ALL
    SELECT USER2_ID, USER1_ID FROM FRIENDSHIP),
T2 AS (
    SELECT T1.*, L.PAGE_ID 
    FROM T1 JOIN LIKES L
    ON T1.USER2_ID = L.USER_ID
    ORDER BY T1.USER1_ID),
T3 AS (
    SELECT DISTINCT T1.USER1_ID, L.PAGE_ID 
    FROM T1 JOIN LIKES L
    ON T1.USER1_ID = L.USER_ID
    ORDER BY T1.USER1_ID)
    
SELECT USER1_ID AS USER_ID, 
       PAGE_ID, 
       COUNT(USER2_ID) AS FRIENDS_LIKES
FROM (
    SELECT DISTINCT * FROM T2 
    WHERE (USER1_ID, PAGE_ID) NOT IN (SELECT USER1_ID,PAGE_ID FROM T3) 
    ORDER BY USER1_ID) T
GROUP BY USER1_ID, PAGE_ID;


# Alternate Solution
with temp as (
  select * from friendship
  union
  select user2_id, user1_id from friendship),
temp2 as (
  select a.user1_id, 
         b.page_id, 
         count(a.user2_id) fl
  from temp a
  left join likes b
  on a.user2_id = b.user_id
  group by 1,2
  )

select a.user1_id as user_id, 
       a.page_id, 
       fl as friends_likes from
temp2 a
left join likes b
on a.user1_id = b.user_id
and a.page_id = b.page_id
where user_id is null;

