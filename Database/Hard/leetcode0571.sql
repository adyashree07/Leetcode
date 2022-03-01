# https://leetcode.com/problems/find-median-given-frequency-of-numbers/

# Table: Numbers
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | num         | int  |
# | frequency   | int  |
# +-------------+------+
# num is the primary key for this table.
# Each row of this table shows the frequency of a number in the database.
 
# The median is the value separating the higher half from the lower half of a data sample.
# Write an SQL query to report the median of all the numbers in the database after decompressing the Numbers table. Round the median to one decimal point.

# My Solution
WITH T AS (
    SELECT SUM(FREQUENCY) AS FREQ FROM NUMBERS),
T1 AS (
    SELECT NUM, SUM(FREQUENCY) OVER (ORDER BY NUM) AS CUMM_FREQ
FROM NUMBERS),
T2 AS (
    SELECT *,
           COALESCE(LAG(CUMM_FREQ) OVER (ORDER BY CUMM_FREQ)+1,1) AS LAG_FREQ
    FROM T1)

SELECT CASE WHEN T.FREQ%2=0 
            THEN ROUND(CAST((SELECT NUM FROM T2 WHERE (SELECT CAST(FREQ/2 AS UNSIGNED) FROM T) BETWEEN LAG_FREQ AND CUMM_FREQ)+(SELECT NUM FROM T2 WHERE (SELECT CAST((FREQ/2)+1 AS UNSIGNED) FROM T) BETWEEN LAG_FREQ AND CUMM_FREQ) AS FLOAT)/2,1)
            ELSE ROUND(CAST((SELECT NUM FROM T2 WHERE (SELECT CAST((FREQ+1)/2 AS UNSIGNED) FROM T) BETWEEN LAG_FREQ AND CUMM_FREQ) AS FLOAT),1)
       END AS MEDIAN
FROM T;


# Alternate Solution
WITH Helper AS (
    SELECT num, SUM(frequency) OVER (ORDER BY num ASC) AS running_count
    FROM Numbers),
Total AS (
    SELECT MAX(running_count) AS total_count
    FROM Helper)
SELECT CASE 
    WHEN MOD(total_count, 2) = 1 THEN
        (SELECT num FROM Helper WHERE running_count >= total_count/2
         ORDER BY num ASC LIMIT 1)
    ELSE ROUND(( (SELECT num FROM Helper WHERE running_count >= total_count/2 + 1
                  ORDER BY num ASC LIMIT 1) +
                 (SELECT num FROM Helper WHERE running_count >= total_count/2
                  ORDER BY num ASC LIMIT 1))/2, 1)
END AS median
FROM Total;

