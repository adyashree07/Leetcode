# https://leetcode.com/problems/confirmation-rate/

# Table: Signups
# +----------------+----------+
# | Column Name    | Type     |
# +----------------+----------+
# | user_id        | int      |
# | time_stamp     | datetime |
# +----------------+----------+
# user_id is the primary key for this table.
# Each row contains information about the signup time for the user with ID user_id.
 
# Table: Confirmations
# +----------------+----------+
# | Column Name    | Type     |
# +----------------+----------+
# | user_id        | int      |
# | time_stamp     | datetime |
# | action         | ENUM     |
# +----------------+----------+
# (user_id, time_stamp) is the primary key for this table.
# user_id is a foreign key with a reference to the Signups table.
# action is an ENUM of the type ('confirmed', 'timeout')
# Each row of this table indicates that the user with ID user_id requested a confirmation message at time_stamp and that confirmation message was either confirmed ('confirmed') or expired without confirming ('timeout').

# The confirmation rate of a user is the number of 'confirmed' messages divided by the total number of requested confirmation messages. The confirmation rate of a user that did not request any confirmation messages is 0. Round the confirmation rate to two decimal places.
# Write an SQL query to find the confirmation rate of each user.
# Return the result table in any order.

# My Solution
SELECT S.USER_ID, 
       ROUND(AVG(COALESCE(C.ACTION,"timeout")="confirmed"),2) AS CONFIRMATION_RATE 
FROM SIGNUPS S LEFT JOIN CONFIRMATIONS C ON S.USER_ID=C.USER_ID 
GROUP BY S.USER_ID;


# Alternate Solution
select user_id ,0.00 as confirmation_rate from Signups where user_id not in (select distinct  user_id from  Confirmations)
union all
select a.user_id,round(coalesce(cnt/tbl_cnt,0),2) confirmation_rate
from
(select user_id,count(*) tbl_cnt from Confirmations group by user_id)a
left join
(select user_id,count(*) cnt from Confirmations where action='confirmed' group by user_id)b
on a.user_id=b.user_id;

