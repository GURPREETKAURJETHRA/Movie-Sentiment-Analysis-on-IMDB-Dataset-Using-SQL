-- Q23.Find out the top five actresses in Hindi movies released in India based on their average ratings? 
-- Note: The actresses should have acted in at least three Indian movies. 
-- (Hint: WE should use the weighted average based on votes. 
-- If the ratings clash, then the total number of votes should act as the tie breaker.)



WITH actress_detail
	 AS(
       SELECT 
          n.name AS actress_name, total_votes,
		  Count(r.movie_id) AS movie_count,
		  Round(Sum(avg_rating*total_votes)/Sum(total_votes),2) AS actress_avg_rating
        FROM movie AS m
             INNER JOIN ratings AS r
                   ON m.id=r.movie_id
			 INNER JOIN role_mapping AS rm
                   ON m.id = rm.movie_id
			 INNER JOIN names AS n
                   ON rm.name_id = n.id
	    WHERE Upper(category) = 'ACTRESS'
              AND Upper(country) = "INDIA"
              AND Upper(languages) LIKE '%HINDI%'
	   GROUP BY name
	   HAVING movie_count>=3 
       )
SELECT *,
         Rank() OVER(ORDER BY actress_avg_rating DESC) AS actress_rank
FROM actress_detail LIMIT 5;
