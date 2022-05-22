# https://leetcode.com/problems/article-views-i/

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
 
# Write an SQL query to find all the authors that viewed at least one of their own articles.
# Return the result table sorted by id in ascending order.

# My Solution
SELECT DISTINCT AUTHOR_ID AS ID
FROM VIEWS 
WHERE AUTHOR_ID = VIEWER_ID
ORDER BY 1;


# Alternate Solution
SELECT DISTINCT author_id AS id
FROM Views 
GROUP BY author_id, viewer_id
HAVING author_id=viewer_id ;

