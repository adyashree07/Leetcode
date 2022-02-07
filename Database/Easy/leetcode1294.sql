# https://leetcode.com/problems/weather-type-in-each-country/

# Table: Countries
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | country_id    | int     |
# | country_name  | varchar |
# +---------------+---------+
# country_id is the primary key for this table.
# Each row of this table contains the ID and the name of one country.
 
# Table: Weather
# +---------------+------+
# | Column Name   | Type |
# +---------------+------+
# | country_id    | int  |
# | weather_state | int  |
# | day           | date |
# +---------------+------+
# (country_id, day) is the primary key for this table.
# Each row of this table indicates the weather state in a country for one day.
 
# Write an SQL query to find the type of weather in each country for November 2019.
# The type of weather is:
# 1. Cold if the average weather_state is less than or equal 15,
# 2. Hot if the average weather_state is greater than or equal to 25, and
# 3. Warm otherwise.
# Return result table in any order.

# My Solution
SELECT DISTINCT C.COUNTRY_NAME,
    CASE WHEN AVG(W.WEATHER_STATE)<=15 THEN "Cold"
         WHEN AVG(W.WEATHER_STATE)>=25 THEN "Hot"
         ELSE "Warm" 
    END AS WEATHER_TYPE
FROM COUNTRIES C LEFT JOIN WEATHER W ON C.COUNTRY_ID = W.COUNTRY_ID 
WHERE MONTH(W.DAY)=11 AND YEAR(W.DAY)=2019
GROUP BY W.COUNTRY_ID;

