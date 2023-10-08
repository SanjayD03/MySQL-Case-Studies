/*----------------------------- Create a Database----------------------------------------------*/

CREATE DATABASE Burger_Bash;

/*----------------------------- Use a Specific Database------------------------------------------*/

USE Burger_Bash;

/*----------------------------- Creating a Table for Dataset-1:------------------------------------*/

DROP TABLE IF EXISTS burger_names;
CREATE TABLE burger_names(
   burger_id   INTEGER  NOT NULL PRIMARY KEY 
  ,burger_name VARCHAR(10) NOT NULL
);
INSERT INTO burger_names(burger_id,burger_name) VALUES (1,'Meatlovers');
INSERT INTO burger_names(burger_id,burger_name) VALUES (2,'Vegetarian');

/*---------------- To fetch all the data stored in the Specific table(burger_names):-------------------*/

SELECT*FROM burger_names;

/*--------------------------- ----creating a Table for Dataset-2-------------------------------*/

DROP TABLE IF EXISTS burger_runner;
CREATE TABLE burger_runner(
   runner_id   INTEGER  NOT NULL PRIMARY KEY 
  ,registration_date date NOT NULL
);
INSERT INTO burger_runner VALUES (1,'2021-01-01');
INSERT INTO burger_runner VALUES (2,'2021-01-03');
INSERT INTO burger_runner VALUES (3,'2021-01-08');
INSERT INTO burger_runner VALUES (4,'2021-01-15');

/*---------------- To fetch all the data stored in the Specific table(burger_runner):-------------------*/

SELECT*FROM burger_runner;

/*--------------------------- ----creating a Table for Dataset-3-------------------------------*/

DROP TABLE IF EXISTS runner_orders;
CREATE TABLE runner_orders(
   order_id     INTEGER  NOT NULL PRIMARY KEY 
  ,runner_id    INTEGER  NOT NULL
  ,pickup_time  timestamp
  ,distance     VARCHAR(7)
  ,duration     VARCHAR(10)
  ,cancellation VARCHAR(23)
);
INSERT INTO runner_orders VALUES (1,1,'2021-01-01 18:15:34','20km','32 minutes',NULL);
INSERT INTO runner_orders VALUES (2,1,'2021-01-01 19:10:54','20km','27 minutes',NULL);
INSERT INTO runner_orders VALUES (3,1,'2021-01-03 00:12:37','13.4km','20 mins',NULL);
INSERT INTO runner_orders VALUES (4,2,'2021-01-04 13:53:03','23.4','40',NULL);
INSERT INTO runner_orders VALUES (5,3,'2021-01-08 21:10:57','10','15',NULL);
INSERT INTO runner_orders VALUES (6,3,NULL,NULL,NULL,'Restaurant Cancellation');
INSERT INTO runner_orders VALUES (7,2,'2021-01-08 21:30:45','25km','25mins',NULL);
INSERT INTO runner_orders VALUES (8,2,'2021-01-10 00:15:02','23.4 km','15 minute',NULL);
INSERT INTO runner_orders VALUES (9,2,NULL,NULL,NULL,'Customer Cancellation');
INSERT INTO runner_orders VALUES (10,1,'2021-01-11 18:50:20','10km','10minutes',NULL);

/*---------------- To fetch all the data stored in the Specific table(runner_orders):-------------------*/

SELECT*FROM runner_orders;

/*--------------------------- ----creating a Table for Dataset-4-------------------------------*/

DROP TABLE IF EXISTS customer_orders;
CREATE TABLE customer_orders(
   order_id    INTEGER  NOT NULL 
  ,customer_id INTEGER  NOT NULL
  ,burger_id    INTEGER  NOT NULL
  ,exclusions  VARCHAR(4)
  ,extras      VARCHAR(4)
  ,order_time  timestamp NOT NULL
);
INSERT INTO customer_orders VALUES (1,101,1,NULL,NULL,'2021-01-01 18:05:02');
INSERT INTO customer_orders VALUES (2,101,1,NULL,NULL,'2021-01-01 19:00:52');
INSERT INTO customer_orders VALUES (3,102,1,NULL,NULL,'2021-01-02 23:51:23');
INSERT INTO customer_orders VALUES (3,102,2,NULL,NULL,'2021-01-02 23:51:23');
INSERT INTO customer_orders VALUES (4,103,1,'4',NULL,'2021-01-04 13:23:46');
INSERT INTO customer_orders VALUES (4,103,1,'4',NULL,'2021-01-04 13:23:46');
INSERT INTO customer_orders VALUES (4,103,2,'4',NULL,'2021-01-04 13:23:46');
INSERT INTO customer_orders VALUES (5,104,1,NULL,'1','2021-01-08 21:00:29');
INSERT INTO customer_orders VALUES (6,101,2,NULL,NULL,'2021-01-08 21:03:13');
INSERT INTO customer_orders VALUES (7,105,2,NULL,'1','2021-01-08 21:20:29');
INSERT INTO customer_orders VALUES (8,102,1,NULL,NULL,'2021-01-09 23:54:33');
INSERT INTO customer_orders VALUES (9,103,1,'4','1, 5','2021-01-10 11:22:59');
INSERT INTO customer_orders VALUES (10,104,1,NULL,NULL,'2021-01-11 18:34:49');
INSERT INTO customer_orders VALUES (10,104,1,'2, 6','1, 4','2021-01-11 18:34:49');

/*---------------- To fetch all the data stored in the Specific table(customer_orders):-------------------*/

SELECT*FROM customer_orders;

/*------------------- To Retrieve the list of tables in the database.--------------------------*/
-- To Retrieve the list of tables in the database.
SHOW TABLES;        -- It allows you to view the names of all the tables stored within a specific database.


/*---------------------------------------- QUESTIONS.------------------------------------------*/
/*1.  How many burgers were ordered?
2.  How many unique customer orders were made?
3.  How many successful orders were delivered by each runner?
4.  How many of each type of burger was delivered?
5.  How many Vegetarian and Meatlovers were ordered by each customer?
6.  What was the maximum number of burgers delivered in a single order?
7.  For each customer, how many delivered burgers had at least 1 change and how many had no changes?
8.  What was the total volume of burgers ordered for each hour of the day?
9.  How many runners signed up for each 1 week period? 
10.What was the average distance travelled for each customer?*/

/*---------------------------------------- SOLUTIONS------------------------------------------*/
# 1.  How many burgers were ordered?
SELECT COUNT(*) as 'Number of orders' FROM runner_orders;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 2.  How many unique customer orders were made?
SELECT COUNT(DISTINCT order_id) AS 'Unique order count'
FROM customer_orders;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 3.  How many successful orders were delivered by each runner?
SELECT runner_id, COUNT(DISTINCT order_id) AS 'Successful Orders'
FROM runner_orders
WHERE cancellation IS NULL
GROUP BY runner_id
ORDER BY 'Successful Orders' DESC;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 4.  How many of each type of burger was delivered?
SELECT p.burger_name AS 'Burger type (Veg/Non-Veg)', COUNT(c.burger_id) AS 'Burger count delivered'
FROM customer_orders AS c
JOIN runner_orders AS r
 ON c.order_id = r.order_id
JOIN burger_names AS p
 ON c.burger_id = p.burger_id
WHERE r.distance != 0
GROUP BY 1;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 5.  How many Vegetarian and Meatlovers were ordered by each customer?
SELECT c.customer_id, p.burger_name AS 'Burger type (Veg/Non-Veg)',COUNT(p.burger_name) AS 'Order Count'
FROM customer_orders AS c
JOIN burger_names AS p
 ON c.burger_id= p.burger_id
GROUP BY c.customer_id, p.burger_name
ORDER BY 1;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 6.  What was the maximum number of burgers delivered in a single order?
WITH burger_count_cte AS
(
 SELECT c.order_id, COUNT(c.burger_id) AS burger_per_order
 FROM customer_orders AS c
 JOIN runner_orders AS r
  ON c.order_id = r.order_id
 WHERE r.distance != 0
 GROUP BY c.order_id
)
SELECT MAX(burger_per_order) AS burger_count
FROM burger_count_cte;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 7.  For each customer, how many delivered burgers had at least 1 change and how many had no changes?
SELECT c.customer_id,
 SUM(CASE 
  WHEN c.exclusions <> ' ' OR c.extras <> ' ' THEN 1
  ELSE 0
  END) AS 'Atleast one change',
 SUM(CASE 
  WHEN c.exclusions = ' ' AND c.extras = ' ' THEN 1 
  ELSE 0
  END) AS 'No change'
FROM customer_orders AS c
JOIN runner_orders AS r
 ON c.order_id = r.order_id
WHERE r.distance != 0
GROUP BY c.customer_id
ORDER BY c.customer_id;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 8.  What was the total volume of burgers ordered for each hour of the day?
SELECT EXTRACT(HOUR from order_time) AS 'Hour of day', 
 COUNT(order_id) AS 'Total burger count'
FROM customer_orders
GROUP BY EXTRACT(HOUR from order_time);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 9.  How many runners signed up for each 1 week period? 
SELECT EXTRACT(WEEK from registration_date) AS 'registration week',
 COUNT(runner_id) AS 'runner signuped'
FROM burger_runner
GROUP BY EXTRACT(WEEK from registration_date);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 10. What was the average distance travelled for each customer?
SELECT c.customer_id, ROUND(AVG(r.distance),2) AS 'Average distance'
FROM customer_orders AS c
JOIN runner_orders AS r
 ON c.order_id = r.order_id
WHERE r.duration != 0
GROUP BY c.customer_id;