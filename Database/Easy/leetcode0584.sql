# https://leetcode.com/problems/find-customer-referee/

# Table: Customer
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | id          | int     |
# | name        | varchar |
# | referee_id  | int     |
# +-------------+---------+
# id is the primary key column for this table.
# Each row of this table indicates the id of a customer, their name, and the id of the customer who referred them.
 
# Write an SQL query to report the IDs of the customer that are not referred by the customer with id = 2.
# Return the result table in any order.

# My Solution
SELECT NAME FROM CUSTOMER WHERE REFEREE_ID!=2 OR REFEREE_ID IS NULL;
