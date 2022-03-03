# https://leetcode.com/problems/the-most-recent-three-orders/

# Table: Customers
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | customer_id   | int     |
# | name          | varchar |
# +---------------+---------+
# customer_id is the primary key for this table.
# This table contains information about customers.
 
# Table: Orders
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | order_id      | int     |
# | order_date    | date    |
# | customer_id   | int     |
# | cost          | int     |
# +---------------+---------+
# order_id is the primary key for this table.
# This table contains information about the orders made by customer_id.
# Each customer has one order per day.
 
# Write an SQL query to find the most recent three orders of each user. If a user ordered less than three orders, return all of their orders.
# Return the result table ordered by customer_name in ascending order and in case of a tie by the customer_id in ascending order. If there is still a tie, order them by order_date in descending order.

# My Solution
SELECT C.NAME AS CUSTOMER_NAME, 
       T.CUSTOMER_ID, T.ORDER_ID, T.ORDER_DATE FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY CUSTOMER_ID ORDER BY ORDER_DATE DESC) AS RNK
    FROM ORDERS) T
JOIN CUSTOMERS C
ON T.CUSTOMER_ID = C.CUSTOMER_ID
WHERE RNK<=3
ORDER BY CUSTOMER_NAME, CUSTOMER_ID, ORDER_DATE DESC;


# Alternate Solution
select name as customer_name,customer_id,order_id,order_date
from (
select o.customer_id,c.name,order_id,order_date,
dense_rank()over(partition by o.customer_id order by order_date desc) as rk
from orders o left join Customers c 
on o.customer_id = c.customer_id ) sub1
where rk <=3
order by 1,2,4 desc;

