-- ASS 1:-
-- Q6:-
-- SELECT  original_title , TAGLINE , DIRECTOR FROM MOVIES ORDER BY POPULARITY DESC LIMIT 5 ;
-- Q7 :-
--- SELECT * FROM MOVIES WHERE REVENUE IN (SELECT UNIQUE(REVENUE) FROM MOVIES);

-- ASS 2 Q1
CREATE DATABASE IF NOT EXISTS PRACTICE ;
USE PRACTICE;
Create table If Not Exists cinema (id int, movie varchar(255), description varchar(255), rating float(2, 1)) ;
Truncate table cinema ;
insert into cinema (id, movie, description, rating) values ('1', 'War', 'great 3D', '8.9') ;
insert into cinema (id, movie, description, rating) values ('2', 'Science', 'fiction', '8.5'); 
insert into cinema (id, movie, description, rating) values ('3', 'irish', 'boring', '6.2') ;
insert into cinema (id, movie, description, rating) values ('4', 'Ice song', 'Fantacy', '8.6'); 
insert into cinema (id, movie, description, rating) values ('5', 'House card', 'Interesting', '9.1');

SELECT * FROM CINEMA;
/*Write a query to report the movies with an odd-numbered ID and a description that is not "boring". 
• Return the result table ordered by rating in descending order.*/

SELECT * FROM CINEMA WHERE MOD(id, 2) != 0  AND DESCRIPTION != "BORING" ORDER BY RATING DESC ; 


-- Q3
create database new_salary; 
use new_salary; 
Create table If Not Exists employees (emp_id int, name varchar(255), salary int); 
Truncate table employees; 
insert into employees (emp_id, name, salary) values ('1', 'Louis', '6142'); 
insert into employees (emp_id, name, salary) values ('2', 'Den', '11259'); 
insert into employees (emp_id, name, salary) values ('3', 'Alexander', '5374'); 
insert into employees (emp_id, name, salary) values ('4', 'Shelli', '12572'); 
insert into employees (emp_id, name, salary) values ('5', 'Sigal', '6897'); 

SELECT * FROM EMPLOYEES;

/* Problem Description: 
Write a query to calculate the salary of all employees after an increment of 20%. Save the newly 
calculated salary column as 'New_salary'.*/

SELECT * ,ROUND( SALARY * 1.2) NEW_SALARY FROM EMPLOYEES ORDER BY EMP_ID;

/* 
Q4 :-
SELECT ORIGINAL_TITLE FROM MOVIES WHERE RELEASE_YEAR > '2014' AND VOTE_AVERAGE > 7 ORDER BY 1;*/


/* Q5. Keywords 
Problem Statement: 
Write a query to list down all the movies along with their details that have keywords like 'sport' or 
'sequel' or 'suspense'. 
Note: 
1. Return the columns 'original_title', 'director', 'genres', 'cast', 'budget', 'revenue', 'runtime', 
and 'vote_average'. 
2. Return the columns ordered by original_title in ascending order. 
Dataset description for 'movies' table is same as previous question 

SELECT original_title, director, genres, cast, budget, revenue, runtime, vote_average
FROM MOVIES WHERE KEYWORDS LIKE '%SPORT%' OR  KEYWORDS LIKE '%SEQUEL%' OR  KEYWORDS LIKE '%SUSPENSE%' ORDER BY 1 ;
*/

/* Q6. Horror genre 
Problem Statement: 
Display the details of the movies which belong to the 'Horror' genre. 
• Return the columns 'original_title', and 'popularity'. 
• Return the result ordered by the popularity in descending order. 
Dataset description for movies table is the same as previous example.
SELECT ORIGINAL_TITLE , POPULARITY FROM MOVIES WHERE UPPER(GENRE) LIKE '%HORROR%' ORDER BY POPULARITY DESC;
*/

/* Q7. 2012-2015 
Problem Statement: 
Find the details of the movies that are released between the years 2012-2015 i.e., (Including 2012 and 
2015). 
• Return the columns 'original_title', 'genres', 'vote_average', and 'revenue'. 
• Return the result ordered by original_title in ascending order. 
Dataset description for movies table is the same as previous example.

SELECT ORIGINAL_TITLE , GENRES , VOTE_AVERAGE , REVENUE 
	FROM MOVIES 
	WHERE RELEASE_YEAR BETWEEN 2012 AND 2015 
ORDER BY ORIGINAL_TITLE ASC ;

*/

/* 
Q8. Weighted avg rating 
Problem Statement: 
Calculate the weighted average rating from the columns vote_count and vote_average and save the 
column as "Weighted_avg_rating". 
Write a query to display the top 10 movies and their rating up to two decimals based on the newly 
created column. 
• Return the columns original_title, Weighted_avg_rating 
• Return the output ordered by Weighted_avg_rating in descending order 
and original_title in ascending order. 
Note: Use the given formula to calculate a weighted average rating: 
(v/(v+m) * R) + (m/(m+v) * C ) Where, 
• v is the number of votes for the movie - vote_count 
• m is the minimum vote required, take m as 104.0 
• R is the average rating of the movie - vote_average 
• C is the mean vote across the whole report take c as 5.97

SELECT ORIGINAL_TITLE ,
	ROUND((( vote_count / (vote_count +  104.0 ) *  vote_average ) + (104.0 / (104.0 + vote_count ) * 5.97  )),2) AS Weighted_avg_rating
FROM MOVIES 
ORDER BY 2 DESC , 1 ASC  
LIMIT 10;

*/

























