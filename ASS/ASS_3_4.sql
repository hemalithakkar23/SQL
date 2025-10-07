-- ASS3
-- Q1

USE PRACTICE;
Create table If Not Exists ActorDirector (actor_id int, director_id int, timestamp int); 
Truncate table ActorDirector; 
insert into ActorDirector (actor_id, director_id, timestamp) values ('1', '1', '0'); 
insert into ActorDirector (actor_id, director_id, timestamp) values ('1', '1', '1'); 
insert into ActorDirector (actor_id, director_id, timestamp) values ('1', '1', '2'); 
insert into ActorDirector (actor_id, director_id, timestamp) values ('1', '2', '3'); 
insert into ActorDirector (actor_id, director_id, timestamp) values ('1', '2', '4'); 
insert into ActorDirector (actor_id, director_id, timestamp) values ('2', '1', '5'); 
insert into ActorDirector (actor_id, director_id, timestamp) values ('2', '1', '6');

SELECT * FROM ACTORDIRECTOR;
/*Write a query for a report that provides the pairs (actor_id, director_id) where the actor has 
cooperated with the director at least three times. 
• Return the result table ordered by actor_id in ascending manner*/
SELECT ACTOR_ID , DIRECTOR_ID FROM ACTORDIRECTOR group by actor_id, director_id HAVING COUNT(*)>=3 ORDER BY ACTOR_ID ASC ; 

-- Q2 
/*Problem Statement: 
Write a query to find the average salary of the employees for each department. 
• Save the new average salary as 'Average_salary'. 
• Return the columns 'department_id', 'department_name', and 'Average_salary'. 
• Return the result ordered by department_id in ascending order.*/
USE HR;
SELECT D.DEPARTMENT_ID , D.DEPARTMENT_NAME , 
	ROUND(AVG(E.SALARY)) AS "AVERAGE_SALARY" 
FROM EMPLOYEES E JOIN DEPARTMENTS D USING(DEPARTMENT_ID)
GROUP BY E.DEPARTMENT_ID 
ORDER BY 1 ASC;

/* Problem Statement: 
Write a query to display the count of employees as 'No_of_Employees' and, the total salary paid to 
employees as 'Total_Salary' for each department. 
• Return the columns 'department_name', 'No_of_Employees', and 'Total_Salary'. 
• Return the output ordered by department_name in ascending order. 
Note: 
• If there are no employees in the department return the No_of_Employees as 0 and Total_Salary 
as NULL. */

SELECT D.DEPARTMENT_NAME , 
COUNT(E.EMPLOYEE_ID)  AS 'No_of_Employees' , 
SUM(E.SALARY) AS  'Total_Salary' 
FROM EMPLOYEES E RIGHT JOIN 
DEPARTMENTS D ON (D.DEPARTMENT_ID = E.DEPARTMENT_ID)
GROUP BY D.DEPARTMENT_NAME 
ORDER BY D.DEPARTMENT_NAME ;

/* 
Problem Statement: 
Write a query to find details of the employees who work in the 'Human Resources' department. 
• Return the columns 'employee_id', 'department_id', 'first_name', 'last_name', 'job_id', and 
'department_name'. 
• Return the result ordered by employee_id in ascending order. 
Dataset Description is the same as previous question*/

SELECT E.EMPLOYEE_ID , D.DEPARTMENT_ID , E.FIRST_NAME , E.LAST_NAME ,
	E.JOB_ID , D.DEPARTMENT_NAME 
FROM DEPARTMENTS D JOIN 
	EMPLOYEES E ON (D.DEPARTMENT_ID = E.DEPARTMENT_ID) 
WHERE UPPER(D.DEPARTMENT_NAME) = 'Human Resources'
ORDER BY  E.EMPLOYEE_ID ASC ;

USE PRACTICE;
Create table If Not Exists Sales (sale_id int, product_id int, year int, quantity int, price int); 
Create table If Not Exists Product (product_id int, product_name varchar(10)); 
Truncate table Sales; 
insert into Sales (sale_id, product_id, year, quantity, price) values ('1', '100', '2008', '10', '5000'); 
insert into Sales (sale_id, product_id, year, quantity, price) values ('2', '100', '2009', '12', '5000'); 
insert into Sales (sale_id, product_id, year, quantity, price) values ('7', '200', '2011', '15', '9000'); 
Truncate table Product; 
insert into Product (product_id, product_name) values ('100', 'Nokia'); 
insert into Product (product_id, product_name) values ('200', 'Apple'); 
insert into Product (product_id, product_name) values ('300', 'Samsung');

/* Q5 Product Sales I 
Write a SQL query that reports the product_name, year, and price for each sale_id in the sales table. 
• Return the result table ordered by year and product_name in ascending order. */
SELECT  PRODUCT_NAME , YEAR , PRICE  
	FROM SALES JOIN PRODUCT USING (PRODUCT_ID)
GROUP BY SALE_ID 
ORDER BY YEAR ,PRODUCT_NAME ;

-- Q6 Products Recommendation 
create database product_recommendation; 
use product_recommendation; 
Create table If Not Exists customers (customer_id int, customer_name varchar(255)); 
Truncate table customers; 
insert into customers (customer_id, customer_name) values ('1', 'Andrew'); 
insert into customers (customer_id, customer_name) values ('2', 'Erin'); 
insert into customers (customer_id, customer_name) values ('3', 'Stanley'); 
Create table If Not Exists orders (order_id int, customer_id int, product_name 
varchar(255)); 
Truncate table orders; 
insert into orders (order_id, customer_id, product_name) values ('10', '1', 'Bread'); 
insert into orders (order_id, customer_id, product_name) values ('20', '1', 'Milk'); 
insert into orders (order_id, customer_id, product_name) values ('30', '1', 'Butter'); 
insert into orders (order_id, customer_id, product_name) values ('40', '1', 'Eggs'); 
insert into orders (order_id, customer_id, product_name) values ('50', '2', 'Bread'); 
insert into orders (order_id, customer_id, product_name) values ('60', '2', 'Milk'); 
insert into orders (order_id, customer_id, product_name) values ('70', '3', 'Butter'); 

/* Write a query to find the customer_id and customer_name of customers who bought products 
"Bread" and "Milk" but did not buy the product "Eggs". 
• Return the output ordered by customer_name in ascending order */
SELECT * FROM ORDERS;
SELECT * FROM CUSTOMERS;

SELECT C.CUSTOMER_ID , C.CUSTOMER_NAME , 
	O.PRODUCT_NAME 
 FROM CUSTOMERS C
	LEFT JOIN ORDERS O ON (O.CUSTOMER_ID = C.CUSTOMER_ID)
WHERE (UPPER(O.PRODUCT_NAME) = 'MILK' AND UPPER(O.PRODUCT_NAME) = 'BREAD')  AND UPPER(O.PRODUCT_NAME) <> 'EGGS' 
	ORDER BY  CUSTOMER_NAME ASC;
    
    
/* Q7. Europe 
Problem Statement: 
Write a query to display the details of the employees who belong to the 'Europe' region. 
Note: 
• Return the columns 'employee_id', 'full_name' (first_name and last_name separated by 
space), 'salary', 'phone_number', 'department_id', 'department_name', 'street_address', 
'city', 'country_name', 'region_id', 'region_name'. 
• Return the result ordered by salary in descending order and by employee_id in ascending 
order. */

USE HR;
SELECT E.EMPLOYEE_ID 'employee_id' , CONCAT (E.FIRST_NAME , ' ' , E.LAST_NAME) 'full_name' , E.SALARY 'salary' , E.PHONE_NUMBER 'phone_num', D.DEPARTMENT_ID 'D_ID' , D.DEPARTMENT_NAME 'DEP_NAME' , 
L.STREET_ADDRESS 'STR_ADD' , L.CITY 'city' ,
C.COUNTRY_NAME 'country_name' , 
R.REGION_ID 'region_id' , R.REGION_NAME 'region_name'
FROM EMPLOYEES E 
JOIN DEPARTMENTS D ON (D.DEPARTMENT_ID = E.DEPARTMENT_ID )
JOIN LOCATIONS L ON (L.LOCATION_ID = D.LOCATION_ID )
JOIN COUNTRIES C ON (C.COUNTRY_ID = L.COUNTRY_ID) 
JOIN REGIONS R ON (R.REGION_ID = C.REGION_ID) 
WHERE R.REGION_NAME = 'Europe'
ORDER BY E.SALARY DESC , E.EMPLOYEE_ID ASC;
 


SELECT * FROM EMPLOYEES;

SELECT * FROM LOCATIONS;
SELECT * FROM COUNTRIES ORDER BY 2;
SELECT * FROM REGIONS;



-- ASS 4
create database friendly_movies; 
use friendly_movies; 
Create table If Not Exists Content (content_id int, title varchar(255), 
Kids_content enum('Y', 'N'), content_type varchar(255)); 
Truncate table Content; 
insert into Content (content_id, title, Kids_content, content_type) values 
('1', 'LC Movie', 'N', 'Movies'); 
insert into Content (content_id, title, Kids_content, content_type) values 
('2', 'Alg. for Kids', 'Y', 'Series'); 
insert into Content (content_id, title, Kids_content, content_type) values 
('3', 'Database Sols', 'N', 'Series'); 
insert into Content (content_id, title, Kids_content, content_type) values 
('4', 'Aladdin', 'Y', 'Movies'); 
insert into Content (content_id, title, Kids_content, content_type) values 
('5', 'Cinderella', 'Y', 'Movies'); 
Create table If Not Exists TVProgram (program_date datetime, content_id 
int, channel varchar(255)); 
Truncate table TVProgram; 
insert into TVProgram (program_date, content_id, channel) values ('2020
06-10 08:00:00', '1', 'LC-Channel'); 
insert into TVProgram (program_date, content_id, channel) values ('2020
05-11 12:00:00', '2', 'LC-Channel'); 
insert into TVProgram (program_date, content_id, channel) values ('2020
05-12 12:00:00', '3', 'LC-Channel'); 
insert into TVProgram (program_date, content_id, channel) values ('2020
05-13 14:00:00', '4', 'Disney Ch'); 
insert into TVProgram (program_date, content_id, channel) values ('2020
06-18 14:00:00', '4', 'Disney Ch'); 
insert into TVProgram (program_date, content_id, channel) values ('2020
07-15 16:00:00', '5', 'Disney Ch');

SELECT * FROM TVPROGRAM;
SELECT * FROM  Content;


