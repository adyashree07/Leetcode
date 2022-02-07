# https://leetcode.com/problems/total-sales-amount-by-year/

# Table: Product
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | product_id    | int     |
# | product_name  | varchar |
# +---------------+---------+
# product_id is the primary key for this table.
# product_name is the name of the product.
 
# Table: Sales
# +---------------------+---------+
# | Column Name         | Type    |
# +---------------------+---------+
# | product_id          | int     |
# | period_start        | date    |
# | period_end          | date    |
# | average_daily_sales | int     |
# +---------------------+---------+
# product_id is the primary key for this table. 
# period_start and period_end indicate the start and end date for the sales period, and both dates are inclusive.
# The average_daily_sales column holds the average daily sales amount of the items for the period.
# The dates of the sales years are between 2018 to 2020.
 
# Write an SQL query to report the total sales amount of each item for each year, with corresponding product_name, product_id, product_name, and report_year.
# Return the result table ordered by product_id and report_year.

# My Solution
WITH RECURSIVE CTE AS
    (SELECT MIN(period_start) as date
     FROM Sales 
     UNION ALL
     SELECT DATE_ADD(date, INTERVAL 1 day)
     FROM CTE
     WHERE date <= ALL (SELECT MAX(period_end) FROM Sales))

SELECT S.PRODUCT_ID, 
       P.PRODUCT_NAME,
       CONVERT(YEAR(E.DATE),CHAR) as REPORT_YEAR, 
       SUM(S.AVERGAE_DAILY_SALES)  as TOTAL_AMOUNT
FROM SALES S
JOIN PRODUCT P ON P.PRODUCT_ID = S.PRODUCT_ID
JOIN CTE E ON E.DATE BETWEEN S.PERIOD_START AND S.PERIOD_END
GROUP BY 1,2,3 
ORDER BY 1,3;

