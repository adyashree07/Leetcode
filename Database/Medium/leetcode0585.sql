# https://leetcode.com/problems/investments-in-2016/

# Table: Insurance
# +-------------+-------+
# | Column Name | Type  |
# +-------------+-------+
# | pid         | int   |
# | tiv_2015    | float |
# | tiv_2016    | float |
# | lat         | float |
# | lon         | float |
# +-------------+-------+
# pid is the primary key column for this table.
# Each row of this table contains information about one policy where:
# pid is the policyholder's policy ID.
# tiv_2015 is the total investment value in 2015 and tiv_2016 is the total investment value in 2016.
# lat is the latitude of the policy holder's city.
# lon is the longitude of the policy holder's city.
 
# Write an SQL query to report the sum of all total investment values in 2016 tiv_2016, for all policyholders who:
# 1. have the same tiv_2015 value as one or more other policyholders, and
# 2. are not located in the same city like any other policyholder (i.e., the (lat, lon) attribute pairs must be unique).
# Round tiv_2016 to two decimal places.

# My Solution
WITH T1 AS (
    SELECT * FROM (
        SELECT *,
        CONCAT(LAT,"-",LON) AS RNK
        FROM INSURANCE) T
        GROUP BY LON,LAT
    HAVING COUNT(*)=1)
SELECT ROUND(SUM(TIV_2016),2) AS TIV_2016
FROM T1
WHERE TIV_2015 IN (SELECT TIV_2015 FROM INSURANCE GROUP BY TIV_2015 HAVING COUNT(TIV_2015)>1);


# Alternate Solution
select round(sum(TIV_2016),2) as TIV_2016
from insurance a
where EXISTS (select TIV_2015 from insurance b where a.PID!=b.PID AND a.TIV_2015=b.TIV_2015)
AND
NOT EXISTS (select TIV_2015 from insurance c where a.PID!=c.PID AND a.LAT=c.LAT AND a.LON=c.LON );


# Alternate Solution-2
select round(sum(tiv_2016),2) tiv_2016 from Insurance
where 
concat(lat,",",lon) in (select concat(lat,",",lon) from Insurance  group by lat,lon having count(*)=1)
and
tiv_2015 in (select tiv_2015 from Insurance group by tiv_2015 having count(*)>1 );

