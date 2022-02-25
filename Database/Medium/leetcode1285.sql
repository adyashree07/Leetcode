# https://leetcode.com/problems/find-the-start-and-end-number-of-continuous-ranges/

# Table: Logs
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | log_id        | int     |
# +---------------+---------+
# log_id is the primary key for this table.
# Each row of this table contains the ID in a log Table.
 
# Write an SQL query to find the start and end number of continuous ranges in the table Logs.
# Return the result table ordered by start_id.

# My Solution
WITH T1 AS (
    SELECT CASE WHEN (LOG_ID - LAG(LOG_ID) OVER (ORDER BY LOG_ID))!=1 OR LAG(LOG_ID) OVER (ORDER BY LOG_ID) IS NULL THEN LOG_ID
                ELSE NULL
            END AS START_ID
    FROM LOGS),
T2 AS (
    SELECT CASE WHEN (LEAD(LOG_ID) OVER (ORDER BY LOG_ID)- LOG_ID)!=1 OR LEAD(LOG_ID) OVER (ORDER BY LOG_ID) IS NULL THEN LOG_ID
                ELSE NULL
            END AS END_ID
    FROM LOGS)
    
SELECT START_ID, END_ID FROM (
    SELECT START_ID, 
           END_ID, 
           ROW_NUMBER() OVER (PARTITION BY START_ID ORDER BY END_ID) AS RNK
    FROM T1,T2 
    WHERE START_ID IS NOT NULL
    AND END_ID IS NOT NULL AND
    START_ID <= END_ID) T
WHERE RNK=1;


# Alternate Solution
select min(log_id) start_id,max(log_id) end_id from
  (select log_id,
          log_id-row_number() over(order by log_id) as diff 
   from Logs) as t1
group by t1.diff;

