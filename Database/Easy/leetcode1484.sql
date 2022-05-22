# https://leetcode.com/problems/group-sold-products-by-the-date/

# Table Activities:
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | sell_date   | date    |
# | product     | varchar |
# +-------------+---------+
# There is no primary key for this table, it may contain duplicates.
# Each row of this table contains the product name and the date it was sold in a market.
 
# Write an SQL query to find for each date the number of different products sold and their names.
# The sold products names for each date should be sorted lexicographically.
# Return the result table ordered by sell_date.

# My Solution
SELECT SELL_DATE,
       COUNT(DISTINCT PRODUCT) AS NUM_SOLD,
       GROUP_CONCAT(DISTINCT PRODUCT ORDER BY PRODUCT) AS PRODUCTS
FROM ACTIVITIES 
GROUP BY SELL_DATE
ORDER BY 1;


# Alternate Solution
SELECT sell_date, 
       COUNT(DISTINCT(product)) as num_sold,
       GROUP_CONCAT(DISTINCT(product) SEPARATOR ',') AS products
FROM Activities
GROUP BY sell_date
ORDER BY sell_date;

