# https://leetcode.com/problems/fix-product-name-format/

# Table: Sales
# +--------------+---------+
# | Column Name  | Type    |
# +--------------+---------+
# | sale_id      | int     |
# | product_name | varchar |
# | sale_date    | date    |
# +--------------+---------+
# sale_id is the primary key for this table.
# Each row of this table contains the product name and the date it was sold.
 
# Since table Sales was filled manually in the year 2000, product_name may contain leading and/or trailing white spaces, also they are case-insensitive.
# Write an SQL query to report
# 1. product_name in lowercase without leading or trailing white spaces.
# 2. sale_date in the format ('YYYY-MM').
# 3. total the number of times the product was sold in this month.
# Return the result table ordered by product_name in ascending order. 
# In case of a tie, order it by sale_date in ascending order.

# My Solution
SELECT *, COUNT(PRODUCT_NAME) AS TOTAL FROM(
    SELECT TRIM(LOWER(PRODUCT_NAME)) AS PRODUCT_NAME, 
       DATE_FORMAT(SALE_DATE,"%Y-%m") AS SALE_DATE
    FROM SALES) T
GROUP BY T.PRODUCT_NAME, T.SALE_DATE
ORDER BY T.PRODUCT_NAME, T.SALE_DATE;

