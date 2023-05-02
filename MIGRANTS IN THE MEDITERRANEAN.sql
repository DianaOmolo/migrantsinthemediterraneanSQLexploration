SELECT * FROM projects.migrants_in_the_mediterranean;

SELECT * FROM projects.children_migrants;

-- THE CAUSES OF DEATH
SELECT DISTINCT cause_of_death 
FROM projects.migrants_in_the_mediterranean;

-- VARIOUS MIGRATION ROUTES
SELECT DISTINCT migration_route
FROM projects.migrants_in_the_mediterranean;

-- TOTAL DEAD AND MISSING EACH YEAR
SELECT year_of_reported_date,
sum(total_dead_and_missing) as total
 FROM projects.migrants_in_the_mediterranean
  GROUP BY year_of_reported_date
   ORDER BY sum(total_dead_and_missing) DESC;


-- TOTAL DEAD EACH YEAR (WHAT YEAR HAD THE HIGHEST NUMBER OF DEATHS?)
SELECT year_of_reported_date,
sum(number_of_dead) as total_deaths
 FROM projects.migrants_in_the_mediterranean
  GROUP BY year_of_reported_date
   ORDER BY sum(number_of_dead) DESC;

-- TOTAL MISSING EACH YEAR
SELECT year_of_reported_date,
sum(total_dead_and_missing - number_of_dead) as total_missing
 FROM projects.migrants_in_the_mediterranean
  GROUP BY year_of_reported_date
   ORDER BY total_missing DESC;

-- TOTAL NUMBER OF CHILDREN EACH YEAR
SELECT year_of_reported_date,
sum(total_children_each_month) AS total_children
 FROM projects.migrants_in_the_mediterranean AS m
  LEFT JOIN projects.children_migrants AS c
   ON m.reported_date = c.reported_month
    GROUP BY year_of_reported_date
     ORDER BY sum(total_children_each_month) DESC;

-- WHAT PERCENTAGE OF TOTAL DEAD AND MISSING WERE CHILDREN EACH YEAR
SELECT year_of_reported_date,
(sum(total_children_each_month) / sum(total_dead_and_missing)) * 100 AS children_percentage
 FROM projects.migrants_in_the_mediterranean AS m
  LEFT JOIN projects.children_migrants AS c
   ON m.reported_date = c.reported_month
    GROUP BY year_of_reported_date;

-- TOTAL PEOPLE DIED AND WENT MISSING FOR UNKNOWN REASONS
SELECT year_of_reported_date,
cause_of_death,
sum(number_of_dead) AS total_deaths,
sum(total_dead_and_missing) AS missing_and_dead
  FROM projects.migrants_in_the_mediterranean
   WHERE cause_of_death = 'Unknown'
    GROUP BY year_of_reported_date;

-- MOST COMMON CAUSE OF DEATH
SELECT cause_of_death,
count(cause_of_death) AS count_of_cause
 FROM projects.migrants_in_the_mediterranean
  GROUP BY cause_of_death
   ORDER BY count(cause_of_death) DESC;

-- TOTALS FROM JANUARY 2014 TO JANUARY 2020
SELECT datediff('2020-1-25','2014-1-19') AS total_days,
sum(total_children_each_month) AS total_children,
sum(number_of_dead) AS total_dead,
sum(total_dead_and_missing - number_of_dead) AS total_missing,
sum(total_dead_and_missing) AS total_dead_missing
 FROM projects.migrants_in_the_mediterranean AS m
  LEFT JOIN projects.children_migrants AS c
   ON m.reported_date = c.reported_month;

-- INCIDENCES THAT OCCURED IN A WATER BODY
SELECT *
 FROM projects.migrants_in_the_mediterranean
  WHERE location_description 
   REGEXP 'sea|coast|water|shore|river|mediterranean|boat|beach';

-- GENERAL OVERVIEW OF BOTH TABLES
CREATE VIEW general_overview
 AS
  SELECT reported_date, 
   cause_of_death,
   total_children_each_month,
   number_of_dead,
   total_dead_and_missing
    FROM projects.migrants_in_the_mediterranean AS m
     LEFT JOIN projects.children_migrants AS c
      ON m.reported_date = c.reported_month;

SELECT * FROM general_overview;