# https://leetcode.com/problems/maximum-transaction-each-day/

# Table: Transactions
# +----------------+----------+
# | Column Name    | Type     |
# +----------------+----------+
# | transaction_id | int      |
# | day            | datetime |
# | amount         | int      |
# +----------------+----------+
# transaction_id is the primary key for this table.
# Each row contains information about one transaction.
 
# Write an SQL query to report the IDs of the transactions with the maximum amount on their respective day. If in one day there are multiple such transactions, return all of them.
# Return the result table ordered by transaction_id in ascending order.

# My Solution
SELECT TRANSACTION_ID FROM (
    SELECT TRANSACTION_ID, 
           DAY,
           DENSE_RANK() OVER (PARTITION BY DATE_FORMAT(DAY,"%Y-%m-%d") ORDER BY AMOUNT DESC) AS RNK
FROM TRANSACTIONS) T
WHERE RNK=1
ORDER BY TRANSACTION_ID;

