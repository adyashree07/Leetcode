# https://leetcode.com/problems/actors-and-directors-who-cooperated-at-least-three-times/

# Table: ActorDirector
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | actor_id    | int     |
# | director_id | int     |
# | timestamp   | int     |
# +-------------+---------+
# timestamp is the primary key column for this table.
 
# Write a SQL query for a report that provides the pairs (actor_id, director_id) where the actor has cooperated with the director at least three times.

# My Solution
SELECT ACTOR_ID,
       DIRECTOR_ID
FROM ACTORDIRECTOR
GROUP BY 1,2
HAVING COUNT(TIMESTAMP)>=3;

