# https://leetcode.com/problems/exchange-seats/

# Table: Seat
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | id          | int     |
# | name        | varchar |
# +-------------+---------+
# id is the primary key column for this table.
# Each row of this table indicates the name and the ID of a student.
# id is a continuous increment.
 
# Write an SQL query to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.
# Return the result table ordered by id in ascending order.

# My Solution
SELECT CASE WHEN ID%2=0 THEN ID-1 
WHEN ID%2!=0 AND ID!=(SELECT MAX(ID) FROM SEAT) THEN ID+1
ELSE ID
END AS ID,
STUDENT FROM SEAT 
ORDER BY ID;


# Alternate Solution
select row_number() over(order by id asc) id,student from
(select 
    case when id%2<>0 then id+1
    else id-1
    end as id,
    student
from 
Seat
order by id)t;

