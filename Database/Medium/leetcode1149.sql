# https://leetcode.com/problems/article-views-ii/

# Table: Views
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | article_id    | int     |
# | author_id     | int     |
# | viewer_id     | int     |
# | view_date     | date    |
# +---------------+---------+
# There is no primary key for this table, it may have duplicate rows.
# Each row of this table indicates that some viewer viewed an article (written by some author) on some date. 
# Note that equal author_id and viewer_id indicate the same person.
 
# Write an SQL query to find all the people who viewed more than one article on the same date.
# Return the result table sorted by id in ascending order.


# My Solution
SELECT DISTINCT VIEWER_ID AS ID
FROM VIEWS
GROUP BY VIEWER_ID, VIEW_DATE
HAVING COUNT(DISTINCT ARTICLE_ID)>1
ORDER BY ID;

