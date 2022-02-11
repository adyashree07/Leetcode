# https://leetcode.com/problems/league-statistics/

# Table: Teams
# +----------------+---------+
# | Column Name    | Type    |
# +----------------+---------+
# | team_id        | int     |
# | team_name      | varchar |
# +----------------+---------+
# team_id is the primary key for this table.
# Each row contains information about one team in the league.
 
# Table: Matches
# +-----------------+---------+
# | Column Name     | Type    |
# +-----------------+---------+
# | home_team_id    | int     |
# | away_team_id    | int     |
# | home_team_goals | int     |
# | away_team_goals | int     |
# +-----------------+---------+
# (home_team_id, away_team_id) is the primary key for this table.
# Each row contains information about one match.
# home_team_goals is the number of goals scored by the home team.
# away_team_goals is the number of goals scored by the away team.
# The winner of the match is the team with the higher number of goals.
 
# Write an SQL query to report the statistics of the league. The statistics should be built using the played matches where the winning team gets three points and the losing team gets no points. If a match ends with a draw, both teams get one point.
# Each row of the result table should contain:
# 1. team_name - The name of the team in the Teams table.
# 2. matches_played - The number of matches played as either a home or away team.
# 3. points - The total points the team has so far.
# 4. goal_for - The total number of goals scored by the team across all matches.
# 5. goal_against - The total number of goals scored by opponent teams against this team across all matches.
# 6. goal_diff - The result of goal_for - goal_against.
# Return the result table ordered by points in descending order. If two or more teams have the same points, order them by goal_diff in descending order. 
# If there is still a tie, order them by team_name in lexicographical order.

# My Solution
WITH CTE AS (
    SELECT HOME_TEAM_ID, AWAY_TEAM_ID, 
           SUM(CASE WHEN HOME_TEAM_GOALS > AWAY_TEAM_GOALS THEN 3
                WHEN HOME_TEAM_GOALS = AWAY_TEAM_GOALS THEN 1
                ELSE 0
           END) OVER (PARTITION BY HOME_TEAM_ID) AS HOME_WIN,
          SUM(CASE WHEN HOME_TEAM_GOALS > AWAY_TEAM_GOALS THEN 0
               WHEN HOME_TEAM_GOALS = AWAY_TEAM_GOALS THEN 1
                ELSE 3
           END) OVER (PARTITION BY AWAY_TEAM_ID) AS AWAY_WIN,
           SUM(HOME_TEAM_GOALS) OVER (PARTITION BY HOME_TEAM_ID) AS HOME_GOAL,
           SUM(AWAY_TEAM_GOALS) OVER (PARTITION BY AWAY_TEAM_ID) AS AWAY_GOAL,
           SUM(HOME_TEAM_GOALS) OVER (PARTITION BY AWAY_TEAM_ID) AS LOST_AWAY_GOAL,
           SUM(AWAY_TEAM_GOALS) OVER (PARTITION BY HOME_TEAM_ID) AS LOST_HOME_GOAL   
    FROM MATCHES)

    
SELECT TEAM_NAME,
        MATCHES_PLAYED,
        POINTS,
        GOAL_FOR,
        GOAL_AGAINST,
        GOAL_FOR - GOAL_AGAINST AS GOAL_DIFF
FROM (
    SELECT T.TEAM_NAME, 
           COALESCE(COUNT(DISTINCT T2.HOME_TEAM_ID),0)+COALESCE(COUNT(DISTINCT T1.AWAY_TEAM_ID),0) AS MATCHES_PLAYED,
           COALESCE(T1.HOME_WIN,0) + COALESCE(T2.AWAY_WIN,0) AS POINTS,
           COALESCE(T1.HOME_GOAL,0) + COALESCE(T2.AWAY_GOAL,0) AS GOAL_FOR,
           COALESCE(T2.LOST_AWAY_GOAL,0) + COALESCE(T1.LOST_HOME_GOAL,0) AS GOAL_AGAINST
    FROM TEAMS T LEFT JOIN CTE T1
    ON T.TEAM_ID = T1.HOME_TEAM_ID 
    LEFT JOIN CTE T2
    ON T.TEAM_ID = T2.AWAY_TEAM_ID 
    GROUP BY T.TEAM_ID) NEW
WHERE MATCHES_PLAYED!=0
ORDER BY POINTS DESC, GOAL_DIFF DESC, TEAM_NAME;


 # Alternate Solution
  with t as
( 
    select home_team_id,away_team_id, home_team_goals ,away_team_goals from Matches 
    union All
    select away_team_id,home_team_id,away_team_goals,home_team_goals from Matches
)

select team_name
    ,count(home_team_id) matches_played
    ,sum(points) points
    ,sum(home_team_goals) goal_for
    ,sum(away_team_goals) goal_against
    ,sum(home_team_goals) -sum(away_team_goals) goal_diff
from
(
    select home_team_id,home_team_goals,away_team_goals,
    case when home_team_goals=away_team_goals then 1
         when home_team_goals>away_team_goals then 3
    else 0 
    end as  points
    from t
)t1
left join Teams
on Teams.team_id=t1.home_team_id
group by home_team_id
order by points desc,goal_diff desc,team_name;

