# https://leetcode.com/problems/game-play-analysis-iv/

# Table: Activity
# +--------------+---------+
# | Column Name  | Type    |
# +--------------+---------+
# | player_id    | int     |
# | device_id    | int     |
# | event_date   | date    |
# | games_played | int     |
# +--------------+---------+
# (player_id, event_date) is the primary key of this table.
# This table shows the activity of players of some games.
# Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
 
# Write an SQL query to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. 
# In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that number by the total number of players.

# My Solution
WITH T AS (
   SELECT *,
           LAG(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS LAG_DATE
    FROM ACTIVITY),
T2 AS (
    SELECT T.PLAYER_ID, T.LAG_DATE 
    FROM T JOIN (SELECT PLAYER_ID, MIN(LAG_DATE) AS DT FROM T GROUP BY PLAYER_ID) T1
    ON T.PLAYER_ID = T1.PLAYER_ID AND T.LAG_DATE = T1.DT
    WHERE DATEDIFF(EVENT_DATE,LAG_DATE)=1)
       
SELECT ROUND((SELECT COUNT(DISTINCT PLAYER_ID) FROM T2)/(SELECT COUNT(DISTINCT PLAYER_ID) FROM ACTIVITY),2) AS FRACTION;


# Alternate Solution
Select round(sum(is_return)/count(distinct player_id),2) as fraction from (
   select player_id, 
          min(event_date) over(partition by player_id) + 1= event_date as is_return 
   from activity)t
   
   
