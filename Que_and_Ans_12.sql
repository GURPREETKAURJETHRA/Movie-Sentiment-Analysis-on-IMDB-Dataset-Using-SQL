/* Do we find our favourite movie FAN in the top 10 movies with an average rating of 9.6? 
If not, then we have to check our code pagain!

So, now that we  know the top 10 movies, do we think character actors and filler actors can be from these movies?

Summarising the ratings table based on the movie counts by median rating can give an excellent insight.*/

-- Q12. Summarise the ratings table based on the movie counts by median ratings.
-- Order by is good to have

SELECT median_rating,
       Count(movie_id) AS movie_count
FROM ratings
GROUP BY median_rating
ORDER BY movie_count DESC;
