/*                                 +-------------------+-------------------+
								   ||  		SQL- RSVP MOVIES CASE STUDY        ||
								   +-------------------+-------------------+
   
   ************************************************************************************************************
   ************************************************************************************************************
   |							  SUBMITTED BY >> GURPREET KAUR 							  |
   |											  (DSC 43 BATCH)	 										  |
   *************************************************************************************************************
   *************************************************************************************************************/

USE imdb;

/* Now that you have imported the data sets, let’s explore some of the tables. 
 To begin with, it is beneficial to know the shape of the tables and whether any column has null values.
 Further in this segment, you will take a look at 'movies' and 'genre' tables.*/
 


-- Segment 1:

-- Code to show table names :

SHOW TABLES;
/* Name of tables present in schema "imdb" :
	 1. director_mapping
	 2. genre
	 3. movie
	 4. names
	 5. ratings
	 6. role_mapping
*/



-- Q1. Find the total number of rows in each table of the schema?
-- Type your code below:

	SELECT (SELECT COUNT(*) FROM `director_mapping`) AS director_mapping_rows,
		   (SELECT COUNT(*) FROM `genre`) AS genre_rows,
           (SELECT COUNT(*) FROM `movie`) AS movie_rows,
           (SELECT COUNT(*) FROM `names`) AS names_rows,
           (SELECT COUNT(*) FROM `ratings`) AS ratings_rows,
           (SELECT COUNT(*) FROM `role_mapping`) AS role_mapping_rows;


/* Ans1. Total number of rows in each table of the schema:
	+-------------------+-------------------+
	|   Table			|	  Rows count    |
	+-------------------+-------------------+
	|	director_mapping|	    3867		|
	|	genre		    |		14662   	|
	|	movie           |       7997        |
	|   names           |       25735       |
	|   ratings         |       7997        |
	|   role_mapping    |       15615       |
	+-------------------+-------------------+
*/



-- Q2. Which columns in the movie table have null values?
-- Type your code below:

SELECT COUNT(*) - COUNT(`id`) AS id_null,
       COUNT(*) - COUNT(`title`) AS title_null,
       COUNT(*) - COUNT(`year`) AS year_null,
       COUNT(*) - COUNT(`date_published`) AS date_published_null,
       COUNT(*) - COUNT(`duration`) AS duration_null,
       COUNT(*) - COUNT(`country`) AS country_null,
       COUNT(*) - COUNT(`worlwide_gross_income`) AS worlwide_gross_income_null,
       COUNT(*) - COUNT(`languages`) AS languages_null,
       COUNT(*) - COUNT(`production_company`) AS production_company_null
FROM `movie`;


/* Ans2. 4 columns having null values in them. They are as follows:
    +---------------------------+------------------+
	| Column Names(Having Null) |    Null Counts   |
    +---------------------------+------------------+
	|country_null               |        20        |
	|worlwide_gross_income_null |        3724      |
	|languages_null             |        194       |
	|production_company_null    |        528       |
    +---------------------------+------------------+
*/



-- Now as you can see four columns of the movie table has null values. Let's look at the at the movies released each year. 
-- Q3. Find the total number of movies released each year? How does the trend look month wise? (Output expected)

-- Code for first part:

SELECT `year`, 
	   COUNT(id) AS number_of_movies 
FROM movie
GROUP BY `year`
ORDER BY `year`;

/* Ans3(1st part): Total number of movies released each year are below:
+---------------+-------------------+
| Year			|	number_of_movies|
+-------------------+----------------
|	2017		|	  3052			|
|	2018		|	  2944			|
|	2019		|	  2001			|
+---------------+-------------------+*/


-- Code for second part >> How does the trend look month wise?

SELECT MONTH(date_published) AS month_num,
       COUNT(id) AS number_of_movies
FROM movie
GROUP BY month_num
ORDER BY month_num;

/*Output format for the second part of the question:
+---------------+-------------------+
|	month_num	|	number_of_movies| 
+---------------+-------------------+
|	 1          |           804     |
|    2          |           640     |
|	 3          |           824     |
|    4          |           680     |
|    5          |           625     |
|    6          |           580     |
|    7          |           493     |
|    8          |           678     |
|    9          |           809     |
|    10         |           801     |
|    11         |           625     |
|    12         |           438     |
+---------------+-------------------+ */



/*The highest number of movies is produced in the month of March.
So, now that you have understood the month-wise trend of movies, let’s take a look at the other details in the movies table. 
We know USA and India produces huge number of movies each year. Lets find the number of movies produced by USA or India for the last year.*/

-- Q4. How many movies were produced in the USA or India in the year 2019??
-- Type your code below:
SELECT  year, COUNT(id) AS movies_count_2019_india_usa
FROM movie
WHERE (country LIKE '%India%' OR country LIKE '%USA%') AND 
	  `year` = 2019;


/* Ans4. Count of movies produced in the USA or India in the year 2019 are:
+-----------+------------------------------+
|  Year     |  movies_count_2019_india_usa |
+-----------+------------------------------+
|  2019	    |              1059            |
+-----------+------------------------------+*/



/* USA and India produced more than a thousand movies(you know the exact number!) in the year 2019.
Exploring table Genre would be fun!! 
Let’s find out the different genres in the dataset.*/

-- Q5. Find the unique list of the genres present in the data set?
-- Type your code below:

SELECT DISTINCT genre
FROM genre;

/* Ans5. Unique list of the genres present in the data set 
  1. Drama
  2. Fantasy
  3. Thriller
  4. Comedy
  5. Horror
  6. Family
  7. Romance
  8. Adventure
  9. Action
 10. Sci-Fi
 11. Crime
 12. Mystery
 13. Others
*/



/* So, RSVP Movies plans to make a movie of one of these genres.
Now, wouldn’t you want to know which genre had the highest number of movies produced in the last year?
Combining both the movie and genres table can give more interesting insights. */

-- Q6.Which genre had the highest number of movies produced overall?
-- Type your code below:

SELECT genre, 
       COUNT(movie_id) AS movies_count

FROM genre AS g  
       JOIN   
     movie AS m   ON   g.movie_id = m.id

GROUP BY genre
ORDER BY movies_count DESC
LIMIT 1; 

/*+---------------+-------------------+
| genre			  |	movie_count       |
+-----------------+-------------------+
|	Drama    	  |		4285		  |
+-----------------+-------------------+

/* So, based on the insight that you just drew, RSVP Movies should focus on the ‘Drama’ genre. 
But wait, it is too early to decide. A movie can belong to two or more genres. 
So, let’s find out the count of movies that belong to only one genre.*/

-- Q7. How many movies belong to only one genre?
-- Type your code below:

WITH only_one_genre AS 
(
	SELECT movie_id, genre, COUNT(movie_id)
	FROM genre
	GROUP BY movie_id
	HAVING COUNT(movie_id) > 1
)
SELECT COUNT(movie_id) AS one_genre_movie_count
FROM only_one_genre;

-- Ans7.  3289 movies belong to only one genre


/* There are more than three thousand movies which has only one genre associated with them.
So, this figure appears significant. 
Now, let's find out the possible duration of RSVP Movies’ next project.*/

-- Q8.What is the average duration of movies in each genre? 
-- (Note: The same movie can belong to multiple genres.)

-- Type your code below:
SELECT genre, 
       ROUND(AVG(duration),2) AS avg_duration
FROM movie m 
	 JOIN 
     genre g ON g.movie_id = m.id
GROUP BY genre;

/* Output format:

+---------------+-------------------+
| genre			|	avg_duration	|
+---------------+-------------------+
|	Drama    	|		106.77		|
|	Fantasy		|		105.14	    |
|	Thriller    |       101.58      |
|   Comedy      |       102.62      |
|   Horror      |       92.72       |
|	Family      |       100.97      |
|   Romance     |       109.53      |
|   Adventure   |       101.87      |
|	Action      |       112.88      |
|   Sci-Fi      |       97.94       |
|	Crime       |       107.05      |
|   Mystery     |       101.80      |
|   Others      |		100.16	    |
+---------------+-------------------+ */


/* Now you know, movies of genre 'Drama' (produced highest in number in 2019) has the average duration of 106.77 mins.
Lets find where the movies of genre 'thriller' on the basis of number of movies.*/

-- Q9.What is the rank of the ‘thriller’ genre of movies among all the genres in terms of number of movies produced? 
-- (Hint: Use the Rank function)

-- Type your code below:
WITH rank_movies_count
     AS (SELECT genre,
                Count(movie_id)                    AS movie_count,
                Rank()
                  OVER(
                    ORDER BY Count(movie_id) DESC) AS genre_rank
         FROM   genre
         GROUP  BY genre)
SELECT *
FROM   rank_movies_count
WHERE  genre = 'Thriller'; 
 
/*Ans9. Rank of ‘thriller’ genre movie among all the genres in terms of count of movies produced.
+---------------+-------------------+---------------------+
| genre			|	movie_count	    |		genre_rank    |	
+---------------+-------------------+---------------------+
|Thriller		|	    1484		|			3		  |
+---------------+-------------------+---------------------+*/



/*Thriller movies is in top 3 among all genres in terms of number of movies
 In the previous segment, you analysed the movies and genres tables. 
 In this segment, you will analyse the ratings table as well.
To start with lets get the min and max values of different columns in the table*/




-- Segment 2:




-- Q10.  Find the minimum and maximum values in  each column of the ratings table except the movie_id column?
-- Type your code below:

SELECT ROUND(MIN(avg_rating)) AS min_avg_rating,
	   ROUND(MAX(avg_rating)) AS max_avg_rating,
       MIN(total_votes)       AS min_total_votes,
	   MAX(total_votes)       AS max_total_votes,
       MIN(median_rating)     AS min_median_rating,
	   MAX(median_rating)     AS max_median_rating
FROM ratings;

/* Ans10. Min & Max value in each columns of table 'ratings':
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
| min_avg_rating|	max_avg_rating	|	min_total_votes   |	max_total_votes 	 |min_median_rating|min_median_rating|
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
|		1		|			10		|	       100		  |	   725138	    	 |		  1	       |	    10		 |
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+*/

    

/* So, the minimum and maximum values in each column of the ratings table are in the expected range. 
This implies there are no outliers in the table. 
Now, let’s find out the top 10 movies based on average rating.*/


-- Q11. Which are the top 10 movies based on average rating?
-- Type your code below:
-- It's ok if RANK() or DENSE_RANK() is used too

WITH movie_rating_rank AS
(
	SELECT title,
		   avg_rating,
		   DENSE_RANK() OVER(ORDER BY avg_rating DESC) AS movie_rank
	FROM ratings r
		 JOIN 
		 movie m ON r.movie_id = m.id
)	
	SELECT * 
    FROM movie_rating_rank
    WHERE movie_rank <=10;

/* Ans11. Top 10 movies based on average rating
+-----------------------------------+-------------------+---------------------+
| title		                     	|		avg_rating	|		movie_rank    |
+-----------------------------------+-------------------+---------------------+
| Kirket	                        |        10	        |            1        |
| Love in Kilnerry	                |        10         |            1        |
| Gini Helida Kathe	                |        9.8	    |            2        |
| Runam	                            |        9.7	    |            3        |
| Fan	                            |        9.6	    |            4        |
| Android Kunjappan Version 5.25    |     	 9.6	    |            4        |
| Yeh Suhaagraat Impossible	        |        9.5        |          	 5        |
| Safe	                            |        9.5	    |            5        |
| The Brighton Miracle	            |        9.5	    |            5        |
| Shibu	                            |        9.4	    |            6        |
| Our Little Haven                  |        9.4	    |            6        |
| Zana	                            |        9.4	    |            6        |
| Family of Thakurganj	            |        9.4	    |            6        |
| Ananthu V/S Nusrath               |      	 9.4	    |          	 6        |
| Eghantham                         |      	 9.3	    |          	 7        |
| Wheels	                        |        9.3	    |            7        |
| Turnover                          |      	 9.2	    |            8        |
| Digbhayam	                        |        9.2	    |            8        |
| Tõde ja õigus	                    |        9.2	    |            8        |
| Ekvtime: Man of God	            |        9.2	    |            8        |
| Leera the Soulmate                |        9.2	    |            8        |
| AA BB KK	                        |        9.2	    |            8        |
| Peranbu	                        |        9.2	    |            8        |
| Dokyala Shot	                    |        9.2	    |            8        |
| Ardaas Karaan	                    |        9.2	    |            8        |
| Kuasha jakhon	                    |        9.1	    |            9        |
| Oththa Seruppu Size 7	            |        9.1	    |            9        |
| Adutha Chodyam	                |        9.1	    |            9        |
| The Colour of Darkness            |     	 9.1	    |            9        |
| Aloko Udapadi	                    |        9.1	    |            9        |
| C/o Kancharapalem	                |        9.1	    |            9        |
| Nagarkirtan                       |     	 9.1	    |            9        |
| Jelita Sejuba: Mencintai Kesatria |     	 9.1	    |            9        |
| Shindisi	                        |        9.0	    |            10       |
| Officer Arjun Singh IPS           |      	 9.0	    |            10       |
| Oskars Amerika	                |        9.0	    |            10       |
| Delaware Shore                    |        9.0	    |            10       |       
| Abstruse	                        |        9.0	    |            10       |
| National Theatre Live:            |        9.0	    |            10       |
| Angels in America Part Two - Pere.|	                |                     |
| Innocent                          |     	 9.0	    |            10       |		
+-----------------------------------+-------------------+---------------------+*/



/* Do you find you favourite movie FAN in the top 10 movies with an average rating of 9.6? If not, please check your code again!!
So, now that you know the top 10 movies, do you think character actors and filler actors can be from these movies?
Summarising the ratings table based on the movie counts by median rating can give an excellent insight.*/

-- Q12. Summarise the ratings table based on the movie counts by median ratings.
-- Type your code below:
-- Order by is good to have 

SELECT median_rating,
	   COUNT(movie_id) as movie_counts
FROM ratings
GROUP BY median_rating
ORDER BY median_rating;


/* Ans12. Movie counts by median ratings
+---------------+-------------------+
| median_rating	|	movie_count		|
+---------------+-------------------+
|	    1       |        94         |
|       2       |        119        |
|       3       |        283        |
|       4       |        479        |
|       5       |        985        |
|       6       |        1975       |
|       7       |        2257       |
|       8       |        1030       |
|       9       |        429        |
|      10       |        346        |
+---------------+-------------------+ */

 

/* Movies with a median rating of 7 is highest in number. 
Now, let's find out the production house with which RSVP Movies can partner for its next project.*/

-- Q13. Which production house has produced the most number of hit movies (average rating > 8)??
-- Type your code below:

WITH production_movie_count AS
(
    SELECT production_company,
		   COUNT(id) AS movie_count
           
	FROM movie m	
		 JOIN 
         ratings r  ON  m.id = r.movie_id
    
    WHERE avg_rating > 8 AND 
		  production_company IS NOT NULL
          
	GROUP BY production_company
    
)SELECT *,
		DENSE_RANK() OVER(ORDER BY movie_count DESC) AS prod_company_rank
FROM production_movie_count;

/*Ans13. Production house which produced most hit movies are: 
+------------------------+-------------------+---------------------+
|production_company      | movie_count	     |	prod_company_rank  |
+------------------------+-------------------+---------------------+
| Dream Warrior Pictures |		3		     |			1   	   |
| National Theatre Live  |      3            |          1          |
+------------------------+-------------------+---------------------+*/


-- It's ok if RANK() or DENSE_RANK() is used too
-- Answer can be Dream Warrior Pictures or National Theatre Live or both

-- Q14. How many movies released in each genre during March 2017 in the USA had more than 1,000 votes?
-- Type your code below:

SELECT g.genre,
	   COUNT(g.movie_id) AS movie_count	       

FROM movie m
	 JOIN
     genre g    ON  m.id = g.movie_id
     JOIN
     ratings r  ON  g.movie_id = r.movie_id
     
WHERE MONTH(m.date_published) = 3     AND
                    m.`year`  = 2017  AND
                    m.country = 'USA' AND
			    r.total_votes > 1000 
GROUP BY genre; 

/*Ans14. movies released in each genre during March 2017 in the USA had more than 1,000 votes are:
+---------------+-------------------+
| genre			|	movie_count		|
+---------------+-------------------+
|	Action      |        4          |
|   Comedy      |        8          |
|   Crime       |        5          |
|   Drama       |        16         |
|   Fantasy     |        2          |
|   Mystery     |        2          |
|   Romance     |        3          |
|   Sci-Fi      |        4          |
|   Thriller    |        4          |
|   Horror      |        5          |
|   Family      |        1          |
+---------------+-------------------+ */




-- Lets try to analyse with a unique problem statement.
-- Q15. Find movies of each genre that start with the word ‘The’ and which have an average rating > 8?
-- Type your code below: 

SELECT m.title,
	   r.avg_rating,
       g.genre

FROM movie m
	 JOIN
     genre g    ON  m.id = g.movie_id
     JOIN
     ratings r  ON  g.movie_id = r.movie_id
     
WHERE m.title LIKE 'The%' AND
	  r.avg_rating > 8;

/*Ans15. Movie start with 'The' & having 'avg_rating > 8' are:
+------------------------------------+-------------------+---------------------+
| title			                     |		avg_rating   |		genre	       |
+------------------------------------+-------------------+---------------------+
| The Blue Elephant 2                |        8.8        |      Drama          |
| The Blue Elephant 2                |        8.8        |      Horror         |
| The Blue Elephant 2                |        8.8        |      Mystery        |
| The Brighton Miracle               |        9.5        |      Drama          |
| The Irishman                       |        8.7        |      Crime          |
| The Irishman                       |        8.7        |      Drama          |
| The Colour of Darkness             |        9.1        |      Drama          |
| Theeran Adhigaaram Ondru           |        8.3        |      Action         |
| Theeran Adhigaaram Ondru           |        8.3        |      Crime          |
| Theeran Adhigaaram Ondru           |        8.3        |      Thriller       |
| The Mystery of Godliness:The Sequel|        8.5        |      Drama          |
| The Gambinos                       |        8.4        |      Crime          |
| The Gambinos                       |        8.4        |      Drama          |
| The King and I                     |        8.2        |      Drama          |
| The King and I                     |        8.2        |      Romance        |
+------------------------------------+-------------------+---------------------+*/


-- You should also try your hand at median rating and check whether the ‘median rating’ column gives any significant insights.
-- Q16. Of the movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8?
-- Type your code below:

SELECT 
	   median_rating, 
       COUNT(id) AS `movie_count 1 April 2018 - 1 April 2019`

FROM   movie m
	   JOIN
       ratings r  ON  m.id = r.movie_id

WHERE 
       date_published >= '2018-04-01' AND 
	   date_published <=  '2019-04-01' AND 
       median_rating  =   8;

/* Ans16 for movies released between 1 April 2018 and 1 April 2019 with median rating 8:
+------------------+------------------------------------------+
|  median_rating   | movie_count 1 April 2018 - 1 April 2019  |
+------------------+------------------------------------------+
|        8         |            361							  |
+------------------+------------------------------------------+*/


-- Once again, try to solve the problem given below.
-- Q17. Do German movies get more votes than Italian movies? 
-- Hint: Here you have to find the total number of votes for both German and Italian movies.
-- Type your code below: 

WITH total_votes_country AS
(
	SELECT m.languages,
		   r.total_votes
	FROM 
		 movie m
		 JOIN 
		 ratings r  ON  m.id = r.movie_id
)SELECT 
	   (SELECT SUM(total_votes) 
		FROM  total_votes_country
		WHERE languages LIKE '%German%') AS Total_Votes_German,
	   (SELECT SUM(total_votes) 
		FROM  total_votes_country
		WHERE languages LIKE '%Italian%') AS Total_Votes_Italian;

/*Ans17. Yes, German movies get more votes than Italian movies
+--------------------+----------------------+
| Total_Votes_German |	Total_Votes_Italian |
+--------------------+----------------------+
|	   4421525       |        2559540       |
+--------------------+----------------------+*/



-- Answer is Yes

/* Now that you have analysed the movies, genres and ratings tables, let us now analyse another table, the names table. 
Let’s begin by searching for null values in the tables.*/




-- Segment 3:



-- Q18. Which columns in the names table have null values??
-- Type your code below:
-- Hint: You can find null values for individual columns or follow below output format

SELECT 
       COUNT(*) - COUNT(`name`) AS name_nulls,
       COUNT(*) - COUNT(`height`) AS height_nulls,
       COUNT(*) - COUNT(`date_of_birth`) AS date_of_birth_nulls,
       COUNT(*) - COUNT(`known_for_movies`) AS known_for_movies_nulls
FROM `names`;


/*Ans18. columns in the names table having null values are:
+---------------+-------------------+---------------------+----------------------+
| name_nulls	|	height_nulls	|date_of_birth_nulls  |known_for_movies_nulls|
+---------------+-------------------+---------------------+----------------------+
|		0		|		17335		|	      13431		  |	   15226	    	 |
+---------------+-------------------+---------------------+----------------------+*/



/* There are no Null value in the column 'name'.
The director is the most important person in a movie crew. 
Let’s find out the top three directors in the top three genres who can be hired by RSVP Movies.*/

-- Q19. Who are the top three directors in the top three genres whose movies have an average rating > 8?
-- (Hint: The top three genres would have the most number of movies with an average rating > 8.)
-- Type your code below:


WITH top_three_genre AS
(
	SELECT genre
	FROM genre
         JOIN
		 ratings USING (movie_id)
	WHERE avg_rating > 8
    GROUP BY genre
    ORDER BY count(movie_id) DESC
	LIMIT 3
)
	SELECT  n.`name` AS director_name, 
			COUNT(dm.movie_id) AS movie_count	
			
	FROM director_mapping dm
		 JOIN
		`names` n  ON  dm.name_id = n.id
		 JOIN  
		 genre g   ON  g.movie_id = dm.movie_id
         JOIN
         ratings r ON  r.movie_id = g.movie_id
		 
	WHERE  
		  genre IN (SELECT * FROM top_three_genre) AND
          avg_rating > 8
					
	GROUP BY n.`name`
	ORDER BY movie_count DESC
    LIMIT 3;


/* Output format:

+---------------+-------------------+
| director_name	|	movie_count		|
+---------------+-------------------|
|James Mangold	|		4			|
|Anthony Russo	|		3			|
|Joe Russo		|		3			|
+---------------+-------------------+ */


/* James Mangold can be hired as the director for RSVP's next project. Do you remeber his movies, 'Logan' and 'The Wolverine'. 
Now, let’s find out the top two actors.*/

-- Q20. Who are the top two actors whose movies have a median rating >= 8?
-- Type your code below:

SELECT 
    n.`name` AS actor_name, 
    COUNT(movie_id) AS movie_count
FROM
    movie AS m
        INNER JOIN
    role_mapping AS rm ON m.id = rm.movie_id
        INNER JOIN
    ratings AS r USING (movie_id)
        INNER JOIN
    `names` AS n ON rm.name_id = n.id
WHERE
    median_rating >= 8
        AND category = 'actor'
GROUP BY actor_name
ORDER BY movie_count DESC
LIMIT 2;

/*Ans20. top two actors whose movies have a median rating >= 8 are:
+---------------+-------------------+
| actor_name	|	movie_count		|
+-------------------+----------------
|  Mammootty    |		8			|
|  Mohanlal	    |		5			|
+---------------+-------------------+ */



/* Have you find your favourite actor 'Mohanlal' in the list. If no, please check your code again. 
RSVP Movies plans to partner with other global production houses. 
Let’s find out the top three production houses in the world.*/

-- Q21. Which are the top three production houses based on the number of votes received by their movies?
-- Type your code below:

SELECT production_company, 
	   SUM(total_votes) AS vote_count,
	   DENSE_RANK() OVER (ORDER BY SUM(total_votes) DESC) AS prod_comp_rank

FROM ratings AS r
	 INNER JOIN movie AS m   ON   r.movie_id = m.id

GROUP BY production_company
ORDER BY vote_count DESC
LIMIT 3;

/*Ans21. Top three production houses based on the number of votes received by their movies are:
+-----------------------+-----------------------+---------------------+
|production_company     |     vote_count		|	prod_comp_rank    |
+-----------------------+-----------------------+---------------------+
| Marvel Studios	    |	  2656967	    	|	  	   1	      |
| Twentieth Century Fox	|	  2411163		    |		   2   		  |
| Warner Bros.			|	  2396057		    |		   3          |
+-------------------+-------------------+-----------------------------+*/




/*Yes Marvel Studios rules the movie world.
So, these are the top three production houses based on the number of votes received by the movies they have produced.

Since RSVP Movies is based out of Mumbai, India also wants to woo its local audience. 
RSVP Movies also wants to hire a few Indian actors for its upcoming project to give a regional feel. 
Let’s find who these actors could be.*/

-- Q22. Rank actors with movies released in India based on their average ratings. Which actor is at the top of the list?
-- Note: The actor should have acted in at least five Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)

SELECT n.`name` AS actor_name,
	   SUM(r.total_votes) AS sum_total_votes,
       COUNT(r.movie_id) AS movie_count,
	   ROUND(Sum(avg_rating * total_votes) / SUM(total_votes), 2) AS actor_avg_rating,
       DENSE_RANK() OVER (
						  ORDER BY ROUND(SUM(avg_rating * r.total_votes) / SUM(r.total_votes), 2) DESC, 
								   SUM(r.total_votes) desc
						  ) AS actor_rank

FROM `names` n 
      JOIN
      role_mapping rm   ON   n.id = rm.name_id
      JOIN
      ratings r         ON   r.movie_id =  rm.movie_id
      JOIN
      movie m      		ON 		 m.id = r.movie_id
      
WHERE m.country   LIKE '%India%' AND 
	  rm.category LIKE '%Actor%'
      
GROUP BY actor_name
HAVING movie_count >=5 
LIMIT 1;

/* Output for Ranking actors with movies released in India based on their average ratings are:
+-------------------+-------------------+---------------------+----------------------+-----------------+
| actor_name	    |	total_votes		|	movie_count		  |	actor_avg_rating 	 |  actor_rank	   |
+-------------------+-------------------+---------------------+----------------------+-----------------+
| Vijay Sethupathi	|		23114	    |	       5		  |	   8.42	    		 |		1	       |
+-------------------+-------------------+---------------------+----------------------+-----------------+*/
 
-- Top actor is Vijay Sethupathi



-- Q23.Find out the top five actresses in Hindi movies released in India based on their average ratings? 
-- Note: The actresses should have acted in at least three Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)
-- Type your code below:

SELECT n.`name` AS actress_name,
	   SUM(r.total_votes) AS sum_total_votes,
       COUNT(r.movie_id) AS movie_count,
	   ROUND(SUM(avg_rating * total_votes) / SUM(total_votes), 2) AS actress_avg_rating,
       DENSE_RANK() OVER (
						   ORDER BY ROUND(SUM(avg_rating * r.total_votes) / SUM(r.total_votes), 2) desc,
                           SUM(r.total_votes) DESC
						  ) AS actress_rank

FROM `names` n 
      JOIN
      role_mapping rm   ON   n.id = rm.name_id
      JOIN
      ratings r         ON   r.movie_id =  rm.movie_id
      JOIN
      movie m      		ON 		 m.id = r.movie_id
      
WHERE m.languages LIKE '%Hindi%' AND 
	  rm.category LIKE '%Actress%' AND 
      country='india' 
      
GROUP BY actress_name
HAVING movie_count >=3
LIMIT 5;

/* Output for top five actresses in Hindi movies released in India based on their average ratings are:
+-------------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	    |	total_votes		|	movie_count		  |	actress_avg_rating 	 |actress_rank	   |
+-------------------+-------------------+---------------------+----------------------+-----------------+
| Taapsee Pannu		|		18061   	|	       3		  |	      7.74    		 |		1	       |
| Kriti Sanon		|		21967		|	       3		  |	      7.05    		 |		2	       |
| Divya Dutta		|		8579		|	       3		  |	   	  6.88  		 |		3	       |
| Shraddha Kapoor	|		26779		|	       3		  |	   	  6.63  		 |		4	       |
| Kriti Kharbanda	|		2549		|	       3		  |	   	  4.80  		 |		5	       |
+-------------------+-------------------+---------------------+----------------------+-----------------+*/

/* Taapsee Pannu tops with average rating 7.74. 
Now let us divide all the thriller movies in the following categories and find out their numbers.*/


/* Q24. Select thriller movies as per avg rating and classify them in the following category: 

			Rating > 8: Superhit movies
			Rating between 7 and 8: Hit movies
			Rating between 5 and 7: One-time-watch movies
			Rating < 5: Flop movies
--------------------------------------------------------------------------------------------*/
-- Type your code below:

SELECT title,
	   genre,
       avg_rating,
       CASE
			WHEN avg_rating > 8             THEN 'Superhit movies'
            WHEN avg_rating BETWEEN 7 AND 8 THEN 'Hit movies'
            WHEN avg_rating BETWEEN 5 AND 7 THEN 'One-time-watch movies'
            WHEN avg_rating < 5             THEN 'Flop movies'
		END AS `category`
FROM
	 movie m
     JOIN
     genre g    ON  m.id = g.movie_id
     JOIN
     ratings r  USING (movie_id)
     
WHERE genre = 'Thriller';

/*+--------------------------+--------------------+------------------------+--------------------------------------+
  |     title                |     genre          |     avg_rating         |              category                |
  +--------------------------+--------------------+------------------------+--------------------------------------+
  | Der müde Tod			 |     Thriller       |       7.7              |    		Hit movies				  |
  | Fahrenheit 451			 |     Thriller       |       4.9              |    		Flop movies				  |
  | Pet Sematary			 |     Thriller       |       5.8              |    		One-time-watch movies     |
  | Dukun			         |     Thriller       |       6.9              |    		One-time-watch movies     |
  | ......			         |     ........       |       ...              |    		   ......			      |
  +--------------------------+--------------------+------------------------+--------------------------------------+/*
  
/*Until now, you have analysed various tables of the data set. 
Now, you will perform some tasks that will give you a broader understanding of the data in this segment.*/

-- Segment 4:

-- Q25. What is the genre-wise running total and moving average of the average movie duration? 
-- (Note: You need to show the output table in the question.) 
-- Type your code below:

SELECT genre,
	   ROUND(AVG(duration),2) AS avg_duration,
       SUM(ROUND(AVG(duration),2)) OVER w AS running_total_duration,
	   AVG(ROUND(AVG(duration),2)) OVER w AS moving_avg_duration
       
FROM genre g 
	 JOIN
     movie m    ON    m.id = g.movie_id

GROUP BY genre
WINDOW  w  AS  (ROWS UNBOUNDED PRECEDING)
ORDER BY avg_duration DESC;

/* Output format:
+---------------+-------------------+---------------------+----------------------+
| genre			|	avg_duration	|running_total_duration|moving_avg_duration  |
+---------------+-------------------+---------------------+----------------------+
|Action			|	112.8829		|	934.0935		  |	103.78816667         |
|Romance		|	109.5342		|	719.3392		  |	102.76274286         |
|Crime			|	107.0517		|	1139.0865		  |	103.55331818         |
|Drama          |	106.7746		|	106.7746		  |	106.77460000         |
|Fantasy		|	105.1404		|	211.9150		  |	105.95750000         |
|Comedy			|	102.6227		|	416.1138		  |	104.02845000         |
|Adventure		|	101.8714		|	821.2106		  |	102.65132500         |
|Mystery		|	101.8000		|	1240.8865		  |	103.40720833         |
|Thriller		|	101.5761		|	313.4911		  |	104.49703333         |
|Family			|	100.9669		|	609.8050		  |	101.63416667         |
|Others			|	100.1600		|	1341.0465		  |	103.15742308         |
|Sci-Fi			|	97.9413			|	1032.0348		  |	103.20348000         |
|Horror			|	92.7243			|	508.8381		  |	101.76762000         |
+---------------+-------------------+---------------------+----------------------+*/

-- Round is good to have and not a must have; Same thing applies to sorting


-- Let us find top 5 movies of each year with top 3 genres.

-- Q26. Which are the five highest-grossing movies of each year that belong to the top three genres? 
-- (Note: The top 3 genres would have the most number of movies.) 

-- Type your code below:
-- Top 3 Genres based on most number of movies
    
    WITH TOP3_genre AS
( 	
	SELECT genre, COUNT(movie_id) AS number_of_movies
    FROM genre AS g
    INNER JOIN movie AS m
    ON g.movie_id = m.id
    GROUP BY genre
    ORDER BY COUNT(movie_id) DESC
    LIMIT 3
),

TOP_5_YEARWISE_INCOMEWISE AS
(
	SELECT genre,
			year,
			title AS movie_name,
			CONVERT(REPLACE(TRIM(worlwide_gross_income), "$ ",""), UNSIGNED INT) AS worlwide_gross_income
        
	FROM movie AS m 
    INNER JOIN genre AS g 
    ON m.id= g.movie_id
	WHERE genre IN (SELECT genre FROM TOP3_genre)
),

FINAL_RANKING AS (SELECT *, 
	  DENSE_RANK() OVER(PARTITION BY year ORDER BY worlwide_gross_income DESC) AS movie_rank
FROM TOP_5_YEARWISE_INCOMEWISE)

SELECT genre, `year`, movie_name, worlwide_gross_income, movie_rank 
FROM FINAL_RANKING 
WHERE movie_rank <= 5;
                        
                        
    /* Output for Top 5 movies of each year with top 3 genres based on most number of movies are:
+---------------+-------------------+-------------------------------+--------------------------+-------------------+
| genre			|	   year			|	      movie_name	        | worldwide_gross_income2  |   movie_rank	   |
+---------------+-------------------+-------------------------------+--------------------------+-------------------+
|	  Thriller	|      2017	        | The Fate of the Furious       |	      1236005118 	   |         1         |
|     Comedy	|      2017	        | Despicable Me 3	            |         1034799409       |         2         |
|     Comedy	|      2017	        | Jumanji: Welcome to the Jungle|         962102237 	   |         3         |
|     Drama  	|      2017	        | Zhan lang II            		|         870325439 	   |         4         |
|     Thriller	|      2017	        | Zhan lang II        			|	      870325439        |	     4         |
|     Comedy	|      2017	        | Guardians of the Galaxy Vol. 2|	      863756051 	   |         5         |
|     Drama	    |      2018	 	    | Bohemian Rhapsody        		|         903655259        | 		 1		   |
|     Thriller  |	   2018	        | Venom      					|         856085151 	   |         2		   |
|     Thriller	|      2018	        | Mission: Impossible - Fallout	|         791115104 	   |         3         |
|     Comedy	|      2018	        | Deadpool 2	                |         785046920        |         4         |
|     Comedy	|      2018	        | Ant-Man and the Wasp	        |         622674139 	   |         5         |
|     Drama	    |      2019	        | Avengers: Endgame   			|         2797800564 	   |     	 1		   |
|     Drama	    |      2019	        | The Lion King					| 		  1655156910 	   |		 2		   |
|     Comedy    |      2019			| Toy Story 4					| 		  1073168585       |         3		   |
|     Drama	    |      2019			| Joker			                |         995064593 	   |		 4		   |
|     Thriller	|      2019			| Joker			                |         995064593  	   |   	     4		   |
|     Thriller	|      2019			| Ne Zha zhi mo tong jiang shi	| 		  700547754 	   |         5         |
+---------------+-------------------+-------------------------------+--------------------------+-------------------+*/
    
    
-- Finally, let’s find out the names of the top two production houses that have produced the highest number of hits among multilingual movies.
-- Q27.  Which are the top two production houses that have produced the highest number of hits (median rating >= 8) among multilingual movies?
-- Type your code below:

SELECT production_company,
	   COUNT(id) AS movie_count,
	   DENSE_RANK() OVER (ORDER BY COUNT(id) DESC) AS prod_comp_rank
FROM movie m
INNER JOIN ratings r
ON m.id = r.movie_id
WHERE median_rating >= 8 AND languages LIKE '%,%' AND production_company IS NOT NULL
GROUP BY production_company
LIMIT 2;

/* Output for top two production houses that have produced the highest number of hits:
+----------------------+---------------------+-----------------------+
|production_company    |   movie_count	     |		prod_comp_rank   |
+----------------------+---------------------+-----------------------+
| Star Cinema		   |		7            |		    1	  		 |
|Twentieth Century Fox |		4		     |		    2   		 |
+----------------------+---------------------+-----------------------+*/


-- Multilingual is the important piece in the above question. It was created using POSITION(',' IN languages)>0 logic
-- If there is a comma, that means the movie is of more than one language


-- Q28. Who are the top 3 actresses based on number of Super Hit movies (average rating >8) in drama genre?
-- Type your code below:

SELECT     `NAME`                                       AS actress_name,
           Sum(total_votes)                             AS total_votes,
           Count(rm.movie_id)                           AS movie_count,
           avg_rating                                   AS actress_avg_rating,
           Dense_rank() OVER (ORDER BY avg_rating DESC) AS actress_rank
FROM       movie m
INNER JOIN ratings r
ON         m.id = r.movie_id
INNER JOIN genre
using      (movie_id)
INNER JOIN role_mapping rm
using      (movie_id)
INNER JOIN names n
ON         n.id = rm.name_id
WHERE      genre = 'drama'
AND        avg_rating >= 8
AND        category = 'Actress'
GROUP BY   actress_name limit 3;

/* Output for top 3 actresses based on number of Super Hit movies (average rating >8) in drama genre:
+-----------------+-------------------+---------------------+------------------------+-----------------+
| actress_name	  |	 total_votes	  |	     movie_count	|    actress_avg_rating	 |   actress_rank  |
+-----------------+-------------------+---------------------+------------------------+-----------------+
| Sangeetha Bhat  |		 1010	      |	       1		    |	   9.60			     |		1	       |
| Fatmire Sahiti  |		 3932		  |	       1		    |	   9.40	    		 |		2	       |
| Adriana Matoshi |		 3932		  |	       1		    |	   9.40	    		 |		2	       |
+-----------------+-------------------+---------------------+------------------------+-----------------+*/
        
        
/* Q29. Get the following details for top 9 directors (based on number of movies)
Director id
Name
Number of movies
Average inter movie duration in days
Average movie ratings
Total votes
Min rating
Max rating
total movie durations*/

-- Type you code below:

WITH director AS
(
         SELECT   dm.name_id                                                                                                   AS `director id`,
                  `NAME`                                                                                                       AS `director_name`,
                  datediff(lead(m.date_published,1) over(partition BY dm.name_id ORDER BY m.date_published), m.date_published) AS inter_movie_days,
                  r.avg_rating,
                  total_votes AS `total_votes`,
                  m.duration
         FROM     director_mapping dm
         JOIN     `names` n
         ON       dm.name_id = n.id
         JOIN     movie m
         ON       m.id = dm.movie_id
         JOIN     ratings r
         ON       m.id = r.movie_id)
SELECT   `director id`,
         director_name,
         count(`director id`)         AS number_of_movies,
         round(avg(inter_movie_days)) AS avg_inter_movie_days,
         round(avg(avg_rating),2)     AS avg_rating,
         sum(total_votes)             AS total_votes,
         min(avg_rating)              AS min_rating,
         max(avg_rating)              AS max_rating,
         sum(duration)                AS total_duration
FROM     director
GROUP BY `director id`
ORDER BY number_of_movies DESC ,
         avg_rating DESC limit 9;

/*Output for details for top 9 directors (based on number of movies):
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
| Director id	|	director_name	|	number_of_movies  |	avg_inter_movie_days |	avg_rating	| total_votes  | min_rating	| max_rating | total_duration |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
|   nm1777967   |  A.L. Vijay	    |          5	      |          177	     |      5.42	|    1754	   |     3.7	|    6.9	 |      613		  |
|   nm2096009	|  Andrew Jones	    |          5	      |          191	     |      3.02	|    1989	   |     2.7	|    3.2	 |      432		  |
|   nm0001752	|  Steven Soderbergh|	       4	      |          254	     |      6.48	|    171684	   |     6.2	|    7.0	 |      401		  |
|   nm0515005	|  Sam Liu	        |          4	      |          260	     |      6.23	|    28557     |	 5.8	|    6.7	 |      312		  |
|   nm0814469	|  Sion Sono	    |          4	      |          331	     |      6.03	|    2972	   |     5.4	|    6.4	 |      502       |
|   nm0425364	|  Jesse V. Johnson |          4	      |          299	     |      5.45	|    14778	   |     4.2	|    6.5	 |      383       |
|   nm2691863	|  Justin Price	    |          4	      |          315	     |      4.50	|    5343	   |     3.0	|    5.8	 |      346       |
|   nm0831321	|  Chris Stokes	    |          4	      |          198	     |      4.33	|    3664	   |     4.0	|    4.6	 |      352		  |
|   nm6356309	|  Özgür Bakar	    |          4	      |          112	     |      3.75	|    1092	   |     3.1	|    4.9	 |      374		  |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
*/

						/*^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^*/
						/** 				THANK YOU					 */
                        /*^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^*/

   /************************************************************************************************************
   	|							  SUBMITTED BY >>>   GURPREET KAUR 							   |
	|												(DSC 43 BATCH)											   |
   *************************************************************************************************************
   *
