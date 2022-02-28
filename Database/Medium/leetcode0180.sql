# https://leetcode.com/problems/consecutive-numbers/

# Table: Logs
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | id          | int     |
# | num         | varchar |
# +-------------+---------+
# id is the primary key for this table.
 
# Write an SQL query to find all numbers that appear at least three times consecutively.
# Return the result table in any order.

# My Solution
WITH T AS (
    SELECT NUM, 
           LAG(NUM) OVER (ORDER BY ID) AS LAG_NUM,
           LEAD(NUM) OVER (ORDER BY ID) AS LEAD_NUM
FROM LOGS)

SELECT DISTINCT NUM AS CONSECUTIVENUMS 
FROM T 
WHERE NUM=LAG_NUM AND NUM=LEAD_NUM;


# Alternate Solution
SELECT DISTINCT L1.NUM AS CONSECUTIVENUMS 
FROM LOGS L1 INNER JOIN LOGS L2 
ON L1.ID= L2.ID+1 
INNER JOIN LOGS L3 
ON L1.ID = L3.ID+2 
WHERE L1.NUM=L2.NUM AND L1.NUM = L3.NUM;

