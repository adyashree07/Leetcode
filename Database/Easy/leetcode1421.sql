# https://leetcode.com/problems/npv-queries/

# Table: NPV
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | id            | int     |
# | year          | int     |
# | npv           | int     |
# +---------------+---------+
# (id, year) is the primary key of this table.
# The table has information about the id and the year of each inventory and the corresponding net present value.
 
# Table: Queries
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | id            | int     |
# | year          | int     |
# +---------------+---------+
# (id, year) is the primary key of this table.
# The table has information about the id and the year of each inventory query.
 
# Write an SQL query to find the npv of each query of the Queries table.
# Return the result table in any order.

# My Solution
SELECT Q.ID, 
       Q.YEAR, 
       COALESCE(N.NPV,0) AS NPV 
FROM QUERIES Q LEFT JOIN NPV N 
ON Q.ID = N.ID AND Q.YEAR = N.YEAR;

