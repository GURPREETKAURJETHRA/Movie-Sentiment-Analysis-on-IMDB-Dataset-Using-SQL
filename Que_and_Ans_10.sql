
/*Thriller movies is in top 3 among all genres in terms of number of movies

 In the previous , we analysed the movies and genres tables. 
 Now, we will analyse the ratings table as well.
 
To start with lets get the min and max values of different columns in the table*/

-- Q10.  Find the minimum and maximum values in  each column of the ratings table except the movie_id column?

SELECT 
   Min(avg_rating)    AS min_avg_rating,
   Max(avg_rating)    AS max_avg_rating,
   Min(total_votes)   AS min_total_votes,
   Max(total_votes)   AS max_total_votes,
   Min(median_rating) AS min_median_rating,
   Max(median_rating) AS min_median_rating
FROM   ratings; 