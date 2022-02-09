# https://leetcode.com/problems/find-the-quiet-students-in-all-exams/

# Table: Student
# +---------------------+---------+
# | Column Name         | Type    |
# +---------------------+---------+
# | student_id          | int     |
# | student_name        | varchar |
# +---------------------+---------+
# student_id is the primary key for this table.
# student_name is the name of the student.
 
# Table: Exam
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | exam_id       | int     |
# | student_id    | int     |
# | score         | int     |
# +---------------+---------+
# (exam_id, student_id) is the primary key for this table.
# Each row of this table indicates that the student with student_id had a score points in the exam with id exam_id.
 
# A quiet student is the one who took at least one exam and did not score the high or the low score.
# Write an SQL query to report the students (student_id, student_name) being quiet in all exams. Do not return the student who has never taken any exam.
# Return the result table ordered by student_id.

# My Solution
WITH T1 AS (
    SELECT E.STUDENT_ID, 
           S.STUDENT_NAME, 
           E.EXAM_ID, 
           E.SCORE FROM EXAM E JOIN STUDENT S 
ON E.STUDENT_ID = S.STUDENT_ID),
T2 AS (
    SELECT EXAM_ID,
           MAX(SCORE) AS MAX_SCORE,
           MIN(SCORE) AS MIN_SCORE
    FROM EXAM
    GROUP BY EXAM_ID)
SELECT DISTINCT E.STUDENT_ID, 
                S.STUDENT_NAME 
FROM EXAM E JOIN STUDENT S 
ON E.STUDENT_ID = S.STUDENT_ID
WHERE E.STUDENT_ID NOT IN (
  SELECT DISTINCT T1.STUDENT_ID 
  FROM T1 JOIN T2 
  ON T1.EXAM_ID = T2.EXAM_ID
  WHERE SCORE=MIN_SCORE OR SCORE=MAX_SCORE)
ORDER BY E.STUDENT_ID;


# Alternate Solution
with t as
(
    select  exam_id ,max(score) as max_s,min(score) min_s
    from Exam
    group by exam_id
)
,t2 as
(
    select student_id
    from Exam
    right join t
    on t.exam_id=Exam.exam_id and max_s=score
    union
    select student_id
    from Exam
    right join t
    on t.exam_id=Exam.exam_id and min_s=score
)

select distinct Exam.student_id ,Student.student_name
from Exam
join Student
on Student.student_id=Exam.student_id
where Exam.student_id not in (select distinct * from t2)
order by Exam.student_id;



