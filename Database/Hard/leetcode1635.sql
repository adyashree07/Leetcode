# https://leetcode.com/problems/hopper-company-queries-i/

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
 
# Write an SQL query to report the following statistics for each month of 2020:

# 1. The number of drivers currently with the Hopper company by the end of the month (active_drivers).
# 2. The number of accepted rides in that month (accepted_rides).
# Return the result table ordered by month in ascending order, where month is the month's number (January is 1, February is 2, etc.).

# My Solution
WITH RECURSIVE R1 AS (
    SELECT 1 AS MONTH
    UNION
    SELECT MONTH+1 FROM R1 WHERE MONTH<=11),
R2 AS (
    SELECT COUNT(DRIVER_ID) AS C_19
    FROM DRIVERS
    WHERE YEAR(JOIN_DATE)<2020),
R3 AS (
    SELECT  MONTH(JOIN_DATE) AS DT,
            COUNT(DRIVER_ID)  AS CNT
    FROM DRIVERS
    WHERE YEAR(JOIN_DATE)=2020
    GROUP BY MONTH(JOIN_DATE)),
R4 AS (
    SELECT COALESCE(COUNT(R.RIDE_ID),0) AS ACCEPT_CNT,
           MONTH(R.REQUESTED_AT) AS MONTH
    FROM RIDES R JOIN ACCEPTEDRIDES A 
    ON R.RIDE_ID = A.RIDE_ID 
    WHERE YEAR(R.REQUESTED_AT)=2020
    GROUP BY 2)
    
SELECT R1.MONTH, 
       SUM(COALESCE(R3.CNT,0)) OVER (ORDER BY R1.MONTH) + (SELECT C_19 FROM R2) AS ACTIVE_DRIVERS,
       COALESCE(R4.ACCEPT_CNT,0) AS ACCEPTED_RIDES
FROM R1 LEFT JOIN R3
ON R1.MONTH=R3.DT
LEFT JOIN R4 
ON R1.MONTH = R4.MONTH;


# Alternate Solution
WITH RECURSIVE month(month) AS(
    SELECT 1 as month
    UNION ALL
    SELECT month+1
    FROM month
    WHERE month<12
), driversByMonth(month, active_drivers) AS(
    
    SELECT month, COUNT(driver_id) as active_drivers
    FROM month m LEFT JOIN Drivers d on 
        (month(d.join_date)<=month and year(d.join_date)=2020) or year(d.join_date)<2020
    GROUP BY month
),ridesByMonth(month, accepted_rides) AS(
    SELECT month(requested_at) as month, count(a.ride_id) as accepted_rides
    FROM AcceptedRides a join Rides r on a.ride_id=r.ride_id
    WHERE year(requested_at)=2020
    GROUP BY month(requested_at)
)
SELECT m.month, 
    case when active_drivers is null then 0 else active_drivers end as active_drivers,
    case when accepted_rides is null then 0 else accepted_rides end as accepted_rides
FROM month m LEFT JOIN driversByMonth d on m.month=d.month
             LEFT JOIN ridesByMonth r on m.month=r.month;
             
             
# Alternate Solution-2
with recursive t as
(
    select 1 as month
    union
    select month+1 from t where month<12
)
,t2 as
(
    select date_format(join_date,'%m') month
    , count(driver_id) cnt 
     from Drivers 
     where year(join_date)=2020 group by date_format(join_date,'%m')
 )
 ,t3 as
 (
     select count(*) cnt_2020 from Drivers where year(join_date)<2020
 )
 
select t4.* , coalesce(t5.ar,0) accepted_rides
from
     (select month,sum(cnt) over(order by month) + cnt_2020 as active_drivers  
     from 
     (
         select t.month,coalesce(cnt,0) cnt from t 
         left join t2
         on t.month=t2.month
    )temp,t3) t4
left join
    ( select month(requested_at) month, count(*) ar from 
     AcceptedRides a
     left join Rides r
     on r.ride_id=a.ride_id
     where year(requested_at)=2020
     group by month(requested_at)
     )t5
on t4.month=t5.month;

