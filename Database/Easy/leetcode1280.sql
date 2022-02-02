# https://leetcode.com/problems/students-and-examinations/

# Table: Students
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | student_id    | int     |
# | student_name  | varchar |
# +---------------+---------+
# student_id is the primary key for this table.
# Each row of this table contains the ID and the name of one student in the school.
 
# Table: Subjects
# +--------------+---------+
# | Column Name  | Type    |
# +--------------+---------+
# | subject_name | varchar |
# +--------------+---------+
# subject_name is the primary key for this table.
# Each row of this table contains the name of one subject in the school.
 
# Table: Examinations
# +--------------+---------+
# | Column Name  | Type    |
# +--------------+---------+
# | student_id   | int     |
# | subject_name | varchar |
# +--------------+---------+
# There is no primary key for this table. It may contain duplicates.
# Each student from the Students table takes every course from the Subjects table.
# Each row of this table indicates that a student with ID student_id attended the exam of subject_name.
 
# Write an SQL query to find the number of times each student attended each exam.
# Return the result table ordered by student_id and subject_name.

# My Solution
# Write your MySQL query statement below
SELECT S.*, 
       SU.SUBJECT_NAME, 
       COUNT(E.SUBJECT_NAME) AS ATTENDED_EXAMS
FROM STUDENTS S JOIN SUBJECTS SU 
LEFT JOIN EXAMINATIONS E 
ON S.STUDENT_ID = E.STUDENT_ID AND SU.SUBJECT_NAME= E.SUBJECT_NAME 
GROUP BY S.STUDENT_ID, SU.SUBJECT_NAME 
ORDER BY S.STUDENT_ID, SU.SUBJECT_NAME;


# Alternate Solution
SELECT s1.student_id, s1.student_name, s2.subject_name,
       IFNULL(e.attended_exams,0) AS attended_exams
  FROM Students s1
 CROSS JOIN Subjects s2
  LEFT JOIN (
      SELECT student_id, subject_name,
             COUNT(*) AS attended_exams
        FROM Examinations e
       GROUP BY 1,2
  ) e
    ON s1.student_id = e.student_id 
   AND s2.subject_name = e.subject_name
 ORDER BY 1, 3;
