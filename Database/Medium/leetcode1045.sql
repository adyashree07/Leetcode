# https://leetcode.com/problems/customers-who-bought-all-products/

# Table: Customer
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | customer_id | int     |
# | product_key | int     |
# +-------------+---------+
# There is no primary key for this table. It may contain duplicates.
# product_key is a foreign key to Product table.
 
# Table: Product
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | product_key | int     |
# +-------------+---------+
# product_key is the primary key column for this table.
 
# Write an SQL query to report the customer ids from the Customer table that bought all the products in the Product table.
# Return the result table in any order.

# My Solution
SELECT CUSTOMER_ID FROM CUSTOMER 
GROUP BY CUSTOMER_ID
HAVING COUNT(DISTINCT PRODUCT_KEY) = (SELECT COUNT(*) FROM PRODUCT);

