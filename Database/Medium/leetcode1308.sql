# https://leetcode.com/problems/running-total-for-different-genders/

# Table: Scores
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | player_name   | varchar |
# | gender        | varchar |
# | day           | date    |
# | score_points  | int     |
# +---------------+---------+
# (gender, day) is the primary key for this table.
# A competition is held between the female team and the male team.
# Each row of this table indicates that a player_name and with gender has scored score_point in someday.
# Gender is 'F' if the player is in the female team and 'M' if the player is in the male team.
 
# Write an SQL query to find the total score for each gender on each day.
# Return the result table ordered by gender and day in ascending order.

# My Solution
SELECT GENDER, 
       DAY, 
       SUM(SCORE_POINTS) OVER (PARTITION BY GENDER ORDER BY GENDER, DAY) AS TOTAL
FROM SCORES
GROUP BY GENDER, DAY
ORDER BY GENDER, DAY;

