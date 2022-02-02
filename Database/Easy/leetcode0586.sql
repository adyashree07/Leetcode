# https://leetcode.com/problems/customer-placing-the-largest-number-of-orders/

# Table: Orders
# +-----------------+----------+
# | Column Name     | Type     |
# +-----------------+----------+
# | order_number    | int      |
# | customer_number | int      |
# +-----------------+----------+
# order_number is the primary key for this table.
# This table contains information about the order ID and the customer ID.

# Write an SQL query to find the customer_number for the customer who has placed the largest number of orders.
# The test cases are generated so that exactly one customer will have placed more orders than any other customer.

# My Solution
WITH CTE AS (
    SELECT CUSTOMER_NUMBER, 
           COUNT(CUSTOMER_NUMBER) AS CNT 
    FROM ORDERS GROUP BY CUSTOMER_NUMBER)
SELECT CUSTOMER_NUMBER FROM CTE WHERE CNT = (SELECT MAX(CNT) FROM CTE);

