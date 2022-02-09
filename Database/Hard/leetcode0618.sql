# https://leetcode.com/problems/students-report-by-geography/

# Table: Student
# +-------------+---------+
# | Column Name | Type    |
# +-------------+---------+
# | name        | varchar |
# | continent   | varchar |
# +-------------+---------+
# There is no primary key for this table. It may contain duplicate rows.
# Each row of this table indicates the name of a student and the continent they came from.
 
# A school has students from Asia, Europe, and America.
# Write an SQL query to pivot the continent column in the Student table so that each name is sorted alphabetically and displayed underneath its corresponding continent. The output headers should be America, Asia, and Europe, respectively.
# The test cases are generated so that the student number from America is not less than either Asia or Europe.


# My Solution
WITH RECURSIVE T AS (
    SELECT 1 AS RNK
    UNION 
    SELECT RNK+1 FROM T WHERE RNK < (SELECT COUNT(CONTINENT) AS CNT FROM STUDENT GROUP BY CONTINENT ORDER BY CNT DESC LIMIT 1)),
    T1 AS (
    SELECT NAME AS AMERICA,
           ROW_NUMBER() OVER (ORDER BY NAME) AS RNK1
    FROM STUDENT 
    WHERE CONTINENT="America"
    ORDER BY NAME),
T2 AS (
    SELECT NAME AS ASIA,
           ROW_NUMBER() OVER (ORDER BY NAME) AS RNK2
    FROM STUDENT 
    WHERE CONTINENT="Asia"
    ORDER BY NAME),
T3 AS (
    SELECT NAME AS EUROPE,
           ROW_NUMBER() OVER (ORDER BY NAME) AS RNK3
    FROM STUDENT 
    WHERE CONTINENT="Europe"
    ORDER BY NAME)
    
SELECT AMERICA, ASIA, EUROPE FROM 
T LEFT JOIN T1 
ON T.RNK=T1.RNK1
LEFT JOIN T2
ON T.RNK=T2.RNK2
LEFT JOIN T3
ON T.RNK=T3.RNK3;


# Alternate Solution
select min(America) as America, min(Asia) as Asia, min(Europe) as Europe from
    (select 
        r1,
        case when continent = 'America' then name else null end as America,
        case when continent = 'Asia' then name else null end as Asia,
        case when continent = 'Europe' then name else null end as Europe
    from
        (select *,
        row_number() over(partition by continent order by name) as r1
        from student) t1) t2
group by r1;

