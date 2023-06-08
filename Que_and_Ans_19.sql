/* Now that we have analysed the movies, genres and ratings tables, 
let us now analyse another table, the names table. 

Let’s begin by searching for null values in the tables.*/

-- Q18. Which columns in the names table have null values??

/*Hint: You can find null values for individual columns or follow below output format*/


SELECT Sum(CASE
             WHEN name IS NULL THEN 1
             ELSE 0
           END) AS name_null,
       Sum(CASE
             WHEN height IS NULL THEN 1
             ELSE 0
           END) AS height_null,
       Sum(CASE
             WHEN date_of_birth IS NULL THEN 1
             ELSE 0
           END) AS date_of_birth_null,
       Sum(CASE
             WHEN known_for_movies IS NULL THEN 1
             ELSE 0
           END) AS known_for_movies_null
FROM names;

-- null result

-- name                 0  
-- height 				17335
-- date_of_birth 	    13431	
-- known_for_movie		15226


