# https://leetcode.com/problems/second-degree-follower/

# Table: Follow
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | followee    | varchar |
# | follower    | varchar |
# +-------------+---------+
# (followee, follower) is the primary key column for this table.
# Each row of this table indicates that the user follower follows the user followee on a social network.
# There will not be a user following themself.
 
# A second-degree follower is a user who:
# 1. follows at least one user, and
# 2. is followed by at least one user.
# Write an SQL query to report the second-degree users and the number of their followers.
# Return the result table ordered by follower in alphabetical order.

# My Solution
WITH T1 AS (
    SELECT DISTINCT F1.FOLLOWEE FROM FOLLOW F1 JOIN FOLLOW F2
    ON F1.FOLLOWEE = F2.FOLLOWER)
    
SELECT T1.FOLLOWEE  AS FOLLOWER, COUNT(F.FOLLOWEE) AS NUM FROM T1
LEFT JOIN FOLLOW F 
ON T1.FOLLOWEE = F.FOLLOWEE
GROUP BY T1.FOLLOWEE
ORDER BY T1.FOLLOWEE;


# Alternate Solution
select followee as follower,count(followee) num
from Follow
where followee <> follower
and followee in (select distinct follower from Follow)
group by followee
order by follower;

