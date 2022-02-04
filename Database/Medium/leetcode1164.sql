# https://leetcode.com/problems/product-price-at-a-given-date/

# Table: Products
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | product_id    | int     |
# | new_price     | int     |
# | change_date   | date    |
# +---------------+---------+
# (product_id, change_date) is the primary key of this table.
# Each row of this table indicates that the price of some product was changed to a new price at some date.
 
# Write an SQL query to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.
# Return the result table in any order.

# My Solution
WITH CTE AS (
    SELECT PRODUCT_ID, 
           NEW_PRICE AS PRICE, 
           ROW_NUMBER() OVER (PARTITION BY PRODUCT_ID ORDER BY CHANGE_DATE DESC) AS RNK 
    FROM PRODUCTS WHERE CHANGE_DATE<="2019-08-16")
SELECT PRODUCT_ID, 10 AS PRICE FROM PRODUCTS 
WHERE PRODUCT_ID NOT IN (SELECT PRODUCT_ID FROM CTE WHERE RNK=1)
UNION
SELECT PRODUCT_ID, PRICE FROM CTE WHERE RNK=1;


# Alternate Solution
with b as 
(select product_id, new_price, rank () over (partition by product_id order by change_date desc) rank1
from Products
where change_date <= "2019-08-16")


select distinct a.product_id, coalesce(b.new_price, 10) as price
from Products as a
left join b
on b.product_id = a.product_id
and b.rank1 = 1;

