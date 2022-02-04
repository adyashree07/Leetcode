# https://leetcode.com/problems/consecutive-available-seats/

# Table: Cinema
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | seat_id     | int  |
# | free        | bool |
# +-------------+------+
# seat_id is an auto-increment primary key column for this table.
# Each row of this table indicates whether the ith seat is free or not. 1 means free while 0 means occupied.
 
# Write an SQL query to report all the consecutive available seats in the cinema.
# Return the result table ordered by seat_id in ascending order.
# The test cases are generated so that more than two seats are consecutively available.

# My Solution
WITH T AS (
    SELECT C1.SEAT_ID AS S1, C2.SEAT_ID AS S2 FROM CINEMA C1 JOIN CINEMA C2 ON C1.SEAT_ID = C2.SEAT_ID-1 AND C1.FREE = 1 AND C2.FREE = 1) 
SELECT S1 AS SEAT_ID FROM T
UNION 
SELECT DISTINCT S2 AS SEAT_ID FROM T 
ORDER BY SEAT_ID;


# Alternate Solution
select distinct a.seat_id 
from Cinema a
left join Cinema b
on abs(a.seat_id -b.seat_id)=1
where a.free=1 and b.free=1
order by  a.seat_id;

