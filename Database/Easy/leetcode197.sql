# https://leetcode.com/problems/rising-temperature/

# Table: Weather
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | id            | int     |
# | recordDate    | date    |
# | temperature   | int     |
# +---------------+---------+
# id is the primary key for this table.
# This table contains information about the temperature on a certain day.
 
# Write an SQL query to find all dates' Id with higher temperatures compared to its previous dates (yesterday).
# Return the result table in any order.

# My Solution
SELECT ID FROM (
    SELECT CASE WHEN TEMPERATURE> LAG(TEMPERATURE) OVER (ORDER BY RECORDDATE) AND 
    DATEDIFF(RECORDDATE,LAG(RECORDDATE) OVER (ORDER BY RECORDDATE))=1  THEN ID
           END AS ID
    FROM WEATHER) T
WHERE ID IS NOT NULL;


# Alternate Solution
select distinct b.id
from Weather a
join Weather b
on datediff(b.recordDate ,a.recordDate )=1 and a.temperature <b.temperature;

