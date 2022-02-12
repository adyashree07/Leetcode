# https://leetcode.com/problems/tournament-winners/

# Table: Players
# +-------------+-------+
# | Column Name | Type  |
# +-------------+-------+
# | player_id   | int   |
# | group_id    | int   |
# +-------------+-------+
# player_id is the primary key of this table.
# Each row of this table indicates the group of each player.

# Table: Matches
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | match_id      | int     |
# | first_player  | int     |
# | second_player | int     | 
# | first_score   | int     |
# | second_score  | int     |
# +---------------+---------+
# match_id is the primary key of this table.
# Each row is a record of a match, first_player and second_player contain the player_id of each match.
# first_score and second_score contain the number of points of the first_player and second_player respectively.
# You may assume that, in each match, players belong to the same group.
 
# The winner in each group is the player who scored the maximum total points within the group. In the case of a tie, the lowest player_id wins.
# Write an SQL query to find the winner in each group.
# Return the result table in any order.

# My Solution
WITH T AS (
    SELECT FIRST_PLAYER AS PLAYER, 
           FIRST_SCORE AS SCORE
    FROM MATCHES
    UNION ALL
    SELECT SECOND_PLAYER AS PLAYER, 
           SECOND_SCORE AS SCORE
    FROM MATCHES)

SELECT GROUP_ID,
       PLAYER AS PLAYER_ID
FROM (
    SELECT *,
       ROW_NUMBER() OVER (PARTITION BY GROUP_ID ORDER BY TOTAL_SCORE DESC, PLAYER) AS RNK
    FROM (
        SELECT P.GROUP_ID, 
               T.PLAYER, 
               SUM(T.SCORE) AS TOTAL_SCORE
               #DENSE_RANK() OVER (PARTITION BY P.GROUP_ID ORDER BY T.SCORE DESC) AS RNK
        FROM PLAYERS P JOIN T
        ON P.PLAYER_ID = T.PLAYER
        GROUP BY T.PLAYER) T1) T2
WHERE RNK=1;


# Alternate Solution
with cte1 as (
 select match_id, first_player as player,first_score as score from Matches
 union all
 select match_id, second_player as player,second_score as score from Matches
)

select group_id, 
       first_value(player_id) over (partition by group_id order by score desc, player_id) as player_id
from 
 (select b.group_id,
         sum(a.score) as score,
         player_id
   from cte1 a join players b 
   on a.player=b.player_id
   group by player_id
   order by 1,2 desc,player_id) e
group by group_id;

