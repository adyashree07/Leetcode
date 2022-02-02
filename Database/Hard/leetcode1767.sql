# https://leetcode.com/problems/find-the-subtasks-that-did-not-execute/

# Table: Tasks
# +----------------+---------+
# | Column Name    | Type    |
# +----------------+---------+
# | task_id        | int     |
# | subtasks_count | int     |
# +----------------+---------+
# task_id is the primary key for this table.
# Each row in this table indicates that task_id was divided into subtasks_count subtasks labeled from 1 to subtasks_count.
# It is guaranteed that 2 <= subtasks_count <= 20.
 
# Table: Executed
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | task_id       | int     |
# | subtask_id    | int     |
# +---------------+---------+
# (task_id, subtask_id) is the primary key for this table.
# Each row in this table indicates that for the task task_id, the subtask with ID subtask_id was executed successfully.
# It is guaranteed that subtask_id <= subtasks_count for each task_id.
 
# Write an SQL query to report the IDs of the missing subtasks for each task_id.
# Return the result table in any order.

# My Solution
WITH RECURSIVE R AS (
    SELECT 1 AS ID
    UNION 
    SELECT ID+1 FROM R WHERE ID <=19
    )
SELECT T.TASK_ID, R.ID AS SUBTASK_ID
FROM TASKS T JOIN R 
WHERE R.ID <= T.SUBTASKS_COUNT AND 
R.ID NOT IN (SELECT E.SUBTASK_ID FROM EXECUTED E WHERE E.TASK_ID = T.TASK_ID);


# Alternate Solution
with recursive t_cache as (
    select 1 as id
    union all 
    select id + 1  from t_cache
    where id+1 <= 20
)

select
a.task_id,b.id as subtask_id
from Tasks a
left join t_cache b on a.subtasks_count >= b.id
left join Executed c on c.task_id = a.task_id and c.subtask_id = b.id
where c.subtask_id is null;

