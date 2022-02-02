# https://leetcode.com/problems/evaluate-boolean-expression/

# Table Variables:
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | name          | varchar |
# | value         | int     |
# +---------------+---------+
# name is the primary key for this table.
# This table contains the stored variables and their values.
 
# Table Expressions:
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | left_operand  | varchar |
# | operator      | enum    |
# | right_operand | varchar |
# +---------------+---------+
# (left_operand, operator, right_operand) is the primary key for this table.
# This table contains a boolean expression that should be evaluated.
# operator is an enum that takes one of the values ('<', '>', '=')
# The values of left_operand and right_operand are guaranteed to be in the Variables table.
 
# Write an SQL query to evaluate the boolean expressions in Expressions table.
# Return the result table in any order.

# My Solution
SELECT T.LEFT_OPERAND,
       T.OPERATOR,
       T.RIGHT_OPERAND,
       CASE WHEN T.VALUE = 0 THEN "false"
            ELSE "true"
       END AS value
FROM (SELECT E.*, 
CASE WHEN E.OPERATOR ="<" THEN V1.VALUE<V2.VALUE
     WHEN E.OPERATOR =">" THEN V1.VALUE>V2.VALUE
     ELSE V1.VALUE=V2.VALUE
END AS VALUE
FROM EXPRESSIONS E JOIN VARIABLES V1 ON E.LEFT_OPERAND = V1.NAME JOIN VARIABLES V2 ON E.RIGHT_OPERAND = V2.NAME) T;

