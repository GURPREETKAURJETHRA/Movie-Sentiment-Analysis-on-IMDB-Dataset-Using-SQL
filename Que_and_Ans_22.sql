/*Yes Marvel Studios rules the movie world.
So, these are the top three production houses based on the number of votes received by
 the movies they have produced.

Since RSVP Movies is based out of Mumbai, India also wants to woo its local audience.
 
RSVP Movies also wants to hire a few Indian actors for its upcoming project to give a regional feel. 
Let’s find who these actors could be.*/

-- Q22. Rank actors with movies released in India based on their average ratings. 
-- Which actor is at the top of the list?
-- Note: The actor should have acted in at least five Indian movies. 

/* (Hint: We should use the weighted average based on votes. If the ratings clash, 
then the total number of votes should act as the tie breaker.)*/


WITH actor_summary
     AS (SELECT n.name AS actor_name, total_votes,
                Count(R.movie_id) AS movie_count,
                Round(Sum(avg_rating * total_votes) / Sum(total_votes), 2) AS actor_avg_rating
         FROM movie AS m
                INNER JOIN ratings AS r
                      ON m.id = r.movie_id
                INNER JOIN role_mapping AS rm
					  ON m.id = rm.movie_id
                INNER JOIN names AS n
                        ON rm.name_id = n.id
         WHERE category = 'actor'
                AND country = "india"
         GROUP BY name
         HAVING movie_count >= 5)
SELECT *,
       Rank() OVER(ORDER BY actor_avg_rating DESC) AS actor_rank
FROM actor_summary;

--  Vijay Sethupathi, Fahadh Faasil and Yogi Babu are top 3 actors in respective order. 

-- Top actor is Vijay Sethupathi