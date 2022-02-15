# https://leetcode.com/problems/friendly-movies-streamed-last-month/

# Table: TVProgram
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | program_date  | date    |
# | content_id    | int     |
# | channel       | varchar |
# +---------------+---------+
# (program_date, content_id) is the primary key for this table.
# This table contains information of the programs on the TV.
# content_id is the id of the program in some channel on the TV.
 
# Table: Content
# +------------------+---------+
# | Column Name      | Type    |
# +------------------+---------+
# | content_id       | varchar |
# | title            | varchar |
# | Kids_content     | enum    |
# | content_type     | varchar |
# +------------------+---------+
# content_id is the primary key for this table.
# Kids_content is an enum that takes one of the values ('Y', 'N') where: 
# 'Y' means is content for kids otherwise 'N' is not content for kids.
# content_type is the category of the content as movies, series, etc.
 
# Write an SQL query to report the distinct titles of the kid-friendly movies streamed in June 2020.
# Return the result table in any order.

# My Solution
SELECT DISTINCT C.TITLE 
FROM CONTENT C JOIN TVPROGRAM T
ON C.CONTENT_ID = T.CONTENT_ID
WHERE C.KIDS_CONTENT = 'Y' AND DATE_FORMAT(T.PROGRAM_DATE,"%Y-%m")='2020-06'
AND C.CONTENT_TYPE="Movies";

