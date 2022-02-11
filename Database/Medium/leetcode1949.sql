# https://leetcode.com/problems/strong-friendship/

# Table: Friendship
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | user1_id    | int  |
# | user2_id    | int  |
# +-------------+------+
# (user1_id, user2_id) is the primary key for this table.
# Each row of this table indicates that the users user1_id and user2_id are friends.
# Note that user1_id < user2_id.
 
# A friendship between a pair of friends x and y is strong if x and y have at least three common friends.
# Write an SQL query to find all the strong friendships.
# Note that the result table should not contain duplicates with user1_id < user2_id.
# Return the result table in any order.

# My Solution
WITH T AS (
    SELECT USER1_ID, USER2_ID FROM FRIENDSHIP 
    UNION ALL
    SELECT USER2_ID, USER1_ID FROM FRIENDSHIP )
SELECT T1.USER1_ID, 
    T2.USER1_ID AS USER2_ID, 
    COUNT(*) AS COMMON_FRIEND
FROM T T1 LEFT JOIN T T2
ON T1.USER1_ID<T2.USER1_ID AND T1.USER2_ID=T2.USER2_ID
WHERE (T1.USER1_ID,T2.USER1_ID) IN (SELECT * FROM FRIENDSHIP)
GROUP BY T1.USER1_ID,T2.USER1_ID
HAVING COMMON_FRIEND>=3;


# Alternate Solution
with cte as (select user1_id, user2_id
             from Friendship
             union
             select user2_id as user1_id, user1_id as user2_id
             from Friendship
)
select f1.user1_id,
       f1.user2_id,
       count(distinct f3.user2_id) as common_friend
from Friendship f1
join cte f2 on f1.user2_id = f2.user1_id
join cte f3 on f1.user1_id = f3.user1_id and f2.user2_id = f3.user2_id
group by 1,2
having count(distinct f3.user2_id) >= 3;

