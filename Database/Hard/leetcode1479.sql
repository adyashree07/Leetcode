# https://leetcode.com/problems/sales-by-day-of-the-week/

# Table: Orders
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | order_id      | int     |
# | customer_id   | int     |
# | order_date    | date    | 
# | item_id       | varchar |
# | quantity      | int     |
# +---------------+---------+
# (ordered_id, item_id) is the primary key for this table.
# This table contains information on the orders placed.
# order_date is the date item_id was ordered by the customer with id customer_id.
 
# Table: Items
# +---------------------+---------+
# | Column Name         | Type    |
# +---------------------+---------+
# | item_id             | varchar |
# | item_name           | varchar |
# | item_category       | varchar |
# +---------------------+---------+
# item_id is the primary key for this table.
# item_name is the name of the item.
# item_category is the category of the item.
 
# You are the business owner and would like to obtain a sales report for category items and the day of the week.
# Write an SQL query to report how many units in each category have been ordered on each day of the week.
# Return the result table ordered by category.

# My Solution
WITH RECURSIVE R AS (
    SELECT 1 AS DT
    UNION
    SELECT DT+1 FROM R WHERE DT<7),
T1 AS (
    SELECT CASE WHEN DT=1 THEN "Monday"
                WHEN DT=2 THEN "Tuesday"
                WHEN DT=3 THEN "Wednesday"
                WHEN DT=4 THEN "Thursday"
                WHEN DT=5 THEN "Friday"
                WHEN DT=6 THEN "Saturday"
                ELSE "Sunday"
            END AS WEEKDAY
    FROM R),
T2 AS (
    SELECT I.ITEM_ID, I.ITEM_CATEGORY,
           T1.WEEKDAY
    FROM ITEMS I,T1),
T3 AS (
    SELECT T2.ITEM_CATEGORY AS CATEGORY, 
           T2.WEEKDAY AS DAY,
           COALESCE(SUM(O.QUANTITY),0) AS QUANTITY
    FROM T2 LEFT JOIN ORDERS O
    ON T2.ITEM_ID = O.ITEM_ID AND T2.WEEKDAY = DAYNAME(O.ORDER_DATE)
    GROUP BY 1,2)

SELECT CATEGORY,
       SUM(IF(DAY="Monday",QUANTITY,0)) AS MONDAY,
       SUM(IF(DAY="Tuesday",QUANTITY,0)) AS TUESDAY,
       SUM(IF(DAY="Wednesday",QUANTITY,0)) AS WEDNESDAY,
       SUM(IF(DAY="Thursday",QUANTITY,0)) AS THURSDAY,
       SUM(IF(DAY="Friday",QUANTITY,0)) AS FRIDAY,
       SUM(IF(DAY="Saturday",QUANTITY,0)) AS SATURDAY,
       SUM(IF(DAY="Sunday",QUANTITY,0)) AS SUNDAY
FROM T3
GROUP BY CATEGORY
ORDER BY CATEGORY;
    
 
# Alternate Solution
with t as(
select item_category
    ,date_format(order_date,'%W') as day
    ,quantity 
from Orders o
    right join Items i
on o.item_id=i.item_id
)
  
select item_category as CATEGORY,
sum(if(day='Monday',quantity ,0)) as MONDAY,
sum(if(day='Tuesday',quantity ,0)) TUESDAY,
sum(if(day='Wednesday',quantity ,0)) WEDNESDAY,
sum(if(day='Thursday',quantity ,0)) THURSDAY,
sum(if(day='Friday',quantity ,0)) FRIDAY,
sum(if(day='Saturday',quantity ,0)) SATURDAY,
sum(if(day='Sunday',quantity ,0)) SUNDAY
from t
group by item_category
order by item_category;

