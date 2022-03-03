# https://leetcode.com/problems/number-of-calls-between-two-persons/

# Table: Calls
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | from_id     | int     |
# | to_id       | int     |
# | duration    | int     |
# +-------------+---------+
# This table does not have a primary key, it may contain duplicates.
# This table contains the duration of a phone call between from_id and to_id.
# from_id != to_id
 
# Write an SQL query to report the number of calls and the total call duration between each pair of distinct persons (person1, person2) where person1 < person2.
# Return the result table in any order.

# My Solution
SELECT FROM_ID AS PERSON1,
       TO_ID AS PERSON2,
       COUNT(*) AS CALL_COUNT,
       SUM(DURATION) AS TOTAL_DURATION 
FROM (
    SELECT * FROM CALLS
    WHERE FROM_ID<TO_ID
    UNION ALL
    SELECT TO_ID AS FROM_ID,
           FROM_ID AS TO_ID,
           DURATION
    FROM CALLS
    WHERE FROM_ID>TO_ID) T
GROUP BY FROM_ID, TO_ID;


# Alternate Solution
SELECT case when from_id < to_id then from_id
            else to_id 
       end as person1,
       case when from_id<to_id then to_id
            else from_id 
       end as person2,
       count(*) as call_count,
       sum(duration) as total_duration
from calls
group by 1,2;

