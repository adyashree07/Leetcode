# https://leetcode.com/problems/grand-slam-titles/

# Table: Players
# +----------------+---------+
# | Column Name    | Type    |
# +----------------+---------+
# | player_id      | int     |
# | player_name    | varchar |
# +----------------+---------+
# player_id is the primary key for this table.
# Each row in this table contains the name and the ID of a tennis player.
 
# Table: Championships
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | year          | int     |
# | Wimbledon     | int     |
# | Fr_open       | int     |
# | US_open       | int     |
# | Au_open       | int     |
# +---------------+---------+
# year is the primary key for this table.
# Each row of this table contains the IDs of the players who won one each tennis tournament of the grand slam.
 
# Write an SQL query to report the number of grand slam tournaments won by each player. Do not include the players who did not win any tournament.
# Return the result table in any order.

# My Solution
WITH T1 AS (
    SELECT P.PLAYER_ID, 
           P.PLAYER_NAME,
           COUNT(C.WIMBLEDON) AS PRIZE_COUNT
    FROM PLAYERS P JOIN CHAMPIONSHIPS C
    ON P.PLAYER_ID = C.WIMBLEDON 
    GROUP BY P.PLAYER_ID
    UNION ALL 
    SELECT P.PLAYER_ID, 
               P.PLAYER_NAME,
               COUNT(C.FR_OPEN) AS PRIZE_COUNT
    FROM PLAYERS P JOIN CHAMPIONSHIPS C
    ON P.PLAYER_ID = C.FR_OPEN 
    GROUP BY P.PLAYER_ID
    UNION ALL
    SELECT P.PLAYER_ID, 
               P.PLAYER_NAME,
               COUNT(C.US_OPEN) AS PRIZE_COUNT
    FROM PLAYERS P JOIN CHAMPIONSHIPS C
    ON P.PLAYER_ID = C.US_OPEN 
    GROUP BY P.PLAYER_ID
    UNION ALL
    SELECT P.PLAYER_ID, 
               P.PLAYER_NAME,
               COUNT(C.AU_OPEN) AS PRIZE_COUNT
    FROM PLAYERS P JOIN CHAMPIONSHIPS C
    ON P.PLAYER_ID = C.AU_OPEN 
    GROUP BY P.PLAYER_ID)

SELECT PLAYER_ID, PLAYER_NAME, SUM(PRIZE_COUNT) AS GRAND_SLAMS_COUNT
FROM T1
GROUP BY PLAYER_ID;


# Alternate Solution
with temp as
    (select Wimbledon as id from Championships
    union all
    select Fr_open as id from Championships
    union all
    select US_open as id from Championships
    union all
    select Au_open as id from Championships)

select id as player_id, player_name, grand_slams_count
from 
(select id, count(id) as grand_slams_count from temp group by id) a
left join Players b
on id = player_id;

