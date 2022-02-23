# https://leetcode.com/problems/warehouse-manager/

# Table: Warehouse
# +--------------+---------+
# | Column Name  | Type    |
# +--------------+---------+
# | name         | varchar |
# | product_id   | int     |
# | units        | int     |
# +--------------+---------+
# (name, product_id) is the primary key for this table.
# Each row of this table contains the information of the products in each warehouse.
 
# Table: Products
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | product_id    | int     |
# | product_name  | varchar |
# | Width         | int     |
# | Length        | int     |
# | Height        | int     |
# +---------------+---------+
# product_id is the primary key for this table.
# Each row of this table contains information about the product dimensions (Width, Lenght, and Height) in feets of each product.
 
# Write an SQL query to report the number of cubic feet of volume the inventory occupies in each warehouse.
# Return the result table in any order.

# My Solution
SELECT W.NAME AS WAREHOUSE_NAME, 
       SUM(W.UNITS*P.WIDTH*P.LENGTH*P.HEIGHT) AS VOLUME
FROM WAREHOUSE W JOIN PRODUCTS P
ON W.PRODUCT_ID = P.PRODUCT_ID
GROUP BY W.NAME;

