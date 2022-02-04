# https://leetcode.com/problems/last-person-to-fit-in-the-bus/

# Table: Queue
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | person_id   | int     |
# | person_name | varchar |
# | weight      | int     |
# | turn        | int     |
# +-------------+---------+
# person_id is the primary key column for this table.
# This table has the information about all people waiting for a bus.
# The person_id and turn columns will contain all numbers from 1 to n, where n is the number of rows in the table.
# turn determines the order of which the people will board the bus, where turn=1 denotes the first person to board and turn=n denotes the last person to board.
# weight is the weight of the person in kilograms.
 
# There is a queue of people waiting to board a bus. However, the bus has a weight limit of 1000 kilograms, so there may be some people who cannot board.

# Write an SQL query to find the person_name of the last person that can fit on the bus without exceeding the weight limit. 
# The test cases are generated such that the first person does not exceed the weight limit.

# My Solution
SELECT T.PERSON_NAME FROM(
    SELECT P1.PERSON_ID, 
        P1.PERSON_NAME, 
        SUM(P2.WEIGHT) AS CUMM_WEIGHT 
    FROM QUEUE P1 JOIN QUEUE P2 
    ON P1.TURN>=P2.TURN
    GROUP BY P1.TURN, P1.WEIGHT 
    ORDER BY P1.TURN) T
WHERE CUMM_WEIGHT<=1000 
ORDER BY CUMM_WEIGHT DESC LIMIT 1;


# Alternate Solution
select person_name
from (
    select person_name 
        ,sum(weight) over(order by turn) max_w 
        ,turn
    from Queue
    )t
where max_w<1001
order by max_w desc
limit 1;
