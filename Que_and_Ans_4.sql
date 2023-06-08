/*The highest number of movies is produced in the month of March.

So, now that we have understood the month-wise trend of movies, 
let’s take a look at the other details in the movies table. 
We know USA and India produces huge number of movies each year. 

Lets find the number of movies produced by USA or India for the last year.*/
  
-- Q4. How many movies were produced in the USA or India in the year 2019??

-- country like india lower and upper format

SELECT Count(DISTINCT id) AS number_of_movies, year
FROM   movie
WHERE  ( upper(country) LIKE '%INDIA%'
          OR upper(country) LIKE '%USA%' )
       AND year = 2019; 

-- Number of movies produced by USA or India for the last year i.e, 2019 is "1059".