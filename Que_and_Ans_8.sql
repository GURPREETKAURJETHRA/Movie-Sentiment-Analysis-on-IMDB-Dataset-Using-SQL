/* There are more than three thousand movies which has only one genre associated with them.

So, this figure appears significant. 
Now, let's find out the possible duration of RSVP Movies’ next project.*/

-- Q8.What is the average duration of movies in each genre? 
-- (Note: The same movie can belong to multiple genres.)


SELECT     genre,
           Round(Avg(duration),2) AS avg_duration
FROM       movie as mov
INNER JOIN genre as gen
ON      gen.movie_id = mov.id
GROUP BY   genre
ORDER BY avg_duration DESC;

/* Duration of Action movies is highest with duration of 112.88 mins whereas Horror movies have 
least with duration 92.72 mins. */
