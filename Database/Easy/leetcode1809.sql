# https://leetcode.com/problems/ad-free-sessions/

# Table: Playback
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | session_id  | int  |
# | customer_id | int  |
# | start_time  | int  |
# | end_time    | int  |
# +-------------+------+
# session_id is the primary key for this table.
# customer_id is the ID of the customer watching this session.
# The session runs during the inclusive interval between start_time and end_time.
# It is guaranteed that start_time <= end_time and that two sessions for the same customer do not intersect.
 
# Table: Ads
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | ad_id       | int  |
# | customer_id | int  |
# | timestamp   | int  |
# +-------------+------+
# ad_id is the primary key for this table.
# customer_id is the ID of the customer viewing this ad.
# timestamp is the moment of time at which the ad was shown.
 
# Write an SQL query to report all the sessions that did not get shown any ads.
# Return the result table in any order.

# My Solution
SELECT SESSION_ID FROM PLAYBACK WHERE SESSION_ID 
NOT IN (
    SELECT DISTINCT P.SESSION_ID 
    FROM PLAYBACK P JOIN ADS A
    ON P.CUSTOMER_ID = A.CUSTOMER_ID AND A.TIMESTAMP BETWEEN P.START_TIME AND P.END_TIME);

