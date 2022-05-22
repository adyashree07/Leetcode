# https://leetcode.com/problems/reformat-department-table/

# Table: Department
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | id          | int     |
# | revenue     | int     |
# | month       | varchar |
# +-------------+---------+
# (id, month) is the primary key of this table.
# The table has information about the revenue of each department per month.
# The month has values in ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"].
 
# Write an SQL query to reformat the table such that there is a department id column and a revenue column for each month.
# Return the result table in any order.

# My Solution
SELECT ID, 
       SUM(JAN_REVENUE) AS JAN_REVENUE,
       SUM(FEB_REVENUE) AS FEB_REVENUE,
       SUM(MAR_REVENUE) AS MAR_REVENUE,
       SUM(APR_REVENUE) AS APR_REVENUE,
       SUM(MAY_REVENUE) AS MAY_REVENUE,
       SUM(JUN_REVENUE) AS JUN_REVENUE,
       SUM(JUL_REVENUE) AS JUL_REVENUE,
       SUM(AUG_REVENUE) AS AUG_REVENUE,
       SUM(SEP_REVENUE) AS SEP_REVENUE,
       SUM(OCT_REVENUE) AS OCT_REVENUE,
       SUM(NOV_REVENUE) AS NOV_REVENUE,
       SUM(DEC_REVENUE) AS DEC_REVENUE
FROM (
    SELECT ID,
           CASE WHEN MONTH='Jan' THEN REVENUE
                ELSE NULL
           END AS JAN_REVENUE,
           CASE WHEN MONTH='Feb' THEN REVENUE
                ELSE NULL
           END AS FEB_REVENUE,
           CASE WHEN MONTH='Mar' THEN REVENUE
                ELSE NULL
           END AS MAR_REVENUE,
           CASE WHEN MONTH='Apr' THEN REVENUE
                ELSE NULL
           END AS APR_REVENUE,
           CASE WHEN MONTH='May' THEN REVENUE
                ELSE NULL
           END AS MAY_REVENUE,
           CASE WHEN MONTH='Jun' THEN REVENUE
                ELSE NULL
           END AS JUN_REVENUE,
           CASE WHEN MONTH='Jul' THEN REVENUE
                ELSE NULL
           END AS JUL_REVENUE,
           CASE WHEN MONTH='Aug' THEN REVENUE
                ELSE NULL
           END AS AUG_REVENUE,
           CASE WHEN MONTH='Sep' THEN REVENUE
                ELSE NULL
           END AS SEP_REVENUE,
           CASE WHEN MONTH='Oct' THEN REVENUE
                ELSE NULL
           END AS OCT_REVENUE,
           CASE WHEN MONTH='Nov' THEN REVENUE
                ELSE NULL
           END AS NOV_REVENUE,
           CASE WHEN MONTH='Dec' THEN REVENUE
                ELSE NULL
           END AS DEC_REVENUE
    FROM DEPARTMENT) T
GROUP BY ID;


# Alternate Solution
SELECT id,
      SUM(CASE WHEN month = 'Jan' THEN revenue ELSE NULL END) AS Jan_Revenue,
      SUM(CASE WHEN month = 'Feb' THEN revenue ELSE NULL END) AS Feb_Revenue,
      SUM(CASE WHEN month = 'Mar' THEN revenue ELSE NULL END) AS Mar_Revenue,
      SUM(CASE WHEN month = 'Apr' THEN revenue ELSE NULL END) AS Apr_Revenue,
      SUM(CASE WHEN month = 'May' THEN revenue ELSE NULL END) AS May_Revenue,
      SUM(CASE WHEN month = 'Jun' THEN revenue ELSE NULL END) AS Jun_Revenue,
      SUM(CASE WHEN month = 'Jul' THEN revenue ELSE NULL END) AS Jul_Revenue,
      SUM(CASE WHEN month = 'Aug' THEN revenue ELSE NULL END) AS Aug_Revenue,
      SUM(CASE WHEN month = 'Sep' THEN revenue ELSE NULL END) AS Sep_Revenue,
      SUM(CASE WHEN month = 'Oct' THEN revenue ELSE NULL END) AS Oct_Revenue,
      SUM(CASE WHEN month = 'Nov' THEN revenue ELSE NULL END) AS Nov_Revenue,
      SUM(CASE WHEN month = 'Dec' THEN revenue ELSE NULL END) AS Dec_Revenue
FROM Department
GROUP BY 1;

