/* Now we know, 

movies of genre 'Drama' (produced highest in number in 2019) has the average duration of 106.77 mins.

Lets find where the movies of genre 'thriller' on the basis of number of movies.*/

/* Q9.What is the rank of the ‘thriller’ genre of movies among all the genres in terms of 
number of movies produced? */


WITH genre_summary AS
(
   SELECT  
      genre,
	  Count(movie_id)                            AS movie_count ,
	  Rank() OVER(ORDER BY Count(movie_id) DESC) AS genre_rank
   FROM       genre                                 
   GROUP BY   genre 
   )
SELECT *
FROM   genre_summary
WHERE  genre = "THRILLER" ;



-- Thriller genre has 3rd rank with 1484 movies.