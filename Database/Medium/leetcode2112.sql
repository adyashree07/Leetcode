# https://leetcode.com/problems/the-airport-with-the-most-traffic/

# Table: Flights
# +-------------------+------+
# | Column Name       | Type |
# +-------------------+------+
# | departure_airport | int  |
# | arrival_airport   | int  |
# | flights_count     | int  |
# +-------------------+------+
# (departure_airport, arrival_airport) is the primary key column for this table.
# Each row of this table indicates that there were flights_count flights that departed from departure_airport and arrived at arrival_airport.
 
# Write an SQL query to report the ID of the airport with the most traffic. The airport with the most traffic is the airport that has the largest total number of flights that either departed from or arrived at the airport. If there is more than one airport with the most traffic, report them all.
# Return the result table in any order.

# My Solution
WITH T1 AS (SELECT T.AIRPORT_ID, 
            SUM(TOTAL_FLIGHT) AS TOTAL FROM (
    (SELECT DEPARTURE_AIRPORT AS AIRPORT_ID, 
           COALESCE(SUM(FLIGHTS_COUNT),0) AS TOTAL_FLIGHT
    FROM FLIGHTS
    GROUP BY DEPARTURE_AIRPORT)
    UNION
    (SELECT ARRIVAL_AIRPORT AS AIRPORT_ID, 
           COALESCE(SUM(FLIGHTS_COUNT),0) AS TOTAL_FLIGHT
    FROM FLIGHTS 
    GROUP BY ARRIVAL_AIRPORT)) T
GROUP BY T.AIRPORT_ID
ORDER BY TOTAL DESC) 
SELECT AIRPORT_ID FROM T1
WHERE TOTAL = (SELECT MAX(TOTAL) FROM T1);


# Alternate Solution
with t as(
    (select departure_airport as airport_id
            ,sum(flights_count)  as cnt
    from Flights group by departure_airport)
    union all
    (select arrival_airport as airport_id
           ,sum(flights_count) as cnt
    from Flights group by arrival_airport)
)

select airport_id from(
select airport_id,dense_rank() over(order by sum(cnt) desc) rnk
from t
group by(airport_id)
)t1 
where rnk=1;
