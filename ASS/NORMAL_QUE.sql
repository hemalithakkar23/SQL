USE DEMO;
SHOW TABLES ;
SELECT * FROM SALES_ORDER;
SELECT * FROM CUSTOMERS ;
SELECT * FROM PRODUCTS;

-- Print the orders which were placed after august 2003 and their deal size is small
SELECT * FROM SALES_ORDER WHERE  ORDER_DATE > "2003-08-31" AND DEAL_SIZE="SMALL";

-- •Print orders which were placed in the last quarter of 2003 and have deal size small
SELECT * FROM SALES_ORDER WHERE (ORDER_DATE BETWEEN "2003-10-01" AND  "2003-12-31") AND  DEAL_SIZE="SMALL";

-- •Print the first and last city (alphabetically) of customers from each country
SELECT MAX(CITY),MIN(CITY) ,  COUNTRY FROM CUSTOMERS  GROUP BY COUNTRY ORDER BY 1;  

-- •Find the minimum & maximum  price for each product line
SELECT PRODUCT_LINE ,MIN(PRICE) , MAX(PRICE) FROM PRODUCTS GROUP BY PRODUCT_LINE;

-- •Print all the orders made from the country “USA”. Use  sales_order & customers tables from Demo database. Return order_number, order_date & deal_size columns in descending order of order_date.
 SELECT  order_number, order_date , deal_size 
 FROM CUSTOMERS C LEFT JOIN sales_order S ON (C.CUSTOMER_ID = S.CUSTOMER)
 WHERE COUNTRY = 'USA'
 ORDER BY 2 DESC;
 
 -- Get me the customers who are not from USA and their status is "In Process"
 -- •Print the names of the actors who did not play role in any movie (Use moviesdb database)
 -- •Print the names of the departments in which no employee is working (Use hr2 database)
 

                           
                                                                                                                                                                                            