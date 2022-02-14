# https://leetcode.com/problems/count-the-number-of-experiments/

# Table: Experiments
# +-----------------+------+
# | Column Name     | Type |
# +-----------------+------+
# | experiment_id   | int  |
# | platform        | enum |
# | experiment_name | enum |
# +-----------------+------+
# experiment_id is the primary key for this table.
# platform is an enum with one of the values ('Android', 'IOS', 'Web').
# experiment_name is an enum with one of the values ('Reading', 'Sports', 'Programming').
# This table contains information about the ID of an experiment done with a random person, the platform used to do the experiment, and the name of the experiment.
 
# Write an SQL query to report the number of experiments done on each of the three platforms for each of the three given experiments. Notice that all the pairs of (platform, experiment) should be included in the output including the pairs with zero experiments.
# Return the result table in any order.

# My Solution
WITH T1 AS (
    SELECT "IOS" AS PLATFORM FROM EXPERIMENTS
    UNION 
    SELECT "Android" AS PLATFORM FROM EXPERIMENTS
    UNION
    SELECT "Web" AS PLATFORM FROM EXPERIMENTS),
T2 AS (
    SELECT "Reading" AS EXPERIMENT_NAME FROM EXPERIMENTS
    UNION
    SELECT "Sports" AS EXPERIMENT_NAME FROM EXPERIMENTS
    UNION
    SELECT "Programming" AS EXPERIMENT_NAME FROM EXPERIMENTS
),
T3 AS (
    SELECT * FROM T1,T2)

SELECT T3.*,
       COALESCE(COUNT(E.EXPERIMENT_ID),0) AS NUM_EXPERIMENTS
FROM T3 LEFT JOIN EXPERIMENTS E
ON T3.PLATFORM = E.PLATFORM AND T3.EXPERIMENT_NAME = E.EXPERIMENT_NAME
GROUP BY T3.PLATFORM, T3.EXPERIMENT_NAME;


# Alternate Solution
with t as
(
    select platform,experiment_name  from
    (select 'Android' platform  union all select 'IOS' platform union all select 'Web' platform)t1
    join (select 'Reading' experiment_name  union all select 'Sports' experiment_name union all select 'Programming' experiment_name)t2
    order by platform ,experiment_name
)

select t.platform,t.experiment_name,coalesce(count(if(experiment_id is not null,1,Null)),0) num_experiments
from t
left join Experiments e
on t.platform=e.platform and t.experiment_name=e.experiment_name
group by t.platform,t.experiment_name;

