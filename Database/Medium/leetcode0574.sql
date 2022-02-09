# https://leetcode.com/problems/winning-candidate/

# Table: Candidate
# +-------------+----------+
# | Column Name | Type     |
# +-------------+----------+
# | id          | int      |
# | name        | varchar  |
# +-------------+----------+
# id is the primary key column for this table.
# Each row of this table contains information about the id and the name of a candidate.
 
# Table: Vote
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | id          | int  |
# | candidateId | int  |
# +-------------+------+
# id is an auto-increment primary key.
# candidateId is a foreign key to id from the Candidate table.
# Each row of this table determines the candidate who got the ith vote in the elections.
 
# Write an SQL query to report the name of the winning candidate (i.e., the candidate who got the largest number of votes).
# The test cases are generated so that exactly one candidate wins the elections.

# My Solution
SELECT NAME FROM (
    SELECT V.CANDIDATEID, 
           C.NAME, 
           COALESCE(COUNT(V.ID),0) AS VOTE_cOUNT
    FROM CANDIDATE C JOIN VOTE V 
    ON C.ID= V.CANDIDATEID
    GROUP BY V.CANDIDATEID
    ORDER BY VOTE_COUNT DESC) T
LIMIT 1;


# Alternate Solution
select name
from Candidate t1
join (
select candidateId
from Vote
group by candidateId
order by count(id) desc
limit 1
) t2 on t1.id = t2.candidateId;

