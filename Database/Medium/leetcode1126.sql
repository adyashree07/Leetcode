# https://leetcode.com/problems/active-businesses/

# able: Events
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | business_id   | int     |
# | event_type    | varchar |
# | occurences    | int     | 
# +---------------+---------+
# (business_id, event_type) is the primary key of this table.
# Each row in the table logs the info that an event of some type occurred at some business for a number of times.
 
# The average activity for a particular event_type is the average occurences across all companies that have this event.
# An active business is a business that has more than one event_type such that their occurences is strictly greater than the average activity for that event.

# Write an SQL query to find all active businesses.
# Return the result table in any order.

# My Solution
WITH T1 AS (
    SELECT EVENT_TYPE, 
           AVG(OCCURENCES) AS AVG_OCCURENCES 
    FROM EVENTS GROUP BY EVENT_TYPE)
SELECT T2.BUSINESS_ID FROM (
  SELECT E.*, T1.AVG_OCCURENCES FROM EVENTS E LEFT JOIN T1 
  ON E.EVENT_TYPE = T1.EVENT_TYPE 
  WHERE E.OCCURENCES>T1.AVG_OCCURENCES) T2
GROUP BY T2.BUSINESS_ID HAVING COUNT(T2.BUSINESS_ID)>1;


# Alternate Solution
SELECT business_id
  FROM Events e
        INNER JOIN (SELECT event_type, AVG(occurences) avg_occurences FROM Events GROUP BY 1) a
            USING (event_type)
 WHERE occurences > avg_occurences
 GROUP BY 1
HAVING COUNT(1) > 1;

