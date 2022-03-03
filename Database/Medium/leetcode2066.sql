# https://leetcode.com/problems/account-balance/

# Table: Transactions
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | account_id  | int  |
# | day         | date |
# | type        | ENUM |
# | amount      | int  |
# +-------------+------+
# (account_id, day) is the primary key for this table.
# Each row contains information about one transaction, including the transaction type, the day it occurred on, and the amount.
# type is an ENUM of the type ('Deposit','Withdraw') 
 
# Write an SQL query to report the balance of each user after each transaction. You may assume that the balance of each account before any transaction is 0 and that the balance will never be below 0 at any moment.
# Return the result table in ascending order by account_id, then by day in case of a tie.

# My Solution
SELECT ACCOUNT_ID, 
       DAY, 
       SUM(AMOUNT) OVER (PARTITION BY ACCOUNT_ID ORDER BY DAY) AS BALANCE
FROM (
    SELECT ACCOUNT_ID, 
           DAY, 
           CASE WHEN TYPE="DEPOSIT" THEN AMOUNT
                   ELSE -1*AMOUNT
              END AS AMOUNT
    FROM TRANSACTIONS) T
ORDER BY 1,2;

