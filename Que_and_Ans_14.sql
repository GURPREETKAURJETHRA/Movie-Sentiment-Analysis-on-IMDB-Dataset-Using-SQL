-- Q14. How many movies released in each genre during March 2017 in the USA had more than 1,000 votes?


SELECT genre,
       Count(mov.id) AS movie_count
FROM movie AS mov
     INNER JOIN genre AS gen
           ON gen.movie_id = mov.id
     INNER JOIN ratings AS rat
           ON rat.movie_id = mov.id
WHERE year = 2017
	  AND Month(date_published) = 3
	  AND country LIKE '%USA%'
	  AND total_votes > 1000
GROUP BY genre
ORDER BY movie_count DESC;


--  Query covers all conditions mentioned i.e, Month= Mar, Year = 2017, Country = USA and Votes > 1000. 
-- Drama genre had the maximum no. of releases with 24 movies whereas Family genre was least with 1 movie only.