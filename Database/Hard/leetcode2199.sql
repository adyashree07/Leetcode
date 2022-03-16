# https://leetcode.com/problems/finding-the-topic-of-each-post/

# Table: Keywords
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | topic_id    | int     |
# | word        | varchar |
# +-------------+---------+
# (topic_id, word) is the primary key for this table.
# Each row of this table contains the id of a topic and a word that is used to express this topic.
# There may be more than one word to express the same topic and one word may be used to express multiple topics.
 
# Table: Posts
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | post_id     | int     |
# | content     | varchar |
# +-------------+---------+
# post_id is the primary key for this table.
# Each row of this table contains the ID of a post and its content.
# Content will consist only of English letters and spaces.
 
# Leetcode has collected some posts from its social media website and is interested in finding the topics of each post. Each topic can be expressed by one or more keywords. If a keyword of a certain topic exists in the content of a post (case insensitive) then the post has this topic.
# Write an SQL query to find the topics of each post according to the following rules:
# 1. If the post does not have keywords from any topic, its topic should be "Ambiguous!".
# 2. If the post has at least one keyword of any topic, its topic should be a string of the IDs of its topics sorted in ascending order and separated by commas ','. The string should not contain duplicate IDs.
# Return the result table in any order.

# My Solution
SELECT  P.POST_ID, 
        COALESCE(GROUP_CONCAT(DISTINCT TOPIC_ID),"Ambiguous!") AS TOPIC
FROM POSTS P LEFT JOIN KEYWORDS K 
ON (LOCATE(CONCAT(K.WORD,' '),P.CONTENT)>0 AND LOCATE(CONCAT(' ',K.WORD),P.CONTENT)>0)
OR (P.CONTENT LIKE CONCAT("% ",K.WORD)) 
OR (P.CONTENT LIKE CONCAT(K.WORD," %"))
GROUP BY POST_ID;


# Alternate Solution
WITH A AS(
    SELECT post_id, 
           LOWER(content) AS content 
  FROM Posts
),
B AS(
    SELECT A.post_id, 
           concat(K.topic_id) AS topic_id 
  FROM A LEFT JOIN Keywords K 
  ON (LOCATE(K.word, A.content)>0 AND NOT (A.content REGEXP concat(K.word, '[a-z]|[a-z]',K.word))) 
)

SELECT B.post_id, 
       IFNULL(GROUP_CONCAT(DISTINCT B.topic_id SEPARATOR ','),"Ambiguous!") AS topic 
FROM B 
GROUP BY B.post_id;

