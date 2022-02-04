# https://leetcode.com/problems/the-category-of-each-member-in-the-store/

# Table: Members
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | member_id   | int     |
# | name        | varchar |
# +-------------+---------+
# member_id is the primary key column for this table.
# Each row of this table indicates the name and the ID of a member.
 
# Table: Visits
# +-------------+------+
# | Column Name | Type |
# +-------------+------+
# | visit_id    | int  |
# | member_id   | int  |
# | visit_date  | date |
# +-------------+------+
# visit_id is the primary key column for this table.
# member_id is a foreign key to member_id from the Members table.
# Each row of this table contains information about the date of a visit to the store and the member who visited it.
 
# Table: Purchases
# +----------------+------+
# | Column Name    | Type |
# +----------------+------+
# | visit_id       | int  |
# | charged_amount | int  |
# +----------------+------+
# visit_id is the primary key column for this table.
# visit_id is a foreign key to visit_id from the Visits table.
# Each row of this table contains information about the amount charged in a visit to the store.
 
# A store wants to categorize its members. There are three tiers:

# 1. "Diamond": if the conversion rate is greater than or equal to 80.
# 2. "Gold": if the conversion rate is greater than or equal to 50 and less than 80.
# 3. "Silver": if the conversion rate is less than 50.
# 4. "Bronze": if the member never visited the store.
# The conversion rate of a member is (100 * total number of purchases for the member) / total number of visits for the member.

# Write an SQL query to report the id, the name, and the category of each member.
# Return the result table in any order.

# My Solution
SELECT T.MEMBER_ID, 
       T.NAME,
       CASE WHEN T.TOTAL_PURCHASE/T.NO_OF_VISIT>=0.8 THEN "Diamond"
            WHEN T.TOTAL_PURCHASE/T.NO_OF_VISIT>=0.5 AND T.TOTAL_PURCHASE/T.NO_OF_VISIT<=0.8 THEN "Gold"
            WHEN T.TOTAL_PURCHASE/T.NO_OF_VISIT<=0.5 THEN "Silver"
            ELSE "Bronze"
        END AS "CATEGORY" FROM (
            SELECT M.MEMBER_ID, 
                   M.NAME, 
                   COALESCE(COUNT(V.VISIT_DATE),0)AS NO_OF_VISIT ,
                   COALESCE(COUNT(P.CHARGED_AMOUNT),0) AS TOTAL_PURCHASE
            FROM MEMBERS M LEFT JOIN VISITS V ON M.MEMBER_ID = V.MEMBER_ID
            LEFT JOIN PURCHASES P ON V.VISIT_ID = P.VISIT_ID GROUP BY M.MEMBER_ID) T;
        
        
