# https://leetcode.com/problems/immediate-food-delivery-ii/

# Table: Delivery
# +-----------------------------+---------+
# | Column Name                 | Type    |
# +-----------------------------+---------+
# | delivery_id                 | int     |
# | customer_id                 | int     |
# | order_date                  | date    |
# | customer_pref_delivery_date | date    |
# +-----------------------------+---------+
# delivery_id is the primary key of this table.
# The table holds information about food delivery to customers that make orders at some date and specify a preferred delivery date (on the same order date or after it).
 
# If the customer's preferred delivery date is the same as the order date, then the order is called immediate; otherwise, it is called scheduled.
# The first order of a customer is the order with the earliest order date that the customer made. It is guaranteed that a customer has precisely one first order.
# Write an SQL query to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.

# My Solution
SELECT ROUND(AVG(DELIVERY_TYPE="Immediate")*100,2) AS IMMEDIATE_PERCENTAGE FROM (
    SELECT CUSTOMER_ID, 
           ROW_NUMBER() OVER (PARTITION BY CUSTOMER_ID ORDER BY ORDER_DATE) AS RNK,
           CASE WHEN ORDER_DATE=CUSTOMER_PREF_DELIVERY_DATE THEN "Immediate"
                ELSE "Scheduled"
           END AS DELIVERY_TYPE
    FROM DELIVERY) T
WHERE T.RNK=1;


# Alternate Solution
with t as
(  select delivery_id,customer_id,order_date,customer_pref_delivery_date from
    (
        select * ,rank() over(partition by customer_id order by order_date) rnk from Delivery
    )t1
    where rnk=1  
 )
select 
round(count(if(order_date=customer_pref_delivery_date,1,Null))/count(distinct customer_id)*100,2) immediate_percentage
from t;

