/*
RSVP Movies plans to partner with other global production houses. 
Let’s find out the top three production houses in the world.*/

-- Q21. Which are the top three production houses based on the number of votes received by their movies?



SELECT 
   production_company,
   Sum(total_votes) AS vote_count,
   Rank() OVER(ORDER BY Sum(total_votes) DESC) AS prod_comp_rank
FROM movie AS mov
INNER JOIN ratings AS rat
	  ON rat.movie_id = mov.id
GROUP BY production_company LIMIT 3;

/* Marvel Studios, Twentieth Century Fox and Warner Bros are top three production houses based on the 
number of votes received by their movies.*/