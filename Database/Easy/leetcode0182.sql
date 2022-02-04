# https://leetcode.com/problems/duplicate-emails/

# Table: Person
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | id          | int     |
# | email       | varchar |
# +-------------+---------+
# id is the primary key column for this table.
# Each row of this table contains an email. The emails will not contain uppercase letters.
 
# Write an SQL query to report all the duplicate emails.
# Return the result table in any order.

# My Solution
SELECT DISTINCT EMAIL FROM (
    SELECT EMAIL, ROW_NUMBER() OVER (PARTITION BY EMAIL) AS RNK FROM PERSON) T
WHERE T.RNK>1;

