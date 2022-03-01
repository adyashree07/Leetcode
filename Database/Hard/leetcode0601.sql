# https://leetcode.com/problems/human-traffic-of-stadium/

# Table: Stadium
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | id            | int     |
# | visit_date    | date    |
# | people        | int     |
# +---------------+---------+
# visit_date is the primary key for this table.
# Each row of this table contains the visit date and visit id to the stadium with the number of people during the visit.
# No two rows will have the same visit_date, and as the id increases, the dates increase as well.
 
# Write an SQL query to display the records with three or more rows with consecutive id's, and the number of people is greater than or equal to 100 for each.
# Return the result table ordered by visit_date in ascending order.

# My Solution-1
SELECT S3.* FROM STADIUM S1 JOIN STADIUM S2
ON S1.ID = S2.ID + 1
JOIN STADIUM S3 
ON S1.ID = S3.ID+2
WHERE S1.PEOPLE>=100 AND S2.PEOPLE>=100 AND S3.PEOPLE>=100
UNION 
SELECT S2.* FROM STADIUM S1 JOIN STADIUM S2
ON S1.ID = S2.ID + 1
JOIN STADIUM S3 
ON S1.ID = S3.ID+2
WHERE S1.PEOPLE>=100 AND S2.PEOPLE>=100 AND S3.PEOPLE>=100
UNION
SELECT S1.* FROM STADIUM S1 JOIN STADIUM S2
ON S1.ID = S2.ID + 1
JOIN STADIUM S3 
ON S1.ID = S3.ID+2
WHERE S1.PEOPLE>=100 AND S2.PEOPLE>=100 AND S3.PEOPLE>=100
ORDER BY VISIT_DATE;


# My Solution-2
SELECT DISTINCT S1.* FROM STADIUM S1 
INNER JOIN STADIUM S2
INNER JOIN STADIUM S3 ON ((S1.ID = S2.ID+1 AND S1.ID = S3.ID+2 AND S2.ID=S3.ID+1) -- S1, S2, S3
                          OR (S2.ID = S1.ID+2 AND S2.ID = S3.ID+1 AND S3.ID=S1.ID+1) -- S2,S3,S1
                          OR (S3.ID = S2.ID+2 AND S3.ID = S1.ID+1 AND S1.ID=S2.ID+1))-- S3, S1, S2
WHERE S1.PEOPLE>=100 AND S2.PEOPLE>=100 AND S3.PEOPLE>=100 ORDER BY S1.ID;


# Alternate Solution
with t as
(
    select id
        ,visit_date
        ,people 
        ,id-row_number() over(order by id) diff
    from Stadium
    where people >=100
)

select id
    ,visit_date
    ,people 
from t 
where diff in (select diff from t group by diff having count(diff)>2)
order by visit_date;


