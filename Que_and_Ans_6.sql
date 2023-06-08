/* So, RSVP Movies plans to make a movie of one of these genres.

Now, wouldn’t we want to know which genre had the highest number of movies produced in the last year?

Combining both the movie and genres table can give more interesting insights. */

-- Q6.Which genre had the highest number of movies produced overall?

SELECT     genre,
           Count(mov.id) AS number_of_movies
FROM       movie       AS mov
INNER JOIN genre       AS gen
where      gen.movie_id = mov.id
GROUP BY   genre
ORDER BY   number_of_movies DESC limit 1 ;


-- Drama genre had the highest movies produced overall i.e, 4285.
