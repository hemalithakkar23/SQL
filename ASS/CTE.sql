SHOW DATABASES;
USE HR;
-- Write a query to find the name (first_name, last_name) of the employees who are managers
SELECT FIRST_NAME , LAST_NAME FROM EMPLOYEES WHERE  EMPLOYEE_ID IN (SELECT MANAGER_ID FROM EMPLOYEES);

-- Print the employees who are earning more than the average salary of  their department.


USE HR2;
SELECT * FROM EMPLOYEES;

-- Return movie_id, budget_adj, revenue_adj columns from financial table of moviesdb database where budget_adj and revenue_adj are budget & revenue converted into Million INR.
USE MOVIESDB;
SELECT * FROM MOVIES ; 
SELECT * FROM financialS;
-- •Print the movie titles, industry and revenue. Sort the result in descending order of profit (profit = revenue – budget). Clean the revenue & budget so that it becomes easy to compare the profit each movie did (Hint: both of them must be in the same currency and in the same unit (thousand/million/billion etc) to compute the profit.)

-- Print movie_id, budget_adj, revenue_adj & profit of each movie using financials table of moviesdb database. Show your result in the descending order of profit.

/*•Print the movie titles, industry and PROFIT. Sort the result in descending order of profit (profit = revenue – budget). 
Clean the revenue & budget so that it becomes easy to compare the profit each movie did (Hint: both of them must be in the same 
currency and in the same unit (thousand/million/billion etc) to compute the profit.) */
select 
    t1.movie_id,
    m.title,
    m.industry,
    -- Compute profit
    (if(f.currency = "USD", t1.revenue_mn * 80, t1.revenue_mn) - 
     if(f.currency = "USD", t1.budget_mn * 80, t1.budget_mn)) as profit_inr_mn
from (
    select 
        movie_id,
        case 
            when unit = 'Billions' then budget * 1000
            when unit = 'Thousands' then budget / 1000
            else budget
        end as budget_mn,
        case 
            when unit = 'Billions' then revenue * 1000
            when unit = 'Thousands' then revenue / 1000
            else revenue
        end as revenue_mn
    from financials
) t1
join financials f on t1.movie_id = f.movie_id
join movies m on f.movie_id = m.movie_id
order by profit_inr_mn desc;

USE HR;
/*Find Top 3 Highest-Paid Employees 
Question: Write a query to find the emp_id, first_name, last_name, and salary of the top 3 highest-paid employees in the company.*/
SELECT EMPLOYEE_ID , FIRST_NAME , LAST_NAME , SALARY 
 FROM EMPLOYEES ORDER BY SALARY DESC LIMIT 3; 

/* 
Find Department-wise Top Earners 
Question: Write a query to find the emp_id, first_name, last_name, and salary of the top 3 highest-paid employees 
in each department. Return department_id, department_name, employee_id, first_name, last_name, and salary columns
*/

 select e1.first_name, e1.last_name, e1.salary, e1.department_id, count(e2.salary)
from employees e1
join employees e2
on e1.department_id = e2.department_id and e1.salary <= e2.salary
group by e1.first_name, e1.last_name, e1.salary, e1.department_id
having count(e2.salary) <= 3
order by e1.department_id, count(e2.salary);
 
 /* Employees with the Same Job as a Specific Employee
Question: Write a query to find the emp_id, first_name, and last_name of employees who have the same job_id as the employee with emp_id = 101.*/ 
SELECT * FROM EMPLOYEES ;
SELECT * FROM EMPLOYEES WHERE JOB_ID = (SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 101);

USE HR2;
/* Find Employees Who Earn More Than Their Manager
Question: Write a query to find the emp_id, first_name, last_name, salary, and manager_id of employees whose salary is greater than their manager's salary.*/
SELECT E1.* FROM EMPLOYEES E1 
JOIN EMPLOYEES E2 ON (E1.MANAGER_ID = E2.EMPLOYEE_ID )
WHERE E1.SALARY > E2.SALARY;

/* From moviesdb database print names of all the actors who are of age from 70 to 85 (including both). Use CTE method instead of subquery if needed.
From moviesdb database print names of all the actors who are of age from 70 to 85 (including both). Use CTE method instead of subquery if needed. Also print the number of movies they have played roles 
in.*/
USE MOVIESDB;
SELECT * FROM MOVIE_ACTOR;

SELECT * FROM ACTORS;
WITH A AS( SELECT ACTOR_ID,YEAR(current_date())-BIRTH_YEAR AS AGE FROM ACTORS)
SELECT NAME , ACTOR_ID  , COUNT(*) "" FROM ACTORS JOIN A USING  (ACTOR_ID) RIGHT JOIN MOVIE_ACTOR ON (ACTOR_ID)
WHERE A.AGE BETWEEN  70 AND 85 GROUP BY  (SELECT COUNT(MOVIE_ID) "COUNT_OF_MOVIE" FROM MOVIE_ACTOR GROUP BY ACTOR_ID );

/* Print the movies which produced 500% profit despite of having lower ratings than the average.
Formula to find percentage profit is: (Revenue – Budget) * 100 / Budget.
Use subquery if needed.*/


WITH A AS
(SELECT MOVIE_ID,  ROUND((Revenue - Budget) * 100 / Budget,2) AS "PROFIT"  FROM FINANCIALS)
SELECT M.TITLE,  A.PROFIT FROM MOVIES M  JOIN A ON (M.MOVIE_ID = A.MOVIE_ID ) 
WHERE A.PROFIT > 500 AND M.IMDB_RATING < (SELECT AVG(IMDB_RATING) FROM MOVIES);


/*Return movie_id, title, studio, industry & profit columns from moviesdb database in descending order of profit. 
Hint: You will need to convert budget and revenue columns into Million INR so that you can compute profit by formula profit = revenue - budget.*/

SELECT 
    f.movie_id,
    m.title,
    m.studio,
    m.industry,
    ROUND(revenue_adj - budget_adj, 2) AS profit
FROM (
    SELECT 
        movie_id,
        -- Convert budget to INR millions
        IF(currency = 'USD', budget_mn * 80, budget_mn) AS budget_adj,
        -- Convert revenue to INR millions
        IF(currency = 'USD', revenue_mn * 80, revenue_mn) AS revenue_adj
    FROM (
        SELECT 
            movie_id,
            currency,
            -- Normalize budget to millions
            CASE 
                WHEN unit = 'Billions' THEN budget * 1000
                WHEN unit = 'Thousands' THEN budget / 1000
                ELSE budget
            END AS budget_mn,
            -- Normalize revenue to millions
            CASE 
                WHEN unit = 'Billions' THEN revenue * 1000
                WHEN unit = 'Thousands' THEN revenue / 1000
                ELSE revenue
            END AS revenue_mn
        FROM financials
    ) AS f1
) AS f
JOIN movies m ON f.movie_id = m.movie_id
ORDER BY profit DESC;
