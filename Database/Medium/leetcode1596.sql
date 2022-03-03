# https://leetcode.com/problems/the-most-frequently-ordered-products-for-each-customer/

# Table: Customers
+---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | customer_id   | int     |
# | name          | varchar |
# +---------------+---------+
# customer_id is the primary key for this table.
# This table contains information about the customers.
 
# Table: Orders
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | order_id      | int     |
# | order_date    | date    |
# | customer_id   | int     |
# | product_id    | int     |
# +---------------+---------+
# order_id is the primary key for this table.
# This table contains information about the orders made by customer_id.
# No customer will order the same product more than once in a single day.
 
# Table: Products
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | product_id    | int     |
# | product_name  | varchar |
# | price         | int     |
# +---------------+---------+
# product_id is the primary key for this table.
# This table contains information about the products.
 
# Write an SQL query to find the most frequently ordered product(s) for each customer.
# The result table should have the product_id and product_name for each customer_id who ordered at least one order.
# Return the result table in any order.

# My Solution
WITH T AS (
    SELECT CUSTOMER_ID, 
           PRODUCT_ID, 
           DENSE_RANK() OVER (PARTITION BY CUSTOMER_ID ORDER BY CNT DESC) AS RNK FROM (
        SELECT CUSTOMER_ID, PRODUCT_ID, COUNT(ORDER_ID) AS CNT
        FROM ORDERS 
        GROUP BY CUSTOMER_ID, PRODUCT_ID
        ORDER BY CUSTOMER_ID, CNT DESC) T)
    
SELECT T.CUSTOMER_ID, T.PRODUCT_ID, P.PRODUCT_NAME
FROM T JOIN PRODUCTS P
ON T.PRODUCT_ID = P.PRODUCT_ID
WHERE RNK=1;

