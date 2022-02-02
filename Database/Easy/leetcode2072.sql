# https://leetcode.com/problems/the-winner-university/

# Table: NewYork
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | student_id  | int  |
# | score       | int  |
# +-------------+------+
# student_id is the primary key for this table.
# Each row contains information about the score of one student from New York University in an exam.
 
# Table: California
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | student_id  | int  |
# | score       | int  |
# +-------------+------+
# student_id is the primary key for this table.
# Each row contains information about the score of one student from California University in an exam.
 
# There is a competition between New York University and California University. The competition is held between the same number of students from both universities. The university that has more excellent students wins the competition. If the two universities have the same number of excellent students, the competition ends in a draw.
# An excellent student is a student that scored 90% or more in the exam.
# Write an SQL query to report:
# 1. "New York University" if New York University wins the competition.
# 2. "California University" if California University wins the competition.
# 3. "No Winner" if the competition ends in a draw.

# My Solution
WITH T1 AS (
    SELECT COUNT(STUDENT_ID) AS NY FROM NEWYORK WHERE SCORE>=90
    ),
T2 AS (
    SELECT COUNT(STUDENT_ID) AS CAL FROM CALIFORNIA WHERE SCORE >=90)
SELECT CASE WHEN T1.NY>T2.CAL THEN "New York University"
            WHEN T2.CAL>T1.NY THEN "California University"
            ELSE "No Winner"
       END AS WINNER FROM T1, T2;
      
      
