# https://leetcode.com/problems/game-play-analysis-iii/

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
 
# Write an SQL query to report for each player and date, how many games played so far by the player. That is, the total number of games played by the player until that date. Check the example for clarity.
# Return the result table in any order.

# My Solution
SELECT PLAYER_ID, 
       EVENT_DATE, 
       SUM(GAMES_PLAYED) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS GAMES_PLAYED_SO_FAR
FROM ACTIVITY;

