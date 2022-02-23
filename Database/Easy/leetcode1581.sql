# https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/

# Table: Visits
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | visit_id    | int     |
# | customer_id | int     |
# +-------------+---------+
# visit_id is the primary key for this table.
# This table contains information about the customers who visited the mall.
 
# Table: Transactions
# +----------------+---------+
# | Column Name    | Type    |
# +----------------+---------+
# | transaction_id | int     |
# | visit_id       | int     |
# | amount         | int     |
# +----------------+---------+
# transaction_id is the primary key for this table.
# This table contains information about the transactions made during the visit_id.
 
# Write an SQL query to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.
# Return the result table sorted in any order.

# My Solution
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS 
FROM VISITS
WHERE VISIT_ID NOT IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS)
GROUP BY CUSTOMER_ID;


# Alternate Solution
SELECT  Visits.customer_id
       ,COUNT(*) AS count_no_trans
FROM Visits
LEFT JOIN Transactions
ON Visits.visit_id = Transactions.visit_id
WHERE Transactions.visit_id is null
GROUP BY  Visits.customer_id;

