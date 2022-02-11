# https://leetcode.com/problems/sellers-with-no-sales/

# Table: Customer
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | customer_id   | int     |
# | customer_name | varchar |
# +---------------+---------+
# customer_id is the primary key for this table.
# Each row of this table contains the information of each customer in the WebStore.
 
# Table: Orders
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | order_id      | int     |
# | sale_date     | date    |
# | order_cost    | int     |
# | customer_id   | int     |
# | seller_id     | int     |
# +---------------+---------+
# order_id is the primary key for this table.
# Each row of this table contains all orders made in the webstore.
# sale_date is the date when the transaction was made between the customer (customer_id) and the seller (seller_id).
 
# Table: Seller
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | seller_id     | int     |
# | seller_name   | varchar |
# +---------------+---------+
# seller_id is the primary key for this table.
# Each row of this table contains the information of each seller.
 
# Write an SQL query to report the names of all sellers who did not make any sales in 2020.
# Return the result table ordered by seller_name in ascending order.

# My Solution
SELECT SELLER_NAME FROM SELLER 
WHERE SELLER_ID NOT IN 
(SELECT SELLER_ID FROM ORDERS WHERE YEAR(SALE_DATE)=2020)
ORDER BY SELLER_NAME;

