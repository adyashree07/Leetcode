# https://leetcode.com/problems/friend-requests-i-overall-acceptance-rate/

# Table: FriendRequest
# +----------------+---------+
# | Column Name    | Type    |
# +----------------+---------+
# | sender_id      | int     |
# | send_to_id     | int     |
# | request_date   | date    |
# +----------------+---------+
# There is no primary key for this table, it may contain duplicates.
# This table contains the ID of the user who sent the request, the ID of the user who received the request, and the date of the request.
 
# Table: RequestAccepted
# +----------------+---------+
# | Column Name    | Type    |
# +----------------+---------+
# | requester_id   | int     |
# | accepter_id    | int     |
# | accept_date    | date    |
# +----------------+---------+
# There is no primary key for this table, it may contain duplicates.
# This table contains the ID of the user who sent the request, the ID of the user who received the request, and the date when the request was accepted.
 
# Write an SQL query to find the overall acceptance rate of requests, which is the number of acceptance divided by the number of requests. Return the answer rounded to 2 decimals places.
# Note that:
# 1. The accepted requests are not necessarily from the table friend_request. In this case, Count the total accepted requests (no matter whether they are in the original requests), and divide it by the number of requests to get the acceptance rate.
# 2. It is possible that a sender sends multiple requests to the same receiver, and a request could be accepted more than once. In this case, the ‘duplicated’ requests or acceptances are only counted once.
# 3. If there are no requests at all, you should return 0.00 as the accept_rate.

# My Solution
WITH T1 AS (
    SELECT COUNT(DISTINCT SENDER_ID,SEND_TO_ID) AS CNT1
    FROM FRIENDREQUEST),
T2 AS (
    SELECT COUNT(DISTINCT REQUESTER_ID,ACCEPTER_ID) AS CNT2 
    FROM REQUESTACCEPTED)
SELECT ROUND(COALESCE(CNT2/T1.CNT1,0),2) AS ACCEPT_RATE FROM T1,T2;


# Alternate Solution
select 
    round(
        IFNULL(
        (select count(*) from (select distinct requester_id, accepter_id from requestaccepted) as ra)
        /
        (select count(*) from (select distinct sender_id, send_to_id from friendrequest) as fr)
        , 0
        )
        ,2) as accept_rate;
  
  
