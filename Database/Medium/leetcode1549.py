# https://leetcode.com/problems/the-most-recent-orders-for-each-product/

# Table: Customers
# +---------------+---------+
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
# There will be no product ordered by the same user more than once in one day. 

# Table: Products
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | product_id    | int     |
# | product_name  | varchar |
# | price         | int     |
# +---------------+---------+
# product_id is the primary key for this table.
# This table contains information about the Products.
 
# Write an SQL query to find the most recent order(s) of each product.
# Return the result table ordered by product_name in ascending order and in case of a tie by the product_id in ascending order. If there still a tie, order them by order_id in ascending order.

# My Solution
SELECT T.PRODUCT_NAME, T.PRODUCT_ID, T.ORDER_ID, T.ORDER_DATE FROM (
    SELECT P.PRODUCT_ID, 
           P.PRODUCT_NAME, 
           O.ORDER_ID, 
           O.ORDER_DATE, 
           DENSE_RANK() OVER (PARTITION BY P.PRODUCT_ID ORDER BY O.ORDER_DATE DESC) AS RNK 
    FROM PRODUCTS P JOIN ORDERS O ON P.PRODUCT_ID=O.PRODUCT_ID) T
WHERE T.RNK=1 
ORDER BY T.PRODUCT_NAME, T.PRODUCT_ID, T.ORDER_ID;

