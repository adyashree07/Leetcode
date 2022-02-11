# https://leetcode.com/problems/movie-rating/

# Table: Movies
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | movie_id      | int     |
# | title         | varchar |
# +---------------+---------+
# movie_id is the primary key for this table.
# title is the name of the movie.
 
# Table: Users
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | user_id       | int     |
# | name          | varchar |
# +---------------+---------+
# user_id is the primary key for this table.
 
# Table: MovieRating
# +---------------+---------+
# | Column Name   | Type    |
# +---------------+---------+
# | movie_id      | int     |
# | user_id       | int     |
# | rating        | int     |
# | created_at    | date    |
# +---------------+---------+
# (movie_id, user_id) is the primary key for this table.
# This table contains the rating of a movie by a user in their review.
# created_at is the user's review date. 
 
# Write an SQL query to:
# 1. Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
# 2. Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.

# My Solution
WITH T1 AS (
    SELECT U.NAME,
           COALESCE(COUNT(M.USER_ID),0) AS NO_OF_RATING
    FROM USERS U LEFT JOIN MOVIERATING M
    ON U.USER_ID = M.USER_ID
    GROUP BY M.USER_ID
    ORDER BY NO_OF_rATING DESC, NAME
    LIMIT 1),
T2 AS (
    SELECT M.TITLE,
           COALESCE(AVG(MR.RATING),0) AS AVG_MOVIE_RATING
    FROM MOVIES M LEFT JOIN MOVIERATING MR 
    ON M.MOVIE_ID = MR.MOVIE_ID
    WHERE DATE_FORMAT(MR.CREATED_AT,"%Y-%m")="2020-02"
    GROUP BY MR.MOVIE_ID
    ORDER BY AVG_MOVIE_RATING DESC, TITLE
    LIMIT 1)
SELECT NAME AS RESULTS FROM T1
UNION 
SELECT TITLE AS RESULTS FROM T2;

