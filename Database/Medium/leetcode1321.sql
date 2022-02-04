# https://leetcode.com/problems/restaurant-growth/

# Table: Customer
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | customer_id   | int     |
# | name          | varchar |
# | visited_on    | date    |
# | amount        | int     |
# +---------------+---------+
# (customer_id, visited_on) is the primary key for this table.
# This table contains data about customer transactions in a restaurant.
# visited_on is the date on which the customer with ID (customer_id) has visited the restaurant.
# amount is the total paid by a customer.
 
# You are the restaurant owner and you want to analyze a possible expansion (there will be at least one customer every day).

# Write an SQL query to compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before). average_amount should be rounded to two decimal places.
# Return result table ordered by visited_on in ascending order.

# My Solution
WITH CTE AS (
    SELECT DISTINCT T.* FROM (
        SELECT VISITED_ON, 
               SUBDATE(VISITED_ON, 6) AS START_DATE
        FROM CUSTOMER) T
    WHERE START_DATE IN (SELECT VISITED_ON FROM CUSTOMER))

SELECT CTE.VISITED_ON,
       SUM(COALESCE(C.AMOUNT,0)) AS AMOUNT,
       ROUND((SUM(COALESCE(C.AMOUNT,0))/7),2) AS AVERAGE_AMOUNT
FROM CUSTOMER C LEFT JOIN CTE 
ON C.VISITED_ON BETWEEN CTE.START_DATE AND CTE.VISITED_ON 
GROUP BY CTE.VISITED_ON;


# Alternate Solution
select visited_on,
       sum(sum(amount)) over(order by visited_on asc ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) as amount,
       round(avg(sum(amount)) over(order by visited_on asc ROWS BETWEEN 6 PRECEDING AND CURRENT ROW),2)as average_amount
from Customer
group by visited_on
order by visited_on
limit 6, 1000;
