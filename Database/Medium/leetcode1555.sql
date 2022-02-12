# https://leetcode.com/problems/bank-account-summary/

# Table: Users
# +--------------+---------+
# | Column Name  | Type    |
# +--------------+---------+
# | user_id      | int     |
# | user_name    | varchar |
# | credit       | int     |
# +--------------+---------+
# user_id is the primary key for this table.
# Each row of this table contains the current credit information for each user.
 
# Table: Transactions
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | trans_id      | int     |
# | paid_by       | int     |
# | paid_to       | int     |
# | amount        | int     |
# | transacted_on | date    |
# +---------------+---------+
# trans_id is the primary key for this table.
# Each row of this table contains information about the transaction in the bank.
# User with id (paid_by) transfer money to user with id (paid_to).
 
# Leetcode Bank (LCB) helps its coders in making virtual payments. Our bank records all transactions in the table Transaction, we want to find out the current balance of all users and check whether they have breached their credit limit (If their current credit is less than 0).
# Write an SQL query to report.
# 1. user_id,
# 2. user_name,
# 3. credit, current balance after performing transactions, and
# 4. credit_limit_breached, check credit_limit ("Yes" or "No")
# Return the result table in any order.

# My Solution
SELECT T.USER_ID,
       T.USER_NAME,
       T.CREDIT + COALESCE(SUM(T2.AMOUNT),0) AS CREDIT,
       CASE WHEN T.CREDIT + COALESCE(SUM(T2.AMOUNT),0) <0 THEN "Yes"
            ELSE "No"
       END AS CREDIT_LIMIT_BREACHED
FROM (
    SELECT U.USER_ID, 
           U.USER_NAME, 
           U.CREDIT-COALESCE(SUM(T1.AMOUNT),0) AS CREDIT
    FROM USERS U LEFT JOIN TRANSACTIONS T1
    ON U.USER_ID = T1.PAID_BY 
    GROUP BY U.USER_ID) T    
LEFT JOIN TRANSACTIONS T2
ON T.USER_ID = T2.PAID_TO
GROUP BY T.USER_ID;


# Alternate Solution
with t1 as
(
    select user_id,sum(amount) amount from
    (
        select paid_by user_id ,-1*amount as amount from Transactions
        union all
        select paid_to user_id ,amount from Transactions
    )t
    group by user_id
)

select u.user_id ,u.user_name ,credit+coalesce(amount,0) credit
    , case when credit+coalesce(amount,0)<0 then 'Yes'
    else 'No'
    end as  credit_limit_breached
from Users u
left join t1
on u.user_id = t1.user_id;


# Alternate Solution-2
with cte as (
    select paid_by as id, -1 *amount as amount from transactions
    union all
    select paid_to as id, amount as amount from transactions
)
 select a.user_id, 
        a.user_name, 
        coalesce(sum(b.amount), 0) + a.credit as credit,
        case when coalesce(sum(b.amount), 0) + a.credit < 0 then 'Yes' else 'No' end as credit_limit_breached 
from users a left join cte b on a.user_id = b.id
group by 1;

