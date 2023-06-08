/* James Mangold can be hired as the director for RSVP's next project. 
Do we remeber his movies, 'Logan' and 'The Wolverine'. 

Now, let’s find out the top two actors.*/

-- Q20. Who are the top two actors whose movies have a median rating >= 8?



SELECT 
   nam.name AS actor_name,
       Count(movie_id) AS movie_count
FROM role_mapping AS rm
       INNER JOIN movie AS mov
             ON mov.id = rm.movie_id
       INNER JOIN ratings AS rat USING(movie_id)
       INNER JOIN names AS nam
             ON nam.id = rm.name_id
WHERE rat.median_rating >= 8
	  AND category = 'actor'
GROUP BY actor_name
ORDER BY movie_count DESC LIMIT 2;

-- top two actor below with movie_count 
-- Mammootty	8
-- Mohanlal	5
