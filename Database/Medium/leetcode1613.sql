# https://leetcode.com/problems/find-the-missing-ids/

# Table: Customers
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | customer_id   | int     |
# | customer_name | varchar |
# +---------------+---------+
# customer_id is the primary key for this table.
# Each row of this table contains the name and the id customer.
 
# Write an SQL query to find the missing customer IDs. The missing IDs are ones that are not in the Customers table but are in the range between 1 and the maximum customer_id present in the table.
# Notice that the maximum customer_id will not exceed 100.
# Return the result table ordered by ids in ascending order.

# My Solution
WITH RECURSIVE R AS(
    SELECT 1 AS ids
    UNION 
    SELECT ids+1 FROM R WHERE ids<100)
SELECT * FROM R WHERE ids NOT IN (SELECT CUSTOMER_ID FROM CUSTOMERS) AND ids <= (SELECT MAX(CUSTOMER_ID) FROM CUSTOMERS);


# Alternate Solution
with recursive cte as(
    select 1 id 
    union all
    select id + 1 from cte where id < (select max(customer_id) from customers)
)
select  cte.id as ids
from cte 
left join customers c
        on(cte.id = c.customer_id)
where c.customer_id is null;

