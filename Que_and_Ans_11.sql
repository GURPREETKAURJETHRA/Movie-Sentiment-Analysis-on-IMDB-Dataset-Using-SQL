/* So, the minimum and maximum values in each column of the ratings table are in the expected range. 

This implies there are no outliers in the table. 
Now, let’s find out the top 10 movies based on average rating.*/

-- Q11. Which are the top 10 movies based on average rating?

-- For that we will use here RANK() or DENSE_RANK()

-- Finding the rank of each movie based on it's average rating
-- Displaying the top 10 movies using LIMIT clause

SELECT     
   title,
   avg_rating,
   Rank() OVER(ORDER BY avg_rating DESC) AS movie_rank
FROM       ratings AS rat
INNER JOIN movie   AS mov
ON         mov.id = rat.movie_id limit 10;

