-- Q17. Do German movies get more votes than Italian movies? 

-- Hint: Here we have to find the total number of votes for both German and Italian movies.

SELECT 
   country, 
   sum(total_votes) as total_votes
FROM movie AS mov
	INNER JOIN ratings as rat
          ON mov.id=rat.movie_id
WHERE lower(country) = 'germany' or lower(country) = 'italy'
GROUP BY country;

-- From the output we can see that German movies have more votes than Italian movies. 
-- country  total_votes
-- Germany	106710
-- Italy	77965



-- Answer is Yes