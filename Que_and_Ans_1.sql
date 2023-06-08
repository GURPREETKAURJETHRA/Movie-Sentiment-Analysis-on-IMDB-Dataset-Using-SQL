/* After importing the data sets, let’s explore some of the tables. 

  To begin with, it is beneficial to know the shape of the tables and whether any column has null values.
  Further in this segment, we will take a look at 'movies' and 'genre' tables.*/

-- Q1. Find the total number of rows in each table of the schema?

-- there are two ways to solve this 
-- 1) we can take count of the table individually 
-- 2) or we can fetch the names from information schema and sum the table row to get the count

--  solution 1:

SELECT Count(*) FROM director_mapping;
-- No. of rows: 3867

SELECT Count(*) FROM genre;
-- No. of rows: 14662

SELECT Count(*) FROM  names;
-- No. of rows: 25735

SELECT Count(*) FROM  ratings;
-- No. of rows: 7997

SELECT Count(*) FROM  role_mapping;
-- No. of rows: 15615

-- approach 2 solution 

SELECT
TABLE_NAME, SUM(TABLE_ROWS)
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'IMDB'
GROUP BY TABLE_NAME;

-- director_mapping	    3867
-- genre	            14662
-- movie	            8344
-- names	            23934
-- ratings	            8230
-- role_mapping	        15158



