# https://leetcode.com/problems/count-apples-and-oranges/

# Table: Boxes
# +--------------+------+
# | Column Name  | Type |
# +--------------+------+
# | box_id       | int  |
# | chest_id     | int  |
# | apple_count  | int  |
# | orange_count | int  |
# +--------------+------+
# box_id is the primary key for this table.
# chest_id is a foreign key of the chests table.
# This table contains information about the boxes and the number of oranges and apples they have. Each box may include a chest, which also can contain oranges and apples.
 
# Table: Chests
# +--------------+------+
# | Column Name  | Type |
# +--------------+------+
# | chest_id     | int  |
# | apple_count  | int  |
# | orange_count | int  |
# +--------------+------+
# chest_id is the primary key for this table.
# This table contains information about the chests and the corresponding number of oranges and apples they have.

# Write an SQL query to count the number of apples and oranges in all the boxes. If a box contains a chest, you should also include the number of apples and oranges it has.

# My Solution
SELECT SUM(B.APPLE_COUNT+COALESCE(C.APPLE_COUNT,0)) AS APPLE_COUNT, 
       SUM(B.ORANGE_COUNT+COALESCE(C.ORANGE_COUNT,0)) AS ORANGE_COUNT 
 FROM BOXES B LEFT JOIN CHESTS C ON B.CHEST_ID= C.CHEST_ID;


# Alternate Solution
select (ifnull(sum(b.apple_count),0) + ifnull(sum(c.apple_count), 0)) as apple_count ,
(ifnull(sum(b.orange_count),0) + ifnull(sum(c.orange_count), 0)) as orange_count
from boxes b
left join chests c
on b.chest_id = c.chest_id;


