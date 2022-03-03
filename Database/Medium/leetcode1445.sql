# https://leetcode.com/problems/apples-oranges/

# Table: Sales
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | sale_date     | date    |
# | fruit         | enum    | 
# | sold_num      | int     | 
# +---------------+---------+
# (sale_date, fruit) is the primary key for this table.
# This table contains the sales of "apples" and "oranges" sold each day.
 
# Write an SQL query to report the difference between the number of apples and oranges sold each day.
# Return the result table ordered by sale_date.

# My Solution
SELECT SALE_DATE,
       SUM(IF(FRUIT="apples",SOLD_NUM,0)) - SUM(IF(FRUIT="oranges",SOLD_NUM,0)) AS DIFF
FROM SALES
GROUP BY SALE_DATE
ORDER BY SALE_DATE;


# Alternate Solution
select sale_date,sum(sold)as diff
from(select sale_date, fruit,case when fruit = 'oranges'then - sold_num
else sold_num end as sold
from sales)temp
group by sale_date;

