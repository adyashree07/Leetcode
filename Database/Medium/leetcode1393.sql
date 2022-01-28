# https://leetcode.com/problems/capital-gainloss/

# Table: Stocks

# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | stock_name    | varchar |
# | operation     | enum    |
# | operation_day | int     |
# | price         | int     |
# +---------------+---------+
# (stock_name, operation_day) is the primary key for this table.
# The operation column is an ENUM of type ('Sell', 'Buy')
# Each row of this table indicates that the stock which has stock_name had an operation on the day operation_day with the price.
# It is guaranteed that each 'Sell' operation for a stock has a corresponding 'Buy' operation in a previous day. It is also guaranteed that each 'Buy' operation for a stock has a corresponding 'Sell' operation in an upcoming day.
 
# Write an SQL query to report the Capital gain/loss for each stock.
# The Capital gain/loss of a stock is the total gain or loss after buying and selling the stock one or many times.
# Return the result table in any order.

# My Solution
# Write your MySQL query statement below
SELECT STOCK_NAME,
SUM(CASE WHEN OPERATION="Buy" THEN PRICE*-1
ELSE PRICE 
END) AS CAPITAL_GAIN_LOSS
FROM STOCKS GROUP BY STOCK_NAME;


# Alternate Solution
select t1.stock_name,(t2.Sell-t1.Buy) as capital_gain_loss
from
(select stock_name,sum(price) as Buy from Stocks
where operation='Buy'
group by stock_name)t1
left join
(select stock_name,sum(price) as Sell from Stocks
where operation='Sell'
group by stock_name)t2
on t1.stock_name=t2.stock_name;

