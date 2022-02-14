# https://leetcode.com/problems/first-and-last-call-on-the-same-day/

# Table: Calls
# +--------------+----------+
# | Column Name  | Type     |
# +--------------+----------+
# | caller_id    | int      |
# | recipient_id | int      |
# | call_time    | datetime |
# +--------------+----------+
# (caller_id, recipient_id, call_time) is the primary key for this table.
# Each row contains information about the time of a phone call between caller_id and recipient_id.
 
# Write an SQL query to report the IDs of the users whose first and last calls on any day were with the same person. Calls are counted regardless of being the caller or the recipient.
# Return the result table in any order.

# My Solution
WITH T1 AS(
    SELECT CALLER_ID, RECIPIENT_ID, CALL_TIME FROM CALLS
    UNION ALL
    SELECT RECIPIENT_ID, CALLER_ID, CALL_TIME FROM CALLS),
T2 AS (
    SELECT *, 
           ROW_NUMBER() OVER (PARTITION BY CALLER_ID, DATE(CALL_TIME) ORDER BY TIME(CALL_TIME)) AS RNK1,
           ROW_NUMBER() OVER (PARTITION BY CALLER_ID, DATE(CALL_TIME) ORDER BY TIME(CALL_TIME) DESC) AS RNK2   
FROM T1),
T3 AS (
    SELECT T2.CALLER_ID, T2.RECIPIENT_ID FROM T2 JOIN (
        SELECT CALLER_ID, RECIPIENT_ID FROM T2 WHERE RNK2=1) R2
    ON T2.CALLER_ID = R2.CALLER_ID AND T2.RECIPIENT_ID = R2.RECIPIENT_ID
     WHERE T2.RNK1=1)
    
SELECT DISTINCT CALLER_ID AS USER_ID FROM T3;
    
  
# Alternate Solution
with t as
(
    select caller_id,recipient_id,call_time from Calls
    union all
    select recipient_id,caller_id,call_time from Calls
)
,t2 as
(  
    select caller_id,recipient_id,date(call_time) day from
    (select *,rank() over(partition by caller_id,day(call_time) order by call_time asc) rnk from t)temp1
    where rnk =1
    union all
     select caller_id,recipient_id,date(call_time) day from
    (select *,rank() over(partition by caller_id,day(call_time) order by call_time desc) rnk from t)temp2
    where rnk =1
)

select distinct caller_id user_id
from t2
group by caller_id,day
having count(distinct recipient_id)=1;
