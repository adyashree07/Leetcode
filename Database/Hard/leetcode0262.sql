# https://leetcode.com/problems/trips-and-users/ 

# Table: Trips
# +-------------+----------+
# | Column Name | Type     |
# +-------------+----------+
# | id          | int      |
# | client_id   | int      |
# | driver_id   | int      |
# | city_id     | int      |
# | status      | enum     |
# | request_at  | date     |     
# +-------------+----------+
# id is the primary key for this table.
# The table holds all taxi trips. Each trip has a unique id, while client_id and driver_id are foreign keys to the users_id at the Users table.
# Status is an ENUM type of ('completed', 'cancelled_by_driver', 'cancelled_by_client').
 
# Table: Users
# +-------------+----------+
# | Column Name | Type     |
# +-------------+----------+
# | users_id    | int      |
# | banned      | enum     |
# | role        | enum     |
# +-------------+----------+
# users_id is the primary key for this table.
# The table holds all users. Each user has a unique users_id, and role is an ENUM type of ('client', 'driver', 'partner').
# banned is an ENUM type of ('Yes', 'No').
 
# The cancellation rate is computed by dividing the number of canceled (by client or driver) requests with unbanned users by the total number of requests with unbanned users on that day.
# Write a SQL query to find the cancellation rate of requests with unbanned users (both client and driver must not be banned) each day between "2013-10-01" and "2013-10-03". Round Cancellation Rate to two decimal points.
# Return the result table in any order.

# My Solution
SELECT T1.DAYS AS Day, COALESCE(ROUND(T2.CANCELLED_TRIPS/T1.TOTAL_TRIPS,2),0) AS "Cancellation Rate" 
FROM 
(SELECT T.REQUEST_AT AS DAYS, 
       COUNT(T.ID) AS TOTAL_TRIPS FROM TRIPS T 
INNER JOIN USERS U1 ON T.CLIENT_ID = U1.USERS_ID 
INNER JOIN USERS U2 ON T.DRIVER_ID = U2.USERS_ID 
WHERE U1.BANNED = "No" AND  U1.ROLE = "client" 
AND U2.BANNED = "No" AND U2.ROLE = "driver" 
AND T.REQUEST_AT BETWEEN "2013-10-01" AND "2013-10-03"
GROUP BY T.REQUEST_AT) AS T1 
LEFT JOIN
(SELECT T.REQUEST_AT AS DAYS, 
       COUNT(T.ID) AS CANCELLED_TRIPS FROM TRIPS T 
INNER JOIN USERS U1 ON T.CLIENT_ID = U1.USERS_ID 
INNER JOIN USERS U2 ON T.DRIVER_ID = U2.USERS_ID 
WHERE U1.BANNED = "No" AND  U1.ROLE = "client" 
AND U2.BANNED = "No" AND U2.ROLE = "driver" 
AND T.STATUS != "completed" 
AND T.REQUEST_AT BETWEEN "2013-10-01" AND "2013-10-03"
GROUP BY T.REQUEST_AT) AS T2 
ON T1.DAYS = T2.DAYS;


# My Solution-2
WITH T AS (
    SELECT * FROM TRIPS 
    WHERE CLIENT_ID NOT IN (SELECT USERS_ID FROM USERS WHERE BANNED="Yes" AND ROLE="client")
    AND DRIVER_ID NOT IN (SELECT USERS_ID FROM USERS WHERE BANNED="Yes" AND ROLE="driver"))

SELECT REQUEST_AT AS DAY,
       ROUND((COUNT(IF(STATUS LIKE "cancelled%",1,NULL)))/(COUNT(ID)),2) AS "CANCELLATION RATE"
FROM T
WHERE REQUEST_AT BETWEEN "2013-10-01" AND "2013-10-03"
GROUP BY REQUEST_AT;


# Optimal Solution
SELECT
    Trips.request_at AS Day,
    ROUND(AVG(Trips.status != 'completed'), 2) AS 'Cancellation Rate'
FROM Trips
LEFT JOIN Users AS Client ON Trips.client_id = Client.users_id
LEFT JOIN Users AS Driver ON Trips.driver_id = Driver.users_id
WHERE Client.banned = 'No' AND Driver.banned = 'No'
    AND (Trips.request_at BETWEEN "2013-10-01" and "2013-10-03")
GROUP BY Trips.request_at;

