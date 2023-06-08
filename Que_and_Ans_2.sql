-- Q2. Which columns in the movie table have null values?

--  there are 2 ways to solve this one also 

-- Solution 1

SELECT
(SELECT count(*) FROM movie WHERE id is NULL) as id,
(SELECT count(*) FROM movie WHERE title is NULL) as title,
(SELECT count(*) FROM movie WHERE year  is NULL) as year,
(SELECT count(*) FROM movie WHERE date_published  is NULL) as date_published,
(SELECT count(*) FROM movie WHERE duration  is NULL) as duration,
(SELECT count(*) FROM movie WHERE country  is NULL) as year, 
(SELECT count(*) FROM movie WHERE worlwide_gross_income  is NULL) as worlwide_gross_income,
(SELECT count(*) FROM movie WHERE languages  is NULL) as languages,
(SELECT count(*) FROM movie WHERE production_company  is NULL) as production_company
;

-- Solution 2

SELECT Sum(CASE
             WHEN id IS NULL THEN 1
             ELSE 0
           END) AS id_null,
       Sum(CASE
             WHEN title IS NULL THEN 1
             ELSE 0
           END) AS title_null,
       Sum(CASE
             WHEN year IS NULL THEN 1
             ELSE 0
           END) AS year_null,
       Sum(CASE
             WHEN date_published IS NULL THEN 1
             ELSE 0
           END) AS date_published_null,
       Sum(CASE
             WHEN duration IS NULL THEN 1
             ELSE 0
           END) AS duration_null,
       Sum(CASE
             WHEN country IS NULL THEN 1
             ELSE 0
           END) AS country_null,
       Sum(CASE
             WHEN worlwide_gross_income IS NULL THEN 1
             ELSE 0
           END) AS worlwide_gross_income_null,
       Sum(CASE
             WHEN languages IS NULL THEN 1
             ELSE 0
           END) AS languages_null,
       Sum(CASE
             WHEN production_company IS NULL THEN 1
             ELSE 0
           END) AS production_company_null
FROM movie;

-- found null in below given columns ( count mentioned) 
-- year 20
-- worlwide_gross_income  3724
-- languages 194
-- production_company 528
