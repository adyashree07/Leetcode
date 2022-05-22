# https://leetcode.com/problems/sales-person/

# Table: SalesPerson
# +-----------------+---------+
# | Column Name     | Type    |
# +-----------------+---------+
# | sales_id        | int     |
# | name            | varchar |
# | salary          | int     |
# | commission_rate | int     |
# | hire_date       | date    |
# +-----------------+---------+
# sales_id is the primary key column for this table.
# Each row of this table indicates the name and the ID of a salesperson alongside their salary, commission rate, and hire date.
 
# Table: Company
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | com_id      | int     |
# | name        | varchar |
# | city        | varchar |
# +-------------+---------+
# com_id is the primary key column for this table.
# Each row of this table indicates the name and the ID of a company and the city in which the company is located.
 
# Table: Orders
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | order_id    | int  |
# | order_date  | date |
# | com_id      | int  |
# | sales_id    | int  |
# | amount      | int  |
# +-------------+------+
# order_id is the primary key column for this table.
# com_id is a foreign key to com_id from the Company table.
# sales_id is a foreign key to com_id from the SalesPerson table.
# Each row of this table contains information about one order. This includes the ID of the company, the ID of the salesperson, the date of the order, and the amount paid.
 
# Write an SQL query to report the names of all the salespersons who did not have any orders related to the company with the name "RED".
# Return the result table in any order.

# My Solution
SELECT DISTINCT T.SALES_NAME AS NAME FROM (
    SELECT S.SALES_ID, 
           S.NAME AS SALES_NAME, 
           O.COM_ID, 
           C.NAME 
    FROM SALESPERSON S LEFT JOIN ORDERS O 
    ON S.SALES_ID = O.SALES_ID 
    LEFT JOIN COMPANY C ON O.COM_ID = C.COM_ID
    WHERE (C.NAME!="RED" OR O.COM_ID IS NULL) AND 
    S.SALES_ID NOT IN (
        SELECT O1.SALES_ID FROM ORDERS O1 LEFT JOIN COMPANY  C1 
        ON O1.COM_ID = C1.COM_ID 
        WHERE C1.NAME="RED" )) T;


# My Solution -2
WITH T AS (
    SELECT O.SALES_ID
    FROM ORDERS O JOIN COMPANY C
    ON O.COM_ID = C.COM_ID
    WHERE C.NAME='RED')

SELECT NAME FROM SALESPERSON
WHERE SALES_ID NOT IN (SELECT * FROM T);


# Alternate Solution
SELECT name 
from salesperson 
where sales_id not in (select o.sales_id
                      from orders as o
                       join company as c
                       on o.com_id=c.com_id
                       where c.name='RED'
                       );

