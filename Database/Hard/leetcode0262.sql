# https://leetcode.com/problems/trips-and-users/ 

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
