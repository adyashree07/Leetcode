# https://leetcode.com/problems/order-two-columns-independently/

# Table: Data
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | first_col   | int  |
# | second_col  | int  |
# +-------------+------+
# There is no primary key for this table and it may contain duplicates.
 
# Write an SQL query to independently:
# 1. order first_col in ascending order.
# 2. order second_col in descending order.

# My Solution
WITH T1 AS (
    SELECT FIRST_COL,
    ROW_NUMBER() OVER (ORDER BY FIRST_COL ASC) AS RNK1 
    FROM DATA
),
T2 AS (
    SELECT SECOND_COL,
    ROW_NUMBER() OVER (ORDER BY SECOND_COL DESC) AS RNK2
    FROM DATA)
SELECT FIRST_COL, SECOND_COL FROM T1 LEFT JOIN T2 ON RNK1=RNK2;

