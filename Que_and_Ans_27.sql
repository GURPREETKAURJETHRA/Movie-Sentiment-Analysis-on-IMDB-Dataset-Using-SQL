-- Finally, let’s find out the names of the top two production houses that have produced 
-- the highest number of hits among multilingual movies.

-- Q27.  Which are the top two production houses that have produced the highest number of hits 
-- (median rating >= 8) among multilingual movies?

WITH production_company_detail
     AS (SELECT production_company,
                Count(*) AS movie_count
         FROM movie AS mov
                INNER JOIN ratings AS rat
		      ON rat.movie_id = mov.id
         WHERE median_rating >= 8
	       AND production_company IS NOT NULL
               AND Position(',' IN languages) > 0
         GROUP BY production_company
         ORDER BY movie_count DESC)
SELECT *,
       Rank() over( ORDER BY movie_count DESC) AS prod_comp_rank
FROM production_company_detail LIMIT 2;

-- Star Cinema and Twentieth Century Fox are the top 2 production houses that have produced the highest number of hits.

-- Multilingual is the important piece in the above question. It was created using POSITION(',' IN languages)>0 logic
-- If there is a comma, that means the movie is of more than one language














