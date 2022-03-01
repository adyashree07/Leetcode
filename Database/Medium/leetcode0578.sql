# https://leetcode.com/problems/get-highest-answer-rate-question/

# Table: SurveyLog
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | id          | int  |
# | action      | ENUM |
# | question_id | int  |
# | answer_id   | int  |
# | q_num       | int  |
# | timestamp   | int  |
# +-------------+------+
# There is no primary key for this table. It may contain duplicates.
# action is an ENUM of the type: "show", "answer", or "skip".
# Each row of this table indicates the user with ID = id has taken an action with the question question_id at time timestamp.
# If the action taken by the user is "answer", answer_id will contain the id of that answer, otherwise, it will be null.
# q_num is the numeral order of the question in the current session.
 
# The answer rate for a question is the number of times a user answered the question by the number of times a user showed the question.
# Write an SQL query to report the question that has the highest answer rate. 
# If multiple questions have the same maximum answer rate, report the question with the smallest question_id.

# My Solution
SELECT QUESTION_ID AS SURVEY_LOG FROM (
    SELECT QUESTION_ID, 
           COALESCE(COUNT(IF(ACTION="answer",1,NULL)),0)/ COALESCE(COUNT(IF(ACTION="show",1,NULL)),0) AS ANSWER_RATE
    FROM SURVEYLOG
    GROUP BY QUESTION_ID
    ORDER BY ANSWER_RATE DESC, QUESTION_ID) T
WHERE QUESTION_ID IS NOT NULL
LIMIT 0,1;


# Alternate Solution
Select question_id as survey_log
From SurveyLog
where answer_id is not null
group by question_id
order by count(1) desc
limit 1;

