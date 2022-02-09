# https://leetcode.com/problems/report-contiguous-dates/

# Table: Failed
# +--------------+---------+
# | Column Name  | Type    |
# +--------------+---------+
# | fail_date    | date    |
# +--------------+---------+
# fail_date is the primary key for this table.
# This table contains the days of failed tasks.
 
# Table: Succeeded
# +--------------+---------+
# | Column Name  | Type    |
# +--------------+---------+
# | success_date | date    |
# +--------------+---------+
# success_date is the primary key for this table.
# This table contains the days of succeeded tasks.
 
# A system is running one task every day. Every task is independent of the previous tasks. The tasks can fail or succeed.
# Write an SQL query to generate a report of period_state for each continuous interval of days in the period from 2019-01-01 to 2019-12-31.
# period_state is 'failed' if tasks in this interval failed or 'succeeded' if tasks in this interval succeeded. Interval of days are retrieved as start_date and end_date.
# Return the result table ordered by start_date.

# My Solution
WITH CTE AS (
    SELECT F.FAIL_DATE AS DATE,
        "failed" AS TYPE,
         RANK() OVER (ORDER BY F.FAIL_DATE) AS RNK
    FROM FAILED F
    WHERE F.FAIL_DATE BETWEEN "2019-01-01" AND "2019-12-31"
    UNION
    SELECT S.SUCCESS_DATE AS DATE,
           "succeeded" AS TYPE,
           RANK() OVER (ORDER BY S.SUCCESS_DATE) AS RNK
    FROM SUCCEEDED S 
    WHERE S.SUCCESS_DATE BETWEEN "2019-01-01" AND "2019-12-31"),

T1 AS (
    SELECT TYPE, DATE AS START_DATE, RNK,
           ROW_NUMBER() OVER (ORDER BY T1.DATE) AS RNK_WHOLE
    FROM CTE T1 
    ORDER BY START_DATE) 
    
SELECT TYPE AS PERIOD_STATE, 
       MIN(START_DATE) AS START_DATE, 
       MAX(START_DATE) AS END_DATE FROM (
   SELECT TYPE, 
          START_DATE, 
          RNK_WHOLE - RNK AS DIFF 
   FROM T1) T2
GROUP BY TYPE, T2.DIFF
ORDER BY START_DATE;

