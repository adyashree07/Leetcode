# https://leetcode.com/problems/the-number-of-passengers-in-each-bus-i/

# Table: Buses
# +--------------+------+
# | Column Name  | Type |
# +--------------+------+
# | bus_id       | int  |
# | arrival_time | int  |
# +--------------+------+
# bus_id is the primary key column for this table.
# Each row of this table contains information about the arrival time of a bus at the LeetCode station.
# No two buses will arrive at the same time.
 
# Table: Passengers
# +--------------+------+
# | Column Name  | Type |
# +--------------+------+
# | passenger_id | int  |
# | arrival_time | int  |
# +--------------+------+
# passenger_id is the primary key column for this table.
# Each row of this table contains information about the arrival time of a passenger at the LeetCode station.
 
# Buses and passengers arrive at the LeetCode station. If a bus arrives at the station at time tbus and a passenger arrived at time tpassenger where tpassenger <= tbus and the passenger did not catch any bus, the passenger will use that bus.
# Write an SQL query to report the number of users that used each bus.
# Return the result table ordered by bus_id in ascending order.

# My Solution
WITH T1 AS (
    SELECT BUS_ID, PASSENGER_ID FROM (
        SELECT B.BUS_ID, 
               B.ARRIVAL_TIME AS BUS_TIME, 
               P.PASSENGER_ID, 
               P.ARRIVAL_TIME AS PASS_TIME,
               ROW_NUMBER() OVER (PARTITION BY P.PASSENGER_ID ORDER BY B.ARRIVAL_TIME) AS RNK
        FROM BUSES B JOIN PASSENGERS P 
        ON B.ARRIVAL_TIME>=P.ARRIVAL_TIME
        ORDER BY B.ARRIVAL_TIME) T
    WHERE RNK=1)

SELECT B.BUS_ID, COALESCE(COUNT(T1.PASSENGER_ID),0) AS PASSENGERS_CNT
FROM BUSES B LEFT JOIN T1
ON B.BUS_ID = T1.BUS_ID
GROUP BY B.BUS_ID
ORDER BY B.BUS_ID;


# Alternate Solution
with t as
(
    select *
        ,coalesce(lag(arrival_time) over(order by arrival_time),0) as in_time
    from Buses
)
select  t.bus_id,
        coalesce(count(p.passenger_id),0)  passengers_cnt
from t
left join Passengers p
on p.arrival_time<=t.arrival_time and p.arrival_time>t.in_time
group by t.bus_id
order by t.bus_id;

