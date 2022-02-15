# https://leetcode.com/problems/sales-analysis-ii/

# Table: Product
# +--------------+---------+
# | Column Name  | Type    |
# +--------------+---------+
# | product_id   | int     |
# | product_name | varchar |
# | unit_price   | int     |
# +--------------+---------+
# product_id is the primary key of this table.
# Each row of this table indicates the name and the price of each product.

# Table: Sales
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | seller_id   | int     |
# | product_id  | int     |
# | buyer_id    | int     |
# | sale_date   | date    |
# | quantity    | int     |
# | price       | int     |
# +-------------+---------+
# This table has no primary key, it can have repeated rows.
# product_id is a foreign key to the Product table.
# Each row of this table contains some information about one sale.

# Write an SQL query that reports the buyers who have bought S8 but not iPhone. Note that S8 and iPhone are products present in the Product table.
# Return the result table in any order.

# My Solution
SELECT DISTINCT S.BUYER_ID 
FROM SALES S JOIN PRODUCT P
ON S.PRODUCT_ID = P.PRODUCT_ID
WHERE P.PRODUCT_NAME="S8"
AND S.BUYER_ID NOT IN (SELECT BUYER_ID FROM SALES JOIN PRODUCT ON SALES.PRODUCT_ID = PRODUCT.PRODUCT_ID WHERE PRODUCT.PRODUCT_NAME='iPhone')


# Alternate Solution
with t as
(
    select product_name,buyer_id
    from Sales s
    join Product p
    on s.product_id=p.product_id
)
select distinct  buyer_id  from t 
where product_name='S8' 
and buyer_id  not in (select buyer_id  from t where product_name='iPhone');


# Alternate Solution-2
with t as
(
    select product_name,buyer_id
    from Sales s
    left join Product p
    on s.product_id=p.product_id
)
select distinct buyer_id from t
group by buyer_id
HAVING SUM(product_name = 'S8') > 0 AND SUM(product_name ='iPhone') = 0;

