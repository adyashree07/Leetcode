# https://leetcode.com/problems/number-of-comments-per-post/

# Table: Submissions
# +---------------+----------+
# | Column Name   | Type     |
# +---------------+----------+
# | sub_id        | int      |
# | parent_id     | int      |
# +---------------+----------+
# There is no primary key for this table, it may have duplicate rows.
# Each row can be a post or comment on the post.
# parent_id is null for posts.
# parent_id for comments is sub_id for another post in the table.
 
# Write an SQL query to find the number of comments per post. The result table should contain post_id and its corresponding number_of_comments.
# The Submissions table may contain duplicate comments. You should count the number of unique comments per post.
# The Submissions table may contain duplicate posts. You should treat them as one post.
# The result table should be ordered by post_id in ascending order.

# My Solution
WITH CTE AS (
    SELECT DISTINCT SUB_ID FROM SUBMISSIONS WHERE PARENT_ID IS NULL)
    
SELECT T.SUB_ID AS POST_ID, 
       COUNT(DISTINCT S.SUB_ID) AS NUMBER_OF_COMMENTS 
FROM CTE T LEFT JOIN SUBMISSIONS S
ON T.SUB_ID = S.PARENT_ID GROUP BY T.SUB_ID
ORDER BY POST_ID;


# Alternate Solution
with t as(
    select sub_id from Submissions
    where  parent_id is Null
    ),
temp as(
select parent_id as post_id ,count(distinct sub_id)number_of_comments
from Submissions
where parent_id in (select sub_id from t)
group by parent_id 
    )
    
select * from(
    select * from temp
    union
    select sub_id as post_id,
        0 number_of_comments
    from t
    where sub_id not in (select post_id from temp)
    )t1
order by post_id;
