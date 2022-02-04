# https://leetcode.com/problems/highest-grade-for-each-student/

# Table: Enrollments
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | student_id    | int     |
# | course_id     | int     |
# | grade         | int     |
# +---------------+---------+
# (student_id, course_id) is the primary key of this table.
 
# Write a SQL query to find the highest grade with its corresponding course for each student. In case of a tie, you should find the course with the smallest course_id.
# Return the result table ordered by student_id in ascending order.

# My Solution
SELECT T.STUDENT_ID, T.COURSE_ID, T.GRADE FROM (
  SELECT STUDENT_ID, 
        COURSE_ID, 
        GRADE, 
        ROW_NUMBER() OVER (PARTITION BY STUDENT_ID ORDER BY GRADE DESC, COURSE_ID ASC) AS RNK 
  FROM ENROLLMENTS 
  ORDER BY STUDENT_ID) T
WHERE T.RNK=1;

