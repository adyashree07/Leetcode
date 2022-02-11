# https://leetcode.com/problems/game-play-analysis-v/

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
 
# The install date of a player is the first login day of that player.
# We define day one retention of some date x to be the number of players whose install date is x and they logged back in on the day right after x, divided by the number of players whose install date is x, rounded to 2 decimal places.
# Write an SQL query to report for each install date, the number of players that installed the game on that day, and the day one retention.
# Return the result table in any order.

# My Solution
SELECT MIN(A1.EVENT_DATE) AS INSTALL_DT, 
       COALESCE(COUNT(A1.PLAYER_ID),0) AS INSTALLS,
       ROUND(COALESCE(COUNT(A2.EVENT_DATE),0)/COALESCE(COUNT(A1.PLAYER_ID),0),2) AS DAY1_RETENTION  
FROM (
    SELECT PLAYER_ID, 
          MIN(EVENT_DATE) AS EVENT_DATE  
    FROM ACTIVITY
    GROUP BY PLAYER_ID) A1
    LEFT JOIN ACTIVITY A2 
    ON A1.PLAYER_ID=A2.PLAYER_ID 
    AND A1.EVENT_DATE + 1 = A2.EVENT_DATE
GROUP BY A1.EVENT_DATE;


# Alternate Solution
with t as(    
    select player_id,event_date from
    (
        select player_id
         ,event_date
         ,row_number() over(partition by player_id order by event_date) rn 
         from Activity
    )t1
     where rn=1
)
,t2 as(
    select event_date,count(*) as cnt from
    (
        select t.player_id,t.event_date
        from t
        join activity  a
        on t.player_id=a.player_id and datediff(a.event_date,t.event_date)=1
    )p
    group by event_date
    
)

select q1.*, ROUND(coalesce(t2.cnt,0)/installs ,2) Day1_retention
from
    (select t.event_date install_dt 
        ,count(t.player_id) installs
    from t
    group by install_dt) q1
left join t2
on q1.install_dt=t2.event_date;

