# https://leetcode.com/problems/market-analysis-i/

# Table: Users
# +----------------+---------+
# | Column Name    | Type    |
# +----------------+---------+
# | user_id        | int     |
# | join_date      | date    |
# | favorite_brand | varchar |
# +----------------+---------+
# user_id is the primary key of this table.
# This table has the info of the users of an online shopping website where users can sell and buy items.
 
# Table: Orders
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | order_id      | int     |
# | order_date    | date    |
# | item_id       | int     |
# | buyer_id      | int     |
# | seller_id     | int     |
# +---------------+---------+
# order_id is the primary key of this table.
# item_id is a foreign key to the Items table.
# buyer_id and seller_id are foreign keys to the Users table.
 
# Table: Items
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | item_id       | int     |
# | item_brand    | varchar |
# +---------------+---------+
# item_id is the primary key of this table.
 
# Write an SQL query to find for each user, the join date and the number of orders they made as a buyer in 2019.
# Return the result table in any order.

# My Solution
SELECT U.USER_ID AS BUYER_ID, 
       U.JOIN_DATE, 
       COALESCE(COUNT(O.ORDER_ID),0) AS ORDERS_IN_2019 
FROM USERS U LEFT JOIN ORDERS O 
ON U.USER_ID = O.BUYER_ID AND YEAR(O.ORDER_DATE)=2019
GROUP BY U.USER_ID;

