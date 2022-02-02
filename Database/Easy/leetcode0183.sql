# https://leetcode.com/problems/customers-who-never-order/

# My Solution
SELECT C.NAME AS CUSTOMERS FROM CUSTOMERS C LEFT JOIN ORDERS O ON C.ID = O.CUSTOMERID WHERE O.ID IS NULL;

# Optimal Solution
SELECT CUSTOMERS.NAME AS CUSTOMERS FROM CUSTOMERS WHERE
CUSTOMERS.ID NOT IN 
( 
    SELECT CUSTOMERID FROM ORDERS
);