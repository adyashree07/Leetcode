# https://leetcode.com/problems/user-purchase-platform/

# Table: Spending
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | user_id     | int     |
# | spend_date  | date    |
# | platform    | enum    | 
# | amount      | int     |
# +-------------+---------+
# The table logs the history of the spending of users that make purchases from an online shopping website that has a desktop and a mobile application.
# (user_id, spend_date, platform) is the primary key of this table.
# The platform column is an ENUM type of ('desktop', 'mobile'). 

# Write an SQL query to find the total number of users and the total amount spent using the mobile only, the desktop only, and both mobile and desktop together for each date.
# Return the result table in any order.

# My Solution
WITH T1 AS (
    SELECT DISTINCT SPEND_DATE, "mobile" AS PLATFORM 
    FROM SPENDING
    UNION ALL
    SELECT DISTINCT SPEND_DATE, "desktop" AS PLATFORM 
    FROM SPENDING
    UNION ALL
    SELECT DISTINCT SPEND_DATE, "both" AS PLATFORM 
    FROM SPENDING),
T2 AS (
    SELECT USER_ID, 
           SPEND_DATE, 
           CASE WHEN COUNT(*)=1 THEN PLATFORM
                 ELSE "both"
           END AS PLATFORM,
           SUM(AMOUNT) AS AMOUNT
    FROM SPENDING
    GROUP BY USER_ID, SPEND_DATE)
    
SELECT T1.SPEND_DATE,
       T1.PLATFORM,
       COALESCE(SUM(T2.AMOUNT),0) AS TOTAL_AMOUNT,
       COALESCE(COUNT(DISTINCT T2.USER_ID),0) AS TOTAL_USERS
FROM T1 LEFT JOIN T2 
ON T1.SPEND_DATE = T2.SPEND_DATE AND T1.PLATFORM = T2.PLATFORM
GROUP BY T1.SPEND_DATE, T1.PLATFORM;


# Alternate Solution
with a as (
    select distinct spend_date, 'mobile' as platform from spending
    union
    select distinct spend_date, 'desktop' as platform from spending
    union
    select distinct spend_date, 'both' as platform from spending
    )
select a.spend_date, a.platform, 
    case when sum(daily_total) is null then 0 else sum(daily_total) end as total_amount,
    count(user_id) total_users
from a
left join(
    select user_id, spend_date,
    (case when count(distinct platform)=2 then 'both' else platform end) platform,
    sum(amount) daily_total
from spending
group by user_id, spend_date) b
on b.spend_date=a.spend_date and b.platform=a.platform
group by spend_date, platform;

