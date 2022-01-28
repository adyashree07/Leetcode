# https://leetcode.com/problems/drop-type-1-orders-for-customers-with-type-0-orders/

# Table: Orders

# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | order_id    | int  | 
# | customer_id | int  |
# | order_type  | int  | 
# +-------------+------+
# order_id is the primary key column for this table.
# Each row of this table indicates the ID of an order, the ID of the customer who ordered it, and the order type.
# The orders could be of type 0 or type 1.
 

# Write an SQL query to report all the orders based on the following criteria:
# 1. If a customer has at least one order of type 0, do not report any order of type 1 from that customer.
# 2. Otherwise, report all the orders of the customer.
# Return the result table in any order.

# My Solution
SELECT T.ORDER_ID, T.CUSTOMER_ID, T.ORDER_TYPE FROM
(SELECT DENSE_RANK() OVER (PARTITION BY CUSTOMER_ID ORDER BY ORDER_TYPE) AS RNK, ORDER_ID, CUSTOMER_ID, ORDER_TYPE FROM ORDERS) T WHERE T.RNK=1;

# Alternate Solution
(select * from Orders where order_type='0')
union
(select * from Orders where customer_id not in (select customer_id from Orders where order_type='0'))
