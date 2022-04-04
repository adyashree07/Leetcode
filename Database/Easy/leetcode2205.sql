# https://leetcode.com/problems/the-number-of-users-that-are-eligible-for-discount/

# Table: Purchases
# +-------------+----------+
# | Column Name | Type     |
# +-------------+----------+
# | user_id     | int      |
# | time_stamp  | datetime |
# | amount      | int      |
# +-------------+----------+
# (user_id, time_stamp) is the primary key for this table.
# Each row contains information about the purchase time and the amount paid for the user with ID user_id.
 
# A user is eligible for a discount if they had a purchase in the inclusive interval of time [startDate, endDate] with at least minAmount amount.
# Write an SQL query to report the number of users that are eligible for a discount.

# My Solution
CREATE FUNCTION getUserIDs(startDate DATE, endDate DATE, minAmount INT) RETURNS INT
BEGIN
  RETURN (
      SELECT COUNT(DISTINCT USER_ID) AS USER_CNT FROM PURCHASES WHERE (TIME_STAMP BETWEEN STARTDATE AND ENDDATE) AND AMOUNT>=MINAMOUNT
  );
END


# Alternate Solution
CREATE FUNCTION getUserIDs(startDate DATE, endDate DATE, minAmount INT) RETURNS INT
BEGIN
  RETURN (
      SELECT (COUNT(DISTINCT user_id)) AS user_cnt
      FROM Purchases
      WHERE startDate <= time_stamp AND time_stamp <= endDate AND minAmount <= amount
  );
END

