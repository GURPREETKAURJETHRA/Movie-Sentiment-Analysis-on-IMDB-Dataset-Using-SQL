-- Lets try to analyse with a unique problem statement.
-- Q15. Find movies of each genre that start with the word ‘The’ and which have an average rating > 8?

SELECT title, avg_rating, genre
FROM movie AS mov
     INNER JOIN genre AS gen
           ON gen.movie_id = mov.id
     INNER JOIN ratings AS rat
               ON rat.movie_id = mov.id
WHERE avg_rating > 8
	  AND title LIKE 'THE%'
ORDER BY avg_rating DESC;

--  There are 8 movies that start with the word ‘The’ and which have an average rating > 8.
-- we can group by title if we don't want repeatation in movie name.
