# https://leetcode.com/problems/count-salary-categories/

# Table: Accounts
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | account_id  | int  |
# | income      | int  |
# +-------------+------+
# account_id is the primary key for this table.
# Each row contains information about the monthly income for one bank account.
 
# Write an SQL query to report the number of bank accounts of each salary category. The salary categories are:

# 1. "Low Salary": All the salaries strictly less than $20000.
# 2. "Average Salary": All the salaries in the inclusive range [$20000, $50000].
# 3. "High Salary": All the salaries strictly greater than $50000.
# The result table must contain all three categories. If there are no accounts in a category, then report 0.
# Return the result table in any order.

# My Solution
SELECT "Low Salary" AS CATEGORY,
        COALESCE(COUNT(IF(INCOME<20000, ACCOUNT_ID,NULL))) AS ACCOUNTS_COUNT
FROM ACCOUNTS
UNION 
SELECT "Average Salary" AS CATEGORY,
         COALESCE(COUNT(IF(INCOME BETWEEN 20000 AND 50000, ACCOUNT_ID,NULL))) AS ACCOUNTS_COUNT
FROM ACCOUNTS
UNION
SELECT "High Salary" AS CATEGORY,
        COALESCE(COUNT(IF(INCOME>50000, ACCOUNT_ID,NULL))) AS ACCOUNTS_COUNT
FROM ACCOUNTS;

