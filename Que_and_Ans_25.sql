
/* Until now, we have analysed various tables of the data set. 
Now, we will perform some tasks that will give us a broader understanding of the data in this segment.*/

-- Q25. What is the genre-wise running total and moving average of the average movie duration? 
-- (Note: We need to show the output table in the question.) 

SELECT genre,
       ROUND(AVG(duration),2) AS avg_duration,
       SUM(ROUND(AVG(duration),2)) OVER(ORDER BY genre ROWS UNBOUNDED PRECEDING) AS running_total_duration,
       ROUND(AVG(AVG(duration)) OVER(ORDER BY genre ROWS 10 PRECEDING),2) AS moving_avg_duration
FROM movie AS m 
INNER JOIN genre AS g 
ON m.id= g.movie_id
GROUP BY genre
ORDER BY genre;


-- Round is good to have and not a must have; Same thing applies to sorting
