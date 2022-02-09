# https://leetcode.com/problems/market-analysis-ii/

# Table: Users
# +----------------+---------+
# | Column Name    | Type    |
# +----------------+---------+
# | user_id        | int     |
# | join_date      | date    |
# | favorite_brand | varchar |
# +----------------+---------+
# user_id is the primary key of this table.
# This table has the info of the users of an online shopping website where users can sell and buy items.
 
# Table: Orders
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | order_id      | int     |
# | order_date    | date    |
# | item_id       | int     |
# | buyer_id      | int     |
# | seller_id     | int     |
# +---------------+---------+
# order_id is the primary key of this table.
# item_id is a foreign key to the Items table.
# buyer_id and seller_id are foreign keys to the Users table.
 
# Table: Items
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | item_id       | int     |
# | item_brand    | varchar |
# +---------------+---------+
# item_id is the primary key of this table.
 
# Write an SQL query to find for each user whether the brand of the second item (by date) they sold is their favorite brand. 
# If a user sold less than two items, report the answer for that user as no. It is guaranteed that no seller sold more than one item on a day.
# Return the result table in any order.

# My Solution
WITH T AS (
    SELECT U.USER_ID, 
           U.FAVORITE_BRAND,
           ROW_NUMBER() OVER (PARTITION BY U.USER_ID ORDER BY O.ORDER_DATE) AS RNK,
           O.ITEM_ID,
           I.ITEM_BRAND
    FROM USERS U LEFT JOIN ORDERS O 
    ON U.USER_ID = O.SELLER_ID LEFT JOIN 
    ITEMS I
    ON O.ITEM_ID = I.ITEM_ID),
T1 AS (
    SELECT USER_ID AS SELLER_ID, 
       CASE WHEN FAVORITE_BRAND = ITEM_BRAND AND RNK=2 THEN "yes"
            ELSE "no"
       END AS 2ND_ITEM_FAV_BRAND
       FROM T WHERE RNK=2)
       
SELECT * FROM T1
UNION 
SELECT USER_ID AS SELLER_ID, 
       "no" AS 2ND_ITEM_FAV_BRAND 
FROM T 
WHERE USER_ID NOT IN (SELECT SELLER_ID FROM T1);


# Alternate Solution
select 
user_id as seller_id,
ifnull(2nd_item_fav_brand,"no") as 2nd_item_fav_brand
from
Users
left join
(
select
user_id as seller_id,
case when favorite_brand=item_brand then "yes"
else "no" end as 2nd_item_fav_brand 
from
(
select
u.user_id,
u.favorite_brand,
o.order_date,
i.item_brand,
row_number() over (partition by u.user_id order by o.order_date) as rk
from
Users u
left join 
Orders o
on u.user_id=o.seller_id 
left join
Items i
on o.item_id =i.item_id 
)a 
where rk=2) b
on Users.user_id=b.seller_id;



