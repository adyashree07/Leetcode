# https://leetcode.com/problems/number-of-accounts-that-did-not-stream/

# Table: Subscriptions
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | account_id  | int  |
# | start_date  | date |
# | end_date    | date |
# +-------------+------+
# account_id is the primary key column for this table.
# Each row of this table indicates the start and end dates of an account's subscription.
# Note that always start_date < end_date.
 
# Table: Streams
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | session_id  | int  |
# | account_id  | int  |
# | stream_date | date |
# +-------------+------+
# session_id is the primary key column for this table.
# account_id is a foreign key from the Subscriptions table.
# Each row of this table contains information about the account and the date associated with a stream session.

# Write an SQL query to report the number of accounts that bought a subscription in 2021 but did not have any stream session.

# My Solution
WITH T1 AS (
    SELECT COUNT(ACCOUNT_ID) AS TOTAL_SUB 
    FROM SUBSCRIPTIONS 
    WHERE YEAR(END_DATE)=2021),
T2 AS (
    SELECT COUNT(ACCOUNT_ID) AS TOTAL_STREAM 
    FROM STREAMS 
    WHERE YEAR(STREAM_DATE)=2021)
SELECT (T1.TOTAL_SUB - T2.TOTAL_STREAM) AS ACCOUNTS_COUNT FROM T1,T2;

