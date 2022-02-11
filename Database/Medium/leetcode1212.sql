# https://leetcode.com/problems/team-scores-in-football-tournament/

# Table: Teams
# +---------------+----------+
# | Column Name   | Type     |
# +---------------+----------+
# | team_id       | int      |
# | team_name     | varchar  |
# +---------------+----------+
# team_id is the primary key of this table.
# Each row of this table represents a single football team.
 
# Table: Matches
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | match_id      | int     |
# | host_team     | int     |
# | guest_team    | int     | 
# | host_goals    | int     |
# | guest_goals   | int     |
# +---------------+---------+
# match_id is the primary key of this table.
# Each row is a record of a finished match between two different teams. 
# Teams host_team and guest_team are represented by their IDs in the Teams table (team_id), and they scored host_goals and guest_goals goals, respectively.
 
# You would like to compute the scores of all teams after all matches. Points are awarded as follows:
# 1. A team receives three points if they win a match (i.e., Scored more goals than the opponent team).
# 2. A team receives one point if they draw a match (i.e., Scored the same number of goals as the opponent team).
# 3. A team receives no points if they lose a match (i.e., Scored fewer goals than the opponent team).
# Write an SQL query that selects the team_id, team_name and num_points of each team in the tournament after all described matches.
# Return the result table ordered by num_points in decreasing order. In case of a tie, order the records by team_id in increasing order.

# My Solution
WITH CTE AS (
    SELECT HOST_TEAM AS TEAM,
           CASE WHEN HOST_GOALS > GUEST_GOALS THEN 3
                WHEN HOST_GOALS = GUEST_GOALS THEN 1
                ELSE 0
           END AS POINTS
    FROM MATCHES
    UNION ALL
    SELECT GUEST_TEAM AS TEAM,
           CASE WHEN HOST_GOALS < GUEST_GOALS THEN 3
                WHEN HOST_GOALS = GUEST_GOALS THEN 1
                ELSE 0
           END AS POINTS
    FROM MATCHES)
SELECT T.TEAM_ID, T.TEAM_NAME, 
       COALESCE(SUM(T1.POINTS),0) AS NUM_POINTS
FROM TEAMS T LEFT JOIN CTE T1
ON T.TEAM_ID = T1.TEAM
GROUP BY T.TEAM_ID
ORDER BY NUM_POINTS DESC, TEAM_ID;

