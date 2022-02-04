# https://leetcode.com/problems/convert-date-format/

# Table: Days
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | day         | date |
# +-------------+------+
# day is the primary key for this table.
 
# Write an SQL query to convert each date in Days into a string formatted as "day_name, month_name day, year".
# Return the result table in any order.

# My Solution
SELECT DATE_FORMAT(DAY, "%W, %M %e, %Y") as DAY FROM DAYS;

