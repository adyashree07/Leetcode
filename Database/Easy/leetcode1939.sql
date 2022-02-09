# https://leetcode.com/problems/users-that-actively-request-confirmation-messages/

# able: Signups
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
 
# Write an SQL query to find the IDs of the users that requested a confirmation message twice within a 24-hour window. Two messages exactly 24 hours apart are considered to be within the window. The action does not affect the answer, only the request time.
# Return the result table in any order.

# My Solution
SELECT DISTINCT C1.USER_ID 
FROM CONFIRMATIONS C1 JOIN CONFIRMATIONS C2 
ON C1.USER_ID = C2.USER_ID AND C1.TIME_STAMP!=C2.TIME_STAMP 
WHERE TIMESTAMPDIFF(SECOND,C1.TIME_STAMP,C2.TIME_STAMP)<=86400 AND TIMESTAMPDIFF(SECOND,C1.TIME_STAMP,C2.TIME_STAMP)>=-86400;


# Alternate Solution
select distinct t1.user_id
from Confirmations t1
left join Confirmations t2
on t1.user_id=t2.user_id and t1.time_stamp<>t2.time_stamp and t1.time_stamp<t2.time_stamp
where TIMESTAMPDIFF(SECOND,t1.time_stamp,t2.time_stamp)<=86400;

