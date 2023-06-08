-- Q28. Who are the top 3 actresses based on number of Super Hit movies (average rating >8) in drama genre?


WITH actress_summary 
     AS( SELECT n.name AS actress_name,
                SUM(total_votes) AS total_votes,
		Count(r.movie_id) AS movie_count,
                Round(Sum(avg_rating*total_votes)/Sum(total_votes),2) AS actress_avg_rating
	FROM movie AS m
             INNER JOIN ratings AS r
                   ON m.id=r.movie_id
             INNER JOIN role_mapping AS rm
                   ON m.id = rm.movie_id
             INNER JOIN names AS n
		   ON rm.name_id = n.id
             INNER JOIN GENRE AS g
                  ON g.movie_id = m.id
	WHERE lower(category) = 'actress'
              AND avg_rating>8
              AND lower(genre) = "drama"
	GROUP BY name )
SELECT *,
	   Rank() OVER(ORDER BY movie_count DESC) AS actress_rank
FROM actress_summary LIMIT 3;


-- Parvathy Thiruvothu, Susan Brown and Amanda Lawrence are the top 3 actresses based on number 
-- of Super Hit movies (average rating >8) in drama genre.