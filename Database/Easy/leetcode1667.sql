# https://leetcode.com/problems/fix-names-in-a-table/

# Table: Users
# +----------------+---------+
# | Column Name    | Type    |
# +----------------+---------+
# | user_id        | int     |
# | name           | varchar |
# +----------------+---------+
# user_id is the primary key for this table.
# This table contains the ID and the name of the user. The name consists of only lowercase and uppercase characters.
 
# Write an SQL query to fix the names so that only the first character is uppercase and the rest are lowercase.
# Return the result table ordered by user_id.

# My Solution
SELECT USER_ID, 
       CONCAT(UPPER(LEFT(NAME,1)), LOWER(SUBSTRING(NAME,2,100))) AS NAME 
FROM USERS
ORDER BY USER_ID;


# Alternate Solution
select user_id,concat(LEFT(UPPER(NAME),1),RIGHT(lower(NAME),char_length(NAME)-1)) name from
Users
order by user_id;

