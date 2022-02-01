# https://leetcode.com/problems/create-a-session-bar-chart/

# Table: Sessions

# +---------------------+---------+
# | Column Name         | Type    |
# +---------------------+---------+
# | session_id          | int     |
# | duration            | int     |
# +---------------------+---------+
# session_id is the primary key for this table.
# duration is the time in seconds that a user has visited the application.
 
# You want to know how long a user visits your application. You decided to create bins of "[0-5>", "[5-10>", "[10-15>", and "15 minutes or more" and count the number of sessions on it.
# Write an SQL query to report the (bin, total).
# Return the result table in any order.

# My Solution
SELECT "[0-5>" AS BIN, SUM(DURATION/60<5) AS TOTAL FROM SESSIONS
UNION
SELECT "[5-10>" AS BIN, SUM(DURATION/60>=5 AND DURATION/60<10) AS TOTAL FROM SESSIONS
UNION
SELECT "[10-15>" AS BIN, SUM(DURATION/60>=10 AND DURATION/60<15) AS TOTAL FROM SESSIONS
UNION
SELECT "15 or more" AS BIN, SUM(DURATION/60>=15) AS TOTAL FROM SESSIONS;


# Alternate Solution
(select '[0-5>' as bin,
         coalesce(count(*),0) as total
from Sessions
where duration between 0 and 300 )
union all
(select '[5-10>' as bin,
         coalesce(count(*),0) as total
from Sessions
where duration between 301 and 600 )
union all
(select '[10-15>' as bin,
         coalesce(count(*),0) as total
from Sessions
where duration between 601 and 900 )
union all
(select '15 or more' as bin,
         coalesce(count(*),0) as total
from Sessions
where duration >900 )

