# https://leetcode.com/problems/delete-duplicate-emails/submissions/

# Table: Person
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | id          | int     |
# | email       | varchar |
# +-------------+---------+
# id is the primary key column for this table.
# Each row of this table contains an email. The emails will not contain uppercase letters.
 
# Write an SQL query to delete all the duplicate emails, keeping only one unique email with the smallest id. Note that you are supposed to write a DELETE statement and not a SELECT one.
# Return the result table in any order.

# My Solution
WITH T AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY EMAIL ORDER BY ID) AS RNK
    FROM PERSON)
DELETE FROM PERSON WHERE ID IN (SELECT ID FROM T WHERE RNK>1);


# Alternate Solution
delete from Person
where id not in (
          select
            p.id from
             (
                  select 
                  min(id) as 'id'
                  from Person
                  group by email
               ) as p
            ) ;
            
            
# Alternate Solution-2
DELETE P1 FROM PERSON P1, PERSON P2
WHERE P1.EMAIL = P2.EMAIL AND P1.ID>P2.ID;



