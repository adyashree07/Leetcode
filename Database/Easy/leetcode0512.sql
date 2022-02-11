# https://leetcode.com/problems/game-play-analysis-ii/

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
 
# Write an SQL query to report the device that is first logged in for each player.
# Return the result table in any order.

# My Solution
SELECT PLAYER_ID, DEVICE_ID FROM (
    SELECT PLAYER_ID, 
           DEVICE_ID,
           ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RNK
    FROM ACTIVITY) T
WHERE RNK=1;

