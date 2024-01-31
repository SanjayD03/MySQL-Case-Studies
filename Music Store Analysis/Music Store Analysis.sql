/*----------------------------- Database Creation------------------------------------------------*/

CREATE DATABASE music_store_analysis;

/*----------------------------- Use a Specific Database------------------------------------------*/
USE music_store_analysis;

/*------------------------ To fetch all the data stored in the Tables---------------------------*/
SELECT * FROM album;
SELECT * FROM artist;
SELECT * FROM customer;
SELECT * FROM employee;
SELECT * FROM genre;
SELECT * FROM invoice;
SELECT * FROM invoice_line;
SELECT * FROM media_type;
SELECT * FROM playlist;
SELECT * FROM playlist_track;
SELECT * FROM track;

/*-------------------- SQL PROJECT- MUSIC STORE DATA ANALYSIS----------------------------------*/

/*---------------------------------------- QUESTIONS.------------------------------------------*/
-- Question Set 1 - Easy

/*1. Who is the senior most employee based on job title?
  2. Which countries have the most Invoices?
  3. What are the top 3 values of total invoice?
  4. Which city has the best customers? 
  5. Who is the best customer? */

-- Question Set 2 – Moderate

/*1. Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
	--Return your list ordered alphabetically by email starting with A.
  2. Let's invite the artists who have written the most rock music in our dataset. 
	--Write a query that returns the Artist name and total track count of the top 10 rock bands
  3. Return all the track names that have a song length longer than the average song length. 
	--Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first */

-- Question Set 3 – Advanced

/*1. Find how much amount spent by each customer on artists? 
	--Write a query to return customer name, artist name and total spent
  2. We want to find out the most popular music Genre for each country. 
	--We determine the most popular genre as the genre with the highest amount of purchases. 
	--Write a query that returns each country along with the top Genre. 
	--For countries where the maximum number of purchases is shared, return all Genres
  3. Write a query that determines the customer that has spent the most on music for each country. 
	--Write a query that returns the country along with the top customer and how much they spent. 
	--For countries where the top amount spent is shared, provide all customers who spent this amount*/


/*----------------------------------------- SOLUTIONS--------------------------------------------*/

-- Question Set 1 - Easy
-- 1. Who is the senior most employee based on job title?
SELECT TOP 1 CONCAT(first_name,' ',last_name) AS full_name, title
FROM employee
ORDER BY levels DESC;

-- 2. Which countries have the most Invoices?
SELECT billing_country, COUNT(DISTINCT(invoice_id)) AS total_invoices
FROM invoice
GROUP BY billing_country
ORDER BY total_invoices DESC;

-- 3. What are the top 3 values of total invoice?
SELECT TOP 3 invoice_id, ROUND(total ,2) AS total
FROM invoice
ORDER BY total DESC;

-- 4. Which city has the best customers? 
-- Write a query that returns one city that has the highest sum of invoice totals. 
-- Return both the city name & sum of all invoice totals 
SELECT TOP 1 billing_city, ROUND(SUM(total), 2) AS invoice_total
FROM invoice
GROUP BY billing_city
ORDER BY invoice_total DESC;

-- 5. Who is the best customer? 
-- Write a query that returns the person who has spent the most money
SELECT TOP 1 c.customer_id, CONCAT(c.first_name,'',c.last_name) AS full_name, ROUND(SUM(total),2) AS total_amount_spent
FROM customer c 
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id, CONCAT(c.first_name,'',c.last_name)
ORDER BY total_amount_spent DESC;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Question Set 2 – Moderate

-- 1. Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
-- Return your list ordered alphabetically by email starting with A
SELECT DISTINCT c.first_name, c.last_name, c.email, g.name
FROM customer c 
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Rock' AND c.email LIKE 'A%'
ORDER BY email;

-- 2. Let's invite the artists who have written the most rock music in our dataset. 
-- Write a query that returns the Artist name and total track count of the top 10 rock bands
SELECT TOP 10 a.artist_id, a.name, COUNT(t.track_id) AS total_track_count
FROM artist a 
JOIN album ab ON a.artist_Id = ab.artist_id
JOIN track t ON t.album_id = ab.album_id
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name  = 'Rock'
GROUP BY a.artist_id, a.name
ORDER BY total_track_count DESC;

-- 3. Return all the track names that have a song length longer than the average song length. 
-- Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first
SELECT name, milliseconds AS Song_length_in_milliseconds
FROM track 
WHERE milliseconds > (SELECT AVG(milliseconds) FROM track)
ORDER BY Song_length_in_milliseconds DESC;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Question Set 3 – Advanced

-- 1. Find how much amount spent by each customer on artists? 
-- Write a query to return customer name, artist name and total spent
SELECT CONCAT(c.first_name,'',c.last_name) AS customer_name, a.name, ROUND(SUM(il.unit_price * quantity),2) AS total_amount_spent
FROM customer c 
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id =il.track_id
JOIN album ab ON ab.album_id = t.album_id
JOIN artist a ON a.artist_id =ab.artist_id
GROUP BY CONCAT(c.first_name,'',c.last_name), a.name
ORDER BY total_amount_spent DESC;

-- 2. We want to find out the most popular music Genre for each country. 
-- We determine the most popular genre as the genre with the highest amount of purchases. 
-- Write a query that returns each country along with the top Genre. 
-- For countries where the maximum number of purchases is shared, return all Genres
WITH popular_genre AS
(
   SELECT c.country, g.name, g.genre_id, COUNT(il.quantity) AS purchases,
      DENSE_RANK() OVER (PARTITION BY c.country ORDER BY COUNT(il.quantity) DESC) AS rnk
   FROM invoice_line il 
   JOIN invoice i ON il.invoice_id = i.invoice_id
   JOIN customer c ON i.customer_id = c.customer_id
   JOIN track t ON t.track_id = il.track_id
   JOIN genre g ON g.genre_id = t.genre_id
   GROUP BY c.country, g.name, g.genre_id
)
SELECT country, name, genre_id, purchases FROM popular_genre
WHERE rnk = 1;

-- 3. Write a query that determines the customer that has spent the most on music for each country. 
-- Write a query that returns the country along with the top customer and how much they spent. 
-- For countries where the top amount spent is shared, provide all customers who spent this amount
WITH Customer_country AS 
(
   SELECT c.customer_id, CONCAT(c.first_name,' ',c.last_name) AS full_name, i.billing_country, ROUND(SUM(i.total),2) AS total_amount_spent,
      RANK() OVER(PARTITION BY i.billing_country ORDER BY SUM(i.total) DESC) AS Rnk
   FROM invoice i 
   JOIN customer c ON c.customer_id = i.customer_id
   GROUP BY c.customer_id, CONCAT(c.first_name,' ',c.last_name), i.billing_country
)
SELECT customer_id, full_name, billing_country, total_amount_spent
FROM Customer_country 
WHERE Rnk = 1
ORDER BY total_amount_spent DESC;