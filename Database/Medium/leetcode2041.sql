# https://leetcode.com/problems/accepted-candidates-from-the-interviews/

# Table: Candidates
# +--------------+----------+
# | Column Name  | Type     |
# +--------------+----------+
# | candidate_id | int      |
# | name         | varchar  |
# | years_of_exp | int      |
# | interview_id | int      |
# +--------------+----------+
# candidate_id is the primary key column for this table.
# Each row of this table indicates the name of a candidate, their number of years of experience, and their interview ID.
 
# Table: Rounds
# +--------------+------+
# | Column Name  | Type |
# +--------------+------+
# | interview_id | int  |
# | round_id     | int  |
# | score        | int  |
# +--------------+------+
# (interview_id, round_id) is the primary key column for this table.
# Each row of this table indicates the score of one round of an interview.
 
# Write an SQL query to report the IDs of the candidates who have at least two years of experience and the sum of the score of their interview rounds is strictly greater than 15.
# Return the result table in any order.

# My Solution
SELECT C.CANDIDATE_ID
FROM CANDIDATES C JOIN ROUNDS R
ON C.INTERVIEW_ID = R.INTERVIEW_ID
WHERE C.YEARS_OF_EXP>=2
GROUP BY C.INTERVIEW_ID
HAVING SUM(R.SCORE)>15;


# Alternate Solution
select candidate_id
from Candidates a, Rounds b
where a.years_of_exp > 1 and a.interview_id = b.interview_id
group by a.candidate_id
having sum(score) > 15;

