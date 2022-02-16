# https://leetcode.com/problems/suspicious-bank-accounts/

# Table: Accounts
# +----------------+------+
# | Column Name    | Type |
# +----------------+------+
# | account_id     | int  |
# | max_income     | int  |
# +----------------+------+
# account_id is the primary key for this table.
# Each row contains information about the maximum monthly income for one bank account.
 
# Table: Transactions
# +----------------+----------+
# | Column Name    | Type     |
# +----------------+----------+
# | transaction_id | int      |
# | account_id     | int      |
# | type           | ENUM     |
# | amount         | int      |
# | day            | datetime |
# +----------------+----------+
# transaction_id is the primary key for this table.
# Each row contains information about one transaction.
# type is ENUM ('Creditor','Debtor') where 'Creditor' means the user deposited money into their account and 'Debtor' means the user withdrew money from their account.
# amount is the amount of money deposited/withdrawn during the transaction.
 
# A bank account is suspicious if the total income exceeds the max_income for this account for two or more consecutive months. The total income of an account in some month is the sum of all its deposits in that month (i.e., transactions of the type 'Creditor').
# Write an SQL query to report the IDs of all suspicious bank accounts.
# Return the result table ordered by transaction_id in ascending order.

# My Solution
WITH T AS (
    SELECT T.ACCOUNT_ID, 
           DATE_FORMAT(T.DAY,"%Y%m") AS DATE,
           SUM(T.AMOUNT) AS AMOUNT,
           A.MAX_INCOME
    FROM TRANSACTIONS T LEFT JOIN ACCOUNTS A 
    ON T.ACCOUNT_ID = A.ACCOUNT_ID
    WHERE TYPE="Creditor"
    GROUP BY ACCOUNT_ID, DATE_FORMAT(DAY,"%Y%m")
    HAVING SUM(T.AMOUNT)>A.MAX_INCOME)

SELECT T1.ACCOUNT_ID 
FROM T T1, T T2
WHERE T1.ACCOUNT_ID = T2.ACCOUNT_ID AND PERIOD_DIFF(T1.DATE,T2.DATE)=1
GROUP BY T1.ACCOUNT_ID
ORDER BY T1.ACCOUNT_ID;


# Alternate Solution
with recursive month as
( select (select min(day) from transactions ) mon
 union all
 select DATE_ADD(mon,interval 1 month) from month where mon<(select max(day) from transactions)
)
,t as
(   
    select account_id ,type,sum(amount) amount,date_format(day,'%Y-%m') day
    from Transactions
    group by account_id ,type,date_format(day,'%Y-%m')
)
,cte as
( select mon,account_id 
 from month
 join (select distinct account_id from t)temp
)
,t1 as
(
    select cte.account_id
        ,amount
        ,date_format(cte.mon,'%Y-%m') day
        ,row_number() over(partition by account_id order by date_format(cte.mon,'%Y-%m')) rn1
    from cte
    left join
        (
            select account_id
                ,amount
                ,day
                from t
            where type='Creditor'
        )tem
    on tem.account_id=cte.account_id and tem.day=date_format(cte.mon,'%Y-%m')
)
,t2 as
(
    select tran.account_id
        ,day
        ,row_number() over(partition by account_id order by day) rn2
        # ,case when tran.amount>ac.max_income then 'Yes'
        # else 'No'
        # end as suspicious
    from t tran
    left join Accounts ac
    on tran.account_id=ac.account_id
    where tran.type ='Creditor' and tran.amount>ac.max_income 
    order by day
)

select distinct t1.account_id
# ,t1.account_id,t1.rn1-t2.rn2
from t1
left join t2
on t1.day=t2.day and t1.account_id=t2.account_id
group by  t1.account_id,t1.rn1-t2.rn2
having count(t1.rn1-t2.rn2)>1;

