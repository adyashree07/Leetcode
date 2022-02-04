# https://leetcode.com/problems/products-price-for-each-store/

# Table: Products
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | product_id  | int     |
# | store       | enum    |
# | price       | int     |
# +-------------+---------+
# (product_id, store) is the primary key for this table.
# store is an ENUM of type ('store1', 'store2', 'store3') where each represents the store this product is available at.
# price is the price of the product at this store.
 
# Write an SQL query to find the price of each product in each store.
# Return the result table in any order.

# My Solution
SELECT DISTINCT P.PRODUCT_ID,
       P1.PRICE AS STORE1,
       P2.PRICE AS STORE2,
       P3.PRICE AS STORE3
FROM PRODUCTS P LEFT JOIN PRODUCTS P1
ON P.PRODUCT_ID = P1.PRODUCT_ID AND P1.STORE="store1" 
LEFT JOIN PRODUCTS P2 
ON P.PRODUCT_ID = P2.PRODUCT_ID AND P2.STORE="store2"
LEFT JOIN PRODUCTS P3 
ON P.PRODUCT_ID = P3.PRODUCT_ID AND P3.STORE="store3";


# Alternate Solution
select product_id,

    sum(case when store ='store1' then price else  null end )  as store1,
    sum(case when store ='store2' then price else  null end )  as store2,
    sum(case when store ='store3' then price else  null end )  as store3
    from products
group by product_id;

