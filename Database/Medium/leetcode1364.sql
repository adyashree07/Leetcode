# https://leetcode.com/problems/number-of-trusted-contacts-of-a-customer/

# Table: Customers
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | customer_id   | int     |
# | customer_name | varchar |
# | email         | varchar |
# +---------------+---------+
# customer_id is the primary key for this table.
# Each row of this table contains the name and the email of a customer of an online shop.
 
# Table: Contacts
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | user_id       | id      |
# | contact_name  | varchar |
# | contact_email | varchar |
# +---------------+---------+
# (user_id, contact_email) is the primary key for this table.
# Each row of this table contains the name and email of one contact of customer with user_id.
# This table contains information about people each customer trust. The contact may or may not exist in the Customers table.
 
# Table: Invoices
# +--------------+---------+
# | Column Name  | Type    |
# +--------------+---------+
# | invoice_id   | int     |
# | price        | int     |
# | user_id      | int     |
# +--------------+---------+
# invoice_id is the primary key for this table.
# Each row of this table indicates that user_id has an invoice with invoice_id and a price.

# Write an SQL query to find the following for each invoice_id:
# 1. customer_name: The name of the customer the invoice is related to.
# 2. price: The price of the invoice.
# 3. contacts_cnt: The number of contacts related to the customer.
# 4. trusted_contacts_cnt: The number of contacts related to the customer and at the same time they are customers to the shop. (i.e their email exists in the Customers table.)
# Return the result table ordered by invoice_id.

# My Solution
WITH CTE AS 
(SELECT C.USER_ID, 
        CU.CUSTOMER_NAME, 
        COUNT(C.CONTACT_NAME) AS CNT 
 FROM CONTACTS C LEFT JOIN CUSTOMERS CU ON C.USER_ID=CU.CUSTOMER_ID 
 WHERE C.CONTACT_NAME IN (SELECT CUSTOMER_NAME FROM CUSTOMERS) GROUP BY C.USER_ID)

SELECT I.INVOICE_ID, 
       CU.CUSTOMER_NAME, 
       I.PRICE, 
       COUNT(C.USER_ID) AS CONTACTS_CNT,
       COALESCE(CT.CNT,0) AS TRUSTED_CONTACTS_CNT 
FROM INVOICES I LEFT JOIN CUSTOMERS CU ON I.USER_ID=CU.CUSTOMER_ID
LEFT JOIN CONTACTS C ON I.USER_ID = C.USER_ID
LEFT JOIN CTE CT ON I.USER_ID = CT.USER_ID
GROUP BY I.INVOICE_ID, CU.CUSTOMER_NAME
ORDER BY I.INVOICE_ID;


# Alternate Solution
WITH a AS
    -- contacts_cnt
    (SELECT distinct user_id, count(user_id) as contacts_cnt
    FROM contacts
    GROUP BY user_id),

b AS
    -- trusted_contacts_cnt
    (SELECT distinct user_id, count(user_id) as trusted_contacts_cnt
    FROM contacts
    WHERE contact_name IN
        (SELECT customer_name
        FROM customers)
    GROUP BY user_id),
    
c AS 
    (SELECT customer_id, customer_name, 
        IFNULL(contacts_cnt,0) as contacts_cnt,
        IFNULL(trusted_contacts_cnt,0) as trusted_contacts_cnt
    FROM customers c
    LEFT JOIN a
        ON c.customer_id = a.user_id
    LEFT JOIN b
        ON c.customer_id = b.user_id)

SELECT invoice_id, customer_name, price, contacts_cnt, trusted_contacts_cnt
FROM c
JOIN invoices i
    ON c.customer_id = i.user_id
ORDER BY invoice_id;

