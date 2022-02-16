# https://leetcode.com/problems/monthly-transactions-ii/

# Table: Transactions
# +----------------+---------+
# | Column Name    | Type    |
# +----------------+---------+
# | id             | int     |
# | country        | varchar |
# | state          | enum    |
# | amount         | int     |
# | trans_date     | date    |
# +----------------+---------+
# id is the primary key of this table.
# The table has information about incoming transactions.
# The state column is an enum of type ["approved", "declined"].

# Table: Chargebacks
# +----------------+---------+
# | Column Name    | Type    |
# +----------------+---------+
# | trans_id       | int     |
# | trans_date     | date    |
# +----------------+---------+
# Chargebacks contains basic information regarding incoming chargebacks from some transactions placed in Transactions table.
# trans_id is a foreign key to the id column of Transactions table.
# Each chargeback corresponds to a transaction made previously even if they were not approved.
 
# Write an SQL query to find for each month and country: the number of approved transactions and their total amount, the number of chargebacks, and their total amount.
# Note: In your query, given the month and country, ignore rows with all zeros.
# Return the result table in any order.

# My Solution
WITH T AS (
    SELECT ID, 
           COUNTRY, 
           STATE, 
           AMOUNT, 
           DATE_FORMAT(TRANS_DATE,"%Y-%m") AS TRANS_DATE
    FROM TRANSACTIONS
    WHERE STATE="approved"
    UNION
    SELECT C.TRANS_ID,
           T.COUNTRY, 
           "chargeback" AS STATE, 
           COALESCE(T.AMOUNT,0), 
           DATE_FORMAT(C.TRANS_DATE,"%Y-%m") AS TRANS_DATE
    FROM CHARGEBACKS C LEFT JOIN TRANSACTIONS T
    ON C.TRANS_ID = T.ID)

SELECT TRANS_DATE AS MONTH,
       COUNTRY,
       COUNT(IF(STATE="approved",ID,NULL)) AS APPROVED_COUNT,
       SUM(IF(STATE="approved",AMOUNT,0)) AS APPROVED_AMOUNT,
       COUNT(IF(STATE="chargeback",ID,NULL)) AS CHARGEBACK_COUNT,
       SUM(IF(STATE="chargeback",AMOUNT,0)) AS CHARGEBACK_AMOUNT
FROM T
GROUP BY COUNTRY, MONTH; 


# Alternate Solution
with t as
(
    select date_format(trans_date,'%Y-%m') month
        ,country
        ,count(if(state='approved',1,Null)) approved_count    
        ,sum(if(state='approved',amount,0)) approved_amount
    from Transactions
    group by month,country
)
,t1 as
(
    select date_format(c.trans_date,'%Y-%m') month
        ,t.country
        ,coalesce(count(t.id),0) chargeback_count
        ,coalesce(sum(t.amount),0) chargeback_amount
    from Chargebacks c
    left join Transactions t
    on c.trans_id=t.id
    group by month,country
)

select month
    ,country
    ,approved_count
    ,approved_amount 
    ,chargeback_count
    ,chargeback_amount
from
(
    select t1.month,t1.country 
        ,coalesce(approved_count,0) approved_count
        ,coalesce(approved_amount,0) approved_amount
        ,chargeback_count
        ,chargeback_amount
    from t1
    left join t
    on t.month=t1.month and t1.country=t.country


    union

    select t.month,t.country 
        ,coalesce(approved_count,0) approved_count
        ,coalesce(approved_amount,0) approved_amount
        ,coalesce(chargeback_count,0) chargeback_count
        ,coalesce(chargeback_amount,0) chargeback_amount
    from t1
    right join t
    on t.month=t1.month and t1.country=t.country
)temp
where approved_count+approved_amount +chargeback_count+chargeback_amount<>0;

