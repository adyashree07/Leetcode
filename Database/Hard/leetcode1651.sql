# https://leetcode.com/problems/hopper-company-queries-iii/

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
 
# Write an SQL query to compute the average_ride_distance and average_ride_duration of every 3-month window starting from January - March 2020 to October - December 2020. Round average_ride_distance and average_ride_duration to the nearest two decimal places.
# The average_ride_distance is calculated by summing up the total ride_distance values from the three months and dividing it by 3. The average_ride_duration is calculated in a similar way.
# Return the result table ordered by month in ascending order, where month is the starting month's number (January is 1, February is 2, etc.).

# My Solution
WITH RECURSIVE REC AS (
SELECT 1 AS MONTH
UNION SELECT MONTH+1 FROM REC WHERE MONTH<10)

SELECT MONTH,
       ROUND(SUM(COALESCE(RIDE_DISTANCE,0))/3,2) AS AVERAGE_RIDE_DISTANCE,
       ROUND(SUM(COALESCE(RIDE_DURATION,0))/3,2) AS AVERAGE_RIDE_DURATION
FROM REC
LEFT JOIN (
    SELECT A.*, 
       R.REQUESTED_AT
    FROM ACCEPTEDRIDES A LEFT JOIN RIDES R 
    ON A.RIDE_ID = R.RIDE_ID
    WHERE YEAR(R.REQUESTED_AT)=2020) T
ON MONTH(REQUESTED_AT) BETWEEN MONTH AND MONTH+2
GROUP BY MONTH;

