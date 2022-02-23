# https://leetcode.com/problems/rearrange-products-table/

# Table: Products
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | product_id  | int     |
# | store1      | int     |
# | store2      | int     |
# | store3      | int     |
# +-------------+---------+
# product_id is the primary key for this table.
# Each row in this table indicates the product's price in 3 different stores: store1, store2, and store3.
# If the product is not available in a store, the price will be null in that store's column.
 
# Write an SQL query to rearrange the Products table so that each row has (product_id, store, price). If a product is not available in a store, do not include a row with that product_id and store combination in the result table.
# Return the result table in any order.

# My Solution
SELECT PRODUCT_ID, 
       "store1" AS STORE,
       STORE1 AS PRICE
FROM PRODUCTS
WHERE STORE1 IS NOT NULL
UNION 
SELECT PRODUCT_ID, 
       "store2" AS STORE,
       STORE2 AS PRICE
FROM PRODUCTS
WHERE STORE2 IS NOT NULL
UNION
SELECT PRODUCT_ID, 
       "store3" AS STORE,
       STORE3 AS PRICE
FROM PRODUCTS
WHERE STORE3 IS NOT NULL;

