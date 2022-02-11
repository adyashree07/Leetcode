# https://leetcode.com/problems/build-the-equation/

# Table: Terms
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | power       | int  |
# | factor      | int  |
# +-------------+------+
# power is the primary key column for this table.
# Each row of this table contains information about one term of the equation.
# power is an integer in the range [0, 100].
# factor is an integer in the range [-100, 100] and cannot be zero.
 
# You have a very powerful program that can solve any equation of one variable in the world. The equation passed to the program must be formatted as follows:
# 1. The left-hand side (LHS) should contain all the terms.
# 2. The right-hand side (RHS) should be zero.
# 3. Each term of the LHS should follow the format "<sign><fact>X^<pow>" where:
#    i. <sign> is either "+" or "-".
#    ii. <fact> is the absolute value of the factor.
#    iii. <pow> is the value of the power.
# 4. If the power is 1, do not add "^<pow>".
#    i. For example, if power = 1 and factor = 3, the term will be "+3X".
# 5. If the power is 0, add neither "X" nor "^<pow>".
#    i. For example, if power = 0 and factor = -3, the term will be "-3".
# 6. The powers in the LHS should be sorted in descending order.
# Write an SQL query to build the equation.

# My Solution
SELECT REPLACE(CONCAT(TERM,"=0"),",","") AS EQUATION FROM (
    SELECT GROUP_CONCAT(CONCAT(SIGN,POLY) ORDER BY POWER DESC) AS TERM FROM (
        SELECT CASE WHEN FACTOR>0 THEN CONCAT("+",FACTOR)
                    ELSE FACTOR
               END AS SIGN,
               CASE WHEN POWER=1 THEN "X" 
                    WHEN POWER>0 THEN CONCAT("X^",POWER) 
                    ELSE ""
               END AS POLY,
               POWER
        FROM TERMS
        ORDER BY POWER DESC) T) T1;


# Alternate Solution
WITH cte AS (
    SELECT
        power
        , CASE WHEN factor > 0 THEN CONCAT("+", factor) ELSE factor END AS t1
        , CASE
            WHEN power = 0 THEN ''
            WHEN power = 1 THEN 'X'
            ELSE CONCAT("X^", power)
          END AS t2
    FROM terms
)
SELECT
    CONCAT(GROUP_CONCAT(t1, t2 ORDER BY power DESC SEPARATOR ""), "=0") AS equation
FROM cte;

