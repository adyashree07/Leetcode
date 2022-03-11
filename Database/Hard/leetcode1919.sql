# https://leetcode.com/problems/leetcodify-similar-friends/

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
 
# Write an SQL query to report the similar friends of Leetcodify users. A user x and user y are similar friends if:
# 1. Users x and y are friends, and
# 2. Users x and y listened to the same three or more different songs on the same day.
# Return the result table in any order. Note that you must return the similar pairs of friends the same way they were represented in the input (i.e., always user1_id < user2_id).

# My Solution
SELECT DISTINCT USER1_ID, USER2_ID FROM (
    SELECT F.USER1_ID,
            F.USER2_ID,
            L1.SONG_ID,
            L1.DAY
FROM FRIENDSHIP F JOIN LISTENS L1
ON F.USER1_ID=L1.USER_ID
JOIN LISTENS L2
ON F.USER2_ID = L2.USER_ID AND L1.DAY = L2.DAY AND L1.SONG_ID= L2.SONG_ID) T
GROUP BY USER1_ID, USER2_ID, DAY
HAVING COUNT(DISTINCT SONG_ID)>=3;


# Alternate Solution
WITH record AS (
  SELECT
      a.user_id AS user1_id,
      b.user_id AS user2_id
  FROM listens a INNER JOIN listens b
  ON
      a.user_id < b.user_id AND
      a.song_id = b.song_id AND
      a.day = b.day
  GROUP BY
      a.user_id, 
      b.user_id, 
      a.day
  HAVING COUNT(DISTINCT a.song_id) >= 3
  )

SELECT DISTINCT
    f.user1_id,
    f.user2_id
FROM friendship AS f INNER JOIN record 
USING(user1_id, user2_id);

