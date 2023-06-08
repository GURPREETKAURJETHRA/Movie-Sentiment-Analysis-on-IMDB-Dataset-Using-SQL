-- We should also try our hand at median rating and check whether the ‘median rating’ column gives any 
-- significant insights.

-- Q16. Of the movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8?

SELECT 
   median_rating,
Count(*) AS movie_count
FROM movie AS mov INNER JOIN 
     ratings AS rat ON rat.movie_id = mov.id
WHERE median_rating = 8
	  AND date_published BETWEEN '2018-04-01' AND '2019-04-01'
GROUP BY median_rating;

-- There are 361 movies that released between 1 April 2018 and 1 April 2019 and were given a median rating of 8.
