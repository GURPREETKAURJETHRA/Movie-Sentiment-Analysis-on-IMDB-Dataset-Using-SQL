-- Now as we can see four columns of the movie table has null values. 
-- Let's look at the at the movies released each year. 

-- Q3. Find the total number of movies released each year? 
-- How does the trend look month wise? 

SELECT year,
       Count(title) AS NUMBER_OF_MOVIES
FROM   movie
GROUP  BY year;

--  In Year 2017 highest no. of movies were released i.e, 3052)

-- Number of movies released each month 

SELECT Month(date_published) AS MONTH_NUM,
       Count(*)              AS NUMBER_OF_MOVIES
FROM   movie
GROUP  BY month_num
ORDER  BY month_num; 

-- March has highest and December has least no. of films released.