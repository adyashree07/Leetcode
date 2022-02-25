# https://leetcode.com/problems/the-change-in-global-rankings/

# Table: TeamPoints
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | team_id     | int     |
# | name        | varchar |
# | points      | int     |
# +-------------+---------+
# team_id is the primary key for this table.
# Each row of this table contains the ID of a national team, the name of the country it represents, and the points it has in the global rankings. No two teams will represent the same country.
 
# Table: PointsChange
# +---------------+------+
# | Column Name   | Type |
# +---------------+------+
# | team_id       | int  |
# | points_change | int  |
# +---------------+------+
# team_id is the primary key for this table.
# Each row of this table contains the ID of a national team and the change in its points in the global rankings.
# points_change can be:
# - 0: indicates no change in points.
# - positive: indicates an increase in points.
# - negative: indicates a decrease in points.
# Each team_id that appears in TeamPoints will also appear in this table.
 
# The global ranking of a national team is its rank after sorting all the teams by their points in descending order. If two teams have the same points, we break the tie by sorting them by their name in lexicographical order.
# The points of each national team should be updated based on its corresponding points_change value.

# Write an SQL query to calculate the change in the global rankings after updating each team's points.
# Return the result table in any order.

# My Solution
WITH T1 AS (
    SELECT T.*, 
           ROW_NUMBER() OVER (ORDER BY T.POINTS DESC, NAME) AS RNK1,
           ROW_NUMBER() OVER (ORDER BY (T.POINTS+P.POINTS_CHANGE) DESC, NAME) AS RNK2
    FROM TEAMPOINTS T JOIN POINTSCHANGE P
    ON T.TEAM_ID=P.TEAM_ID)

SELECT TEAM_ID, 
       NAME, 
       (CAST(T1.RNK1 AS SIGNED)-CAST(T1.RNK2 AS SIGNED)) AS RANK_DIFF 
FROM T1;

