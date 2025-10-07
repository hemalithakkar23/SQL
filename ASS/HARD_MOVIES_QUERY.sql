-- cte
-- 1. Write a query to find the emp_id, first_name, last_name, and salary of employees whose salary is greater than the average salary in the company.
use hr;
select employee_id , first_name , last_name , salary 
from employees where salary > (select avg(salary) from employees);
-- cte 
with e as (
select avg(salary) as 'avg_sal' from employees  )
select employee_id , first_name , last_name , salary 
from employees join e  where salary > e.avg_sal;

select * from employees e1 
cross join (
	select avg(salary) as 'avg_sal' from employees ) as e 
where salary > e.avg_sal;

with e as (
	select avg(salary) as 'avg_sal' from employees  ) 
select * from employees e1 cross join e
where salary > e.avg_sal;

/* Find Highest Salary in Each Department – Question: Write a query to display the department_id, emp_id, first_name, last_name, and salary of employees
 who earn the highest salary in their respective departments.*/
 SELECT * FROM EMPLOYEES E
 JOIN (SELECT DEPARTMENT_ID , MAX(sALARY) AS "MAX_SAL" FROM EMPLOYEES GROUP BY DEPARTMENT_ID) AS A 
 ON (E.DEPARTMENT_ID = A.DEPARTMENT_ID)
 WHERE SALARY = MAX_SAL;
 
WITH A AS (SELECT DEPARTMENT_ID , MAX(sALARY) AS "MAX_SAL" FROM EMPLOYEES GROUP BY DEPARTMENT_ID)
SELECT * FROM EMPLOYEES E JOIN A 
ON (E.DEPARTMENT_ID = A.DEPARTMENT_ID)
 WHERE SALARY = MAX_SAL;
 
 /*
Return movie_id, budget_adj, revenue_adj columns from financial table of moviesdb database where budget_adj and revenue_adj are budget & revenue 
converted into Million INR.
*/USE MOVIESDB;
select movie_id, 
	if(currency = "USD", budget_mn*80, budget_mn) as budget_adj,
	if(currency = "USD", revenue_mn*80, revenue_mn) as revenue_adj
from (
	select movie_id,
		case
			when unit = "Billions" then budget*1000
			when unit = "Thousands" then budget/1000
			else budget
		end as budget_mn,
		case
			when unit = "Billions" then revenue*1000
			when unit = "Thousands" then revenue/1000
			else revenue
		end as revenue_mn,
		currency
	from financials
) as t1;

WITH T1 AS (select movie_id,
		case
			when unit = "Billions" then budget*1000
			when unit = "Thousands" then budget/1000
			else budget
		end as budget_mn,
		case
			when unit = "Billions" then revenue*1000
			when unit = "Thousands" then revenue/1000
			else revenue
		end as revenue_mn,
		currency
	from financials)
    select movie_id, 
	if(currency = "USD", budget_mn*80, budget_mn) as budget_adj,
	if(currency = "USD", revenue_mn*80, revenue_mn) as revenue_adj FROM T1;
    
USE HR2;    
-- List Departments with No Employees – Question: Write a query to find the department_id and department_name of departments that have no employees assigned to them using hr2 database.
SELECT department_id , department_name FROM DEPARTMENTS 
WHERE DEPARTMENT_ID IN (SELECT  DEPARTMENT_ID FROM EMPLOYEES GROUP BY DEPARTMENT_ID HAVING COUNT(EMPLOYEE_ID)=0);


USE CLASSWORK;
SELECT * FROM FACEBOOK_FRIENDS;

/* Find the popularity percentage for each user on Meta/Facebook. 
The popularity percentage is defined as the total number of friends the user has, 
divided by the total number of users on the platform, then converted into a percentage by multiplying by 100. Output each user along with their popularity percentage. 
Order records in ascending order by user id.*/
with t1 as (
	select user1, user2 from facebook_friends
	union
	select user2, user1 from facebook_friends
),
t2 as (
	select user1, count(user2) as friends 
	from t1
	group by user1
	order by user1
)
select distinct user1, round(friends*100/(select count(distinct(user1)) from t1), 2) as popularity_pct
from t2
order by user1;

/* Identify how many cars, motorcycles, trains and ships are available in the inventory. 
Treat all types of cars just as “Cars”. DO NOT USE ‘LIKE’ IN THIS EXAMPLE. (Use ‘demo’ database)*/
USE DEMO;
SHOW TABLES;
SELECT * FROM PRODUCTS;

SELECT distinct(product_line) from products;

select case 
	when product_line in ('Classic Cars' ,'Vintage Cars') then 'cars' else 
,count(*) from products where product_line != ('Trucks and Buses')and  product_line !=( 'Planes') group by product_line;
  
 
use  paintings;
select * from artists;

/*Display all the available paintings and their artists. If a painting was sold then mark them as "Sold".
    and if more than 1 painting of an artist was sold then display a "**" beside their name.*/

