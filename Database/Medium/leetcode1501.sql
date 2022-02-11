# https://leetcode.com/problems/countries-you-can-safely-invest-in/

# Table Person:
# +----------------+---------+
# | Column Name    | Type    |
# +----------------+---------+
# | id             | int     |
# | name           | varchar |
# | phone_number   | varchar |
# +----------------+---------+
# id is the primary key for this table.
# Each row of this table contains the name of a person and their phone number.
# Phone number will be in the form 'xxx-yyyyyyy' where xxx is the country code (3 characters) and yyyyyyy is the phone number (7 characters) where x and y are digits. Both can contain leading zeros.
 
# Table Country:
# +----------------+---------+
# | Column Name    | Type    |
# +----------------+---------+
# | name           | varchar |
# | country_code   | varchar |
# +----------------+---------+
# country_code is the primary key for this table.
# Each row of this table contains the country name and its code. country_code will be in the form 'xxx' where x is digits.
 
# Table Calls:
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | caller_id   | int  |
# | callee_id   | int  |
# | duration    | int  |
# +-------------+------+
# There is no primary key for this table, it may contain duplicates.
# Each row of this table contains the caller id, callee id and the duration of the call in minutes. caller_id != callee_id
 
# A telecommunications company wants to invest in new countries. The company intends to invest in the countries where the average call duration of the calls in this country is strictly greater than the global average call duration.
# Write an SQL query to find the countries where this company can invest.
# Return the result table in any order.

# My Solution
WITH T1 AS (
    SELECT CALLER_ID, DURATION FROM CALLS
    UNION ALL
    SELECT CALLEE_ID, DURATION FROM CALLS)
    
SELECT COUNTRY FROM (
    SELECT DISTINCT AVG(T1.DURATION) OVER (PARTITION BY C.COUNTRY_CODE) AS AVG_COUNTRY_CALL,
                    C.NAME AS COUNTRY
    FROM T1 LEFT JOIN PERSON P
    ON T1.CALLER_ID = P.ID
    LEFT JOIN COUNTRY C
    ON LEFT(P.PHONE_NUMBER,3) = C.COUNTRY_CODE) T
WHERE AVG_COUNTRY_CALL > (SELECT AVG(DURATION) FROM T1);


# Alternate Solution
with base as (
    select caller_id as id, duration from Calls
    union all
    select callee_id as id, duration from Calls
)
select c.name as country
from base as b
join Person as p
on b.id = p.id
join Country as c
on substring(p.phone_number, 1, 3) = c.country_code
group by c.name
having avg(duration) > (select avg(duration) from Calls);

