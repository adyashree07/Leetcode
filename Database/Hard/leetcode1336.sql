# https://leetcode.com/problems/number-of-transactions-per-visit/

# Table: Visits
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | user_id       | int     |
# | visit_date    | date    |
# +---------------+---------+
# (user_id, visit_date) is the primary key for this table.
# Each row of this table indicates that user_id has visited the bank in visit_date.
 
# Table: Transactions
# +------------------+---------+
# | Column Name      | Type    |
# +------------------+---------+
# | user_id          | int     |
# | transaction_date | date    |
# | amount           | int     |
# +------------------+---------+
# There is no primary key for this table, it may contain duplicates.
# Each row of this table indicates that user_id has done a transaction of amount in transaction_date.
# It is guaranteed that the user has visited the bank in the transaction_date.(i.e The Visits table contains (user_id, transaction_date) in one row)
 
# A bank wants to draw a chart of the number of transactions bank visitors did in one visit to the bank and the corresponding number of visitors who have done this number of transaction in one visit.

# Write an SQL query to find how many users visited the bank and didn't do any transactions, how many visited the bank and did one transaction and so on.
# The result table will contain two columns:
# 1. transactions_count which is the number of transactions done in one visit.
# 2. visits_count which is the corresponding number of users who did transactions_count in one visit to the bank.
# transactions_count should take all values from 0 to max(transactions_count) done by one or more users.
# Return the result table ordered by transactions_count.

# My Solution
WITH RECURSIVE T1 AS (
    SELECT VISIT_DATE, USER_ID,
           COUNT(DISTINCT USER_ID, VISIT_DATE) AS TOTAL_VISIT
    FROM VISITS
    GROUP BY USER_ID,VISIT_DATE),
T2 AS (
    SELECT USER_ID, TRANSACTION_DATE,
           COUNT(AMOUNT) AS TOTAL_TRANS 
    FROM TRANSACTIONS
    GROUP BY USER_ID,TRANSACTION_DATE),
    
T3 AS (
    SELECT DISTINCT T1.*,
           COALESCE(T2.TOTAL_TRANS,0) AS TOTAL_TRANS
    FROM T1 LEFT JOIN T2
    ON T1.VISIT_DATE = T2.TRANSACTION_DATE
    AND T1.USER_ID = T2.USER_ID
    ORDER BY T1.VISIT_DATE DESC),

T4 AS (
    SELECT 0 AS TRANSACTIONS_COUNT
    UNION
    SELECT 1+ TRANSACTIONS_COUNT FROM T4 
    WHERE TRANSACTIONS_COUNT < (SELECT MAX(TOTAL_TRANS) FROM T3))


SELECT T4.TRANSACTIONS_COUNT,
         COALESCE(COUNT(T3.TOTAL_TRANS),0) AS VISITS_COUNT
        
FROM T4 LEFT JOIN T3
ON T4.TRANSACTIONS_COUNT = T3.TOTAL_TRANS
GROUP BY T4.TRANSACTIONS_COUNT
ORDER BY TRANSACTIONS_COUNT;


# Alternate Solution
WITH
T1 AS
(
SELECT v.user_id
, visit_date
, count(transaction_date) AS num_transactions
FROM visits v
LEFT JOIN Transactions t
ON v.user_id = t.user_id
AND v.visit_date = t.transaction_date
GROUP BY 1, 2
ORDER BY 1, 2
)
,T2 AS
(
SELECT row_number() over () as num_transactions
FROM transactions UNION SELECT 0
)
SELECT T2.num_transactions AS transactions_count
, COUNT(T1.num_transactions) AS visits_count
FROM T2
LEFT JOIN T1
ON T2.num_transactions = T1.num_transactions
WHERE T2.num_transactions <= (SELECT MAX(num_transactions) FROM T1)
GROUP BY 1
ORDER by 1;

