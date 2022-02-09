# https://leetcode.com/problems/ads-performance/

# Table: Ads
+---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | ad_id         | int     |
# | user_id       | int     |
# | action        | enum    |
# +---------------+---------+
# (ad_id, user_id) is the primary key for this table.
# Each row of this table contains the ID of an Ad, the ID of a user, and the action taken by this user regarding this Ad.
# The action column is an ENUM type of ('Clicked', 'Viewed', 'Ignored').
 
# A company is running Ads and wants to calculate the performance of each Ad.
# Performance of the Ad is measured using Click-Through Rate (CTR) where:

# Write an SQL query to find the ctr of each Ad. Round ctr to two decimal points.
# Return the result table ordered by ctr in descending order and by ad_id in ascending order in case of a tie.

# My Solution
SELECT AD_ID,
       CASE WHEN TOTAL=0 THEN 0 
            ELSE ROUND(CLICKED/TOTAL*100,2)
       END AS CTR
FROM (
    SELECT AD_ID, 
           SUM(ACTION="Clicked") AS CLICKED,
           SUM(ACTION="Clicked") + SUM(ACTION="Viewed") AS TOTAL 
    FROM ADS
    GROUP BY AD_ID) T
ORDER BY CTR DESC, AD_ID;


# Alternate Solution
with temp as
(select ad_id, 
count(case when action = 'Clicked' then 1 else null end) as clicks,
count(case when action = 'Viewed' or action ='Clicked' then 1 else null end) as candv
from Ads
group by 1)


select ad_id,
case when candv = 0 then 0
else round(clicks/candv*100,2) end as ctr
from temp
group by 1
order by 2 desc, 1 asc;

