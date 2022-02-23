# https://leetcode.com/problems/find-customers-with-positive-revenue-this-year/

# Table: Customers
# +--------------+------+
# | Column Name  | Type |
# +--------------+------+
# | customer_id  | int  |
# | year         | int  |
# | revenue      | int  |
# +--------------+------+
# (customer_id, year) is the primary key for this table.
# This table contains the customer ID and the revenue of customers in different years.
# Note that this revenue can be negative.
 
# Write an SQL query to report the customers with postive revenue in the year 2021.
# Return the result table in any order.

# My Solution
SELECT DISTINCT CUSTOMER_ID FROM CUSTOMERS 
WHERE YEAR=2021 AND REVENUE>0;

