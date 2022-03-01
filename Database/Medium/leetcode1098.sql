# https://leetcode.com/problems/unpopular-books/

# Table: Books
# +----------------+---------+
# | Column Name    | Type    |
# +----------------+---------+
# | book_id        | int     |
# | name           | varchar |
# | available_from | date    |
# +----------------+---------+
# book_id is the primary key of this table.
 
# Table: Orders
# +----------------+---------+
# | Column Name    | Type    |
# +----------------+---------+
# | order_id       | int     |
# | book_id        | int     |
# | quantity       | int     |
# | dispatch_date  | date    |
# +----------------+---------+
# order_id is the primary key of this table.
# book_id is a foreign key to the Books table.
 
# Write an SQL query that reports the books that have sold less than 10 copies in the last year, excluding books that have been available for less than one month from today. Assume today is 2019-06-23.
# Return the result table in any order.

# My Solution
SELECT BOOK_ID, NAME
FROM BOOKS
WHERE BOOK_ID NOT IN (SELECT BOOK_ID FROM ORDERS WHERE DATEDIFF("2019-06-23",DISPATCH_DATE)<=365 GROUP BY BOOK_ID HAVING SUM(QUANTITY)>=10)
AND DATEDIFF("2019-06-23",AVAILABLE_FROM)>30;


# Alternate Solution
with t as
(
    select book_id,name,available_from 
    from Books 
    where available_from not between date_add('2019-06-23',interval -1 month) and '2019-06-23'
)

select t.book_id,t.name
from t
left join Orders o
on t.book_id=o.book_id 
and dispatch_date >'2018-06-23'
group by t.book_id
having coalesce(sum(quantity),0)<10;


# Alternate Solution-2
select b.book_id, b.name from
(select * from books where available_from < '2019-05-23') b
left join
(select * from Orders where dispatch_date > '2018-06-23') o
on b.book_id = o.book_id
group by b.book_id, b.name
having sum(o.quantity) is null or sum(o.quantity) <10;

