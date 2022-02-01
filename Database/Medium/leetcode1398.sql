# https://leetcode.com/problems/customers-who-bought-products-a-and-b-but-not-c/

# Table: Customers
# +---------------------+---------+
# | Column Name         | Type    |
# +---------------------+---------+
# | customer_id         | int     |
# | customer_name       | varchar |
# +---------------------+---------+
# customer_id is the primary key for this table.
# customer_name is the name of the customer.
 
# Table: Orders
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | order_id      | int     |
# | customer_id   | int     |
# | product_name  | varchar |
# +---------------+---------+
# order_id is the primary key for this table.
# customer_id is the id of the customer who bought the product "product_name".
 
# Write an SQL query to report the customer_id and customer_name of customers who bought products "A", "B" but did not buy the product "C" since we want to recommend them to purchase this product.
# Return the result table ordered by customer_id.

# My Solution
SELECT T.CUSTOMER_ID, T.CUSTOMER_NAME FROM
(SELECT C.*, 
 GROUP_CONCAT(O.PRODUCT_NAME) AS PRD_LST 
 FROM CUSTOMERS C INNER JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID 
 GROUP BY O.CUSTOMER_ID 
 HAVING PRD_LST LIKE "%A%" AND PRD_LST LIKE "%B%" AND PRD_LST NOT LIKE "%C%") T;


# Altenate Solution
with t as(
select c.customer_id, c.customer_name
    ,group_concat(o.product_name) as prd
from (select distinct customer_id,product_name from Orders) o
join Customers c
on  o.customer_id=c.customer_id
  where o.product_name in ('A','B','C')   
    group by c.customer_id,c.customer_name
    order by o.product_name
    )
select distinct t.customer_id,t.customer_name
from t
where t.prd in ('A,B','B,A') 
order by t.customer_id

