# https://leetcode.com/problems/find-users-with-valid-e-mails/

# Table: Users
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | user_id       | int     |
# | name          | varchar |
# | mail          | varchar |
# +---------------+---------+
# user_id is the primary key for this table.
# This table contains information of the users signed up in a website. Some e-mails are invalid.
 
# Write an SQL query to find the users who have valid emails.
# A valid e-mail has a prefix name and a domain where:
# 1. The prefix name is a string that may contain letters (upper or lower case), digits, underscore '_', period '.', and/or dash '-'. The prefix name must start with a letter.
# 2. The domain is '@leetcode.com'.
# Return the result table in any order.

# My Solution
SELECT * FROM USERS 
WHERE MAIL REGEXP "^[A-Za-z]+[A-Za-z0-9\_\.\-]*@leetcode[.]com";


# Alternate Solution
select distinct * from Users
where mail regexp '^[A-Za-z][a-zA-Z0-9_.-]*@leetcode[.]com$';

