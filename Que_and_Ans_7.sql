/* So, based on the insight that we just drew, RSVP Movies should focus on the ‘Drama’ genre. 

But wait, it is too early to decide. A movie can belong to two or more genres. 

So, let’s find out the count of movies that belong to only one genre.*/

-- Q7. How many movies belong to only one genre?

SELECT genre_count, 
       Count(movie_id) movie_count
FROM (SELECT movie_id, Count(genre) genre_count
      FROM genre
      GROUP BY movie_id
      ORDER BY genre_count DESC) genre_counts
WHERE genre_count = 1
GROUP BY genre_count;


-- 3289 movies have exactly one genre.