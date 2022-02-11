# https://leetcode.com/problems/sales-analysis-iii/

# Table: Product
# +--------------+---------+
# | Column Name  | Type    |
# +--------------+---------+
# | product_id   | int     |
# | product_name | varchar |
# | unit_price   | int     |
# +--------------+---------+
# product_id is the primary key of this table.
# Each row of this table indicates the name and the price of each product.

# Table: Sales
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | seller_id   | int     |
# | product_id  | int     |
# | buyer_id    | int     |
# | sale_date   | date    |
# | quantity    | int     |
# | price       | int     |
# +-------------+---------+
# This table has no primary key, it can have repeated rows.
# product_id is a foreign key to the Product table.
# Each row of this table contains some information about one sale.
 
# Write an SQL query that reports the products that were only sold in the spring of 2019. That is, between 2019-01-01 and 2019-03-31 inclusive.
# Return the result table in any order.

# My Solution
SELECT PRODUCT_ID, 
       PRODUCT_NAME 
FROM PRODUCT
WHERE PRODUCT_ID NOT IN (SELECT PRODUCT_ID FROM SALES WHERE SALE_DATE NOT BETWEEN "2019-01-01" AND "2019-03-31");

