# https://leetcode.com/problems/leetcodify-friends-recommendations/

# Table: Listens
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | user_id     | int     |
# | song_id     | int     |
# | day         | date    |
# +-------------+---------+
# There is no primary key for this table. It may contain duplicates.
# Each row of this table indicates that the user user_id listened to the song song_id on the day day.
 
# Table: Friendship
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | user1_id      | int     |
# | user2_id      | int     |
# +---------------+---------+
# (user1_id, user2_id) is the primary key for this table.
# Each row of this table indicates that the users user1_id and user2_id are friends.
# Note that user1_id < user2_id.
 
# Write an SQL query to recommend friends to Leetcodify users. We recommend user x to user y if:
# 1. Users x and y are not friends, and
# 2. Users x and y listened to the same three or more different songs on the same day.
# Note that friend recommendations are unidirectional, meaning if user x and user y should be recommended to each other, the result table should have both user x recommended to user y and user y recommended to user x. Also, note that the result table should not contain duplicates (i.e., user y should not be recommended to user x multiple times.).
# Return the result table in any order.

# My Solution
WITH T1 AS (
    SELECT DISTINCT L1.USER_ID AS USER1,
           L2.USER_ID AS USER2,
           L1.SONG_ID,
           L1.DAY
    FROM LISTENS L1 JOIN LISTENS L2
    ON L1.SONG_ID = L2.SONG_ID AND L1.DAY = L2.DAY
    )
SELECT DISTINCT USER1 AS USER_ID, 
       USER2 AS RECOMMENDED_ID
FROM T1
WHERE USER1!=USER2 AND CONCAT(USER1,'-',USER2) NOT IN (SELECT CONCAT(USER1_ID,'-',USER2_ID) FROM FRIENDSHIP)
AND CONCAT(USER2,'-',USER1) NOT IN (SELECT CONCAT(USER1_ID,'-',USER2_ID) FROM FRIENDSHIP)
GROUP BY USER1, USER2, DAY
HAVING COUNT(DISTINCT SONG_ID)>=3;


# Alternate Solution
with t as( 
    select * from friendship
    union all 
    select user2_id, user1_id from friendship
)
select distinct a.user_id user_id
                ,b.user_id recommended_id
from Listens a,Listens b
where a.song_id=b.song_id 
    and a.day =b.day 
    and a.user_id<>b.user_id
    and concat(a.user_id,",",b.user_id) not in (select concat(user1_id,",",user2_id) from t)
group by a.user_id , b.user_id,a.day
having count(distinct a.song_id)>=3;


# Alternate Solution-2
WITH CTE AS (
SELECT * FROM FRIENDSHIP 
UNION ALL 
SELECT USER2_ID, USER1_ID FROM FRIENDSHIP
)
SELECT DISTINCT  L1.USER_ID AS USER_ID,
        L2.USER_ID AS RECOMMENDED_ID
FROM LISTENS L1
JOIN LISTENS L2 ON L1.DAY = L2.DAY AND L1.SONG_ID = L2.SONG_ID AND L1.USER_ID != L2.USER_ID AND 
CONCAT(L1.USER_ID,",",L2.USER_ID) NOT IN (SELECT CONCAT(USER1_ID,",",USER2_ID) FROM CTE)
GROUP BY L1.USER_ID,L2.USER_ID,L1.DAY
HAVING COUNT(DISTINCT L1.SONG_ID) >=3;

