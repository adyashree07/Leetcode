# https://leetcode.com/problems/all-the-pairs-with-the-maximum-number-of-common-followers/

# Table: Relations
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | user_id     | int  |
# | follower_id | int  |
# +-------------+------+
# (user_id, follower_id) is the primary key for this table.
# Each row of this table indicates that the user with ID follower_id is following the user with ID user_id.
 
# Write an SQL query to find all the pairs of users with the maximum number of common followers. In other words, if the maximum number of common followers between any two users is maxCommon, then you have to return all pairs of users that have maxCommon common followers.
# The result table should contain the pairs user1_id and user2_id where user1_id < user2_id.
# Return the result table in any order.

# My Solution
SELECT T.USER1_ID, T.USER2_ID FROM(
    SELECT R1.USER_ID AS USER1_ID, 
           R2.USER_ID AS USER2_ID, 
           DENSE_RANK() OVER (ORDER BY COUNT(R1.FOLLOWER_ID) DESC) AS RNK
    FROM RELATIONS R1 LEFT JOIN RELATIONS R2 
    ON R1.USER_ID<R2.USER_ID AND R1.FOLLOWER_ID = R2.FOLLOWER_ID 
    GROUP BY USER1_ID, USER2_ID
    HAVING COUNT(R1.FOLLOWER_ID) = COUNT(R2.FOLLOWER_ID)) T
WHERE T.RNK=1;


# Alternate Solution
with cte as
(
select distinct t1.user_id as user1_id, t2.user_id as user2_id, count(*) as cnt
from Relations as t1
join Relations as t2
on t1.user_id < t2.user_id 
and t1.follower_id =t2.follower_id 
group by 1,2
)

select user1_id, user2_id
from cte
where cnt = (select max(cnt) from cte);

