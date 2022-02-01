# https://leetcode.com/problems/orders-with-maximum-quantity-above-average/

# Table: OrdersDetails
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | order_id    | int  |
# | product_id  | int  |
# | quantity    | int  |
# +-------------+------+
# (order_id, product_id) is the primary key for this table.
# A single order is represented as multiple rows, one row for each product in the order.
# Each row of this table contains the quantity ordered of the product product_id in the order order_id.
 
# You are running an e-commerce site that is looking for imbalanced orders. An imbalanced order is one whose maximum quantity is strictly greater than the average quantity of every order (including itself).
# The average quantity of an order is calculated as (total quantity of all products in the order) / (number of different products in the order). The maximum quantity of an order is the highest quantity of any single product in the order.

# Write an SQL query to find the order_id of all imbalanced orders.
# Return the result table in any order.

# My Solution
WITH CTE AS 
      (SELECT ORDER_ID, 
              AVG(QUANTITY) AS AVERAGE, 
              MAX(QUANTITY) AS MAXIMUM 
       FROM ORDERSDETAILS GROUP BY ORDER_ID)
SELECT ORDER_ID FROM CTE WHERE MAXIMUM> (SELECT MAX(AVERAGE) FROM CTE);

