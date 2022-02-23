# https://leetcode.com/problems/bank-account-summary-ii/

# Table: Users
# +--------------+---------+
# | Column Name  | Type    |
# +--------------+---------+
# | account      | int     |
# | name         | varchar |
# +--------------+---------+
# account is the primary key for this table.
# Each row of this table contains the account number of each user in the bank.
 
# Table: Transactions
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | trans_id      | int     |
# | account       | int     |
# | amount        | int     |
# | transacted_on | date    |
# +---------------+---------+
# trans_id is the primary key for this table.
# Each row of this table contains all changes made to all accounts.
# amount is positive if the user received money and negative if they transferred money.
# All accounts start with a balance of 0.
 
# Write an SQL query to report the name and balance of users with a balance higher than 10000. The balance of an account is equal to the sum of the amounts of all transactions involving that account.
# Return the result table in any order.

# My Solution
SELECT U.NAME, SUM(T.AMOUNT) AS BALANCE 
FROM USERS U JOIN TRANSACTIONS T
ON U.ACCOUNT = T.ACCOUNT
GROUP BY T.ACCOUNT
HAVING SUM(T.AMOUNT)>10000;


# Alternate Solution
With ct as (
    select account, sum(amount) as balance from Transactions
           group by account
           )

select Users.name , ct.balance from Users join ct using (account)
where balance>10000;

