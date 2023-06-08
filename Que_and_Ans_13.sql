/* Movies with a median rating of 7 is highest in number. 

Now, let's find out the production house with which RSVP Movies can partner for its next project.*/

-- Q13. Which production house has produced the most number of hit movies (average rating > 8)??

SELECT production_company,
      Count(movie_id) AS movie_count, 
      Rank() OVER( ORDER BY Count(movie_id) DESC ) AS prod_company_rank
FROM ratings AS rat
     INNER JOIN movie AS mov
     ON mov.id = rat.movie_id
WHERE avg_rating > 8
     AND production_company IS NOT NULL
GROUP BY production_company;



-- Dream Warrior Pictures and National Theatre Live production both have the most number of hit movies i.e, 3 movies with average rating > 8




-- It's ok if RANK() or DENSE_RANK() is used too
-- Answer can be Dream Warrior Pictures or National Theatre Live or both
