# https://leetcode.com/problems/hopper-company-queries-ii/

# Table: Drivers
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | driver_id   | int     |
# | join_date   | date    |
# +-------------+---------+
# driver_id is the primary key for this table.
# Each row of this table contains the driver's ID and the date they joined the Hopper company.
 
# Table: Rides
# +--------------+---------+
# | Column Name  | Type    |
# +--------------+---------+
# | ride_id      | int     |
# | user_id      | int     |
# | requested_at | date    |
# +--------------+---------+
# ride_id is the primary key for this table.
# Each row of this table contains the ID of a ride, the user's ID that requested it, and the day they requested it.
# There may be some ride requests in this table that were not accepted.
 
# Table: AcceptedRides
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | ride_id       | int     |
# | driver_id     | int     |
# | ride_distance | int     |
# | ride_duration | int     |
# +---------------+---------+
# ride_id is the primary key for this table.
# Each row of this table contains some information about an accepted ride.
# It is guaranteed that each accepted ride exists in the Rides table.
 
# Write an SQL query to report the percentage of working drivers (working_percentage) for each month of 2020 where:


# Note that if the number of available drivers during a month is zero, we consider the working_percentage to be 0.
# Return the result table ordered by month in ascending order, where month is the month's number (January is 1, February is 2, etc.). Round working_percentage to the nearest 2 decimal places.

# My Solution
WITH RECURSIVE T1 AS (
    SELECT 1 AS MONTH
    UNION
    SELECT MONTH+1 FROM T1 WHERE MONTH<12),
T2 AS (
    SELECT T1.MONTH, COALESCE(COUNT(D.DRIVER_ID),0) AS NO_OF_DRIVER 
    FROM T1 LEFT JOIN DRIVERS D
    ON T1.MONTH = MONTH(D.JOIN_DATE) AND YEAR(D.JOIN_DATE)=2020
    GROUP BY T1.MONTH),
T3 AS (
    SELECT COUNT(DRIVER_ID) AS DRIVER_2019 FROM DRIVERS 
    WHERE YEAR(JOIN_DATE)<=2019),
T4 AS (
    SELECT T2.MONTH, 
           SUM(T2.NO_OF_DRIVER) OVER (ORDER BY T2.MONTH) + T3.DRIVER_2019 AS TOTAL_DRIVER
    FROM T2,T3),
T5 AS (
    SELECT MONTH(R.REQUESTED_AT) AS MONTH,
           COUNT(DISTINCT A.DRIVER_ID) AS ACCEPTED_DRIVER
    FROM RIDES R JOIN ACCEPTEDRIDES A 
    ON R.RIDE_ID = A.RIDE_ID AND YEAR(R.REQUESTED_AT)=2020
    GROUP BY MONTH(R.REQUESTED_AT))
       
SELECT T4.MONTH, 
       CASE WHEN T4.TOTAL_DRIVER=0 THEN ROUND(0/2,2)
            ELSE ROUND((COALESCE(T5.ACCEPTED_DRIVER,0)/T4.TOTAL_DRIVER)*100,2) 
       END AS WORKING_PERCENTAGE
FROM T4 LEFT JOIN T5
ON T4.MONTH = T5.MONTH
ORDER BY T4.MONTH;


# Alternate Solution
with recursive months as (
        select 1 as month
        union
        select month + 1 from months
        where month < 12
),             
available_drivers as (
    select IF(year(join_date)<2020,'1',month(join_date)) as join_month, count(distinct driver_id) as driver_num
    from Drivers
    where year(join_date) <= 2020
    group by join_month
),
accepted_rides as (
    select month(requested_at) as requested_month, count(distinct A.driver_id) as rider_num
    from AcceptedRides A left join Rides R on R.ride_id = A.ride_id
    where year(R.requested_at) = 2020
    group by requested_month
)
select months.month, round(ifnull(accepted_rides.rider_num*100/sum(available_drivers.driver_num),0), 2) as working_percentage
from months
left join available_drivers on months.month >= available_drivers.join_month
left join accepted_rides on months.month = accepted_rides.requested_month
group by months.month
order by months.month;

