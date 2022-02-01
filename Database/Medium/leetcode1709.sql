# https://leetcode.com/problems/biggest-window-between-visits/

# Table: UserVisits
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | user_id     | int  |
# | visit_date  | date |
# +-------------+------+
# This table does not have a primary key.
# This table contains logs of the dates that users visited a certain retailer.
 
# Assume today's date is '2021-1-1'.
# Write an SQL query that will, for each user_id, find out the largest window of days between each visit and the one right after it (or today if you are considering the last visit).
# Return the result table ordered by user_id.

# My Solution
WITH CTE AS 
(SELECT USER_ID, 
CASE WHEN LEAD(VISIT_DATE) OVER (PARTITION BY USER_ID ORDER BY VISIT_DATE) IS NULL THEN DATEDIFF('2021-1-1',VISIT_DATE)
ELSE
DATEDIFF(LEAD(VISIT_DATE) OVER (PARTITION BY USER_ID ORDER BY VISIT_DATE), VISIT_DATE) END
AS BIGGEST_WINDOW
FROM USERVISITS) 
SELECT USER_ID, MAX(BIGGEST_WINDOW) AS BIGGEST_WINDOW FROM CTE GROUP BY USER_ID;


# Alternate Solution
with t as(
select u.user_id 
    ,u.visit_date as start_date
    ,coalesce(v.visit_date,'2021-1-1') as end_date
from UserVisits u
left join UserVisits v
on u.user_id=v.user_id
and u.visit_date<v.visit_date
)

select user_id,max(DATEDIFF(end_date,start_date)) as biggest_window from(
select user_id
 ,start_date
 ,end_date
 ,rank() over(partition by t.user_id,t.start_date order by end_date) rnk
  from t
)t1
where t1.rnk=1
group by user_id;

