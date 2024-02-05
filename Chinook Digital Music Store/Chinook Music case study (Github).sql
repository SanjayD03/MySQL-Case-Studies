/*----------------------------- Database Creation------------------------------------------------*/

CREATE DATABASE Chinook;

/*----------------------------- Use a Specific Database------------------------------------------*/
USE Chinook;

/*------------------------ To fetch all the data stored in the Tables---------------------------*/

-- Tables
select * from Album; -- 347
select * from Artist; -- 275
select * from Customer; -- 59
select * from Employee; -- 8
select * from Genre; -- 25
select * from Invoice; -- 412
select * from InvoiceLine; -- 2240
select * from MediaType; -- 5
select * from Playlist; -- 18
select * from PlaylistTrack; -- 8715
select * from Track; -- 3503



/*-------------------------------------Questions-------------------------------------------------------*/


-- Using SQL solve the following problems using the chinook database.
-- 1) Find the artist who has contributed with the maximum no of albums. Display the artist name and the no of albums.
-- Find the artist who has contributed with the maximum number of albums.
-- Display the artist name and the number of albums.

-- Solution 1
SELECT TOP 1 a.artistid, a.name, COUNT(*) AS total_albums
FROM artist a
JOIN album ab ON a.artistid = ab.artistid
GROUP BY a.artistid, a.name
ORDER BY total_albums DESC;

-- Solution 2
-- Using a CTE to achieve the same result as Solution 1.
WITH temp AS (
    SELECT alb.artistid, COUNT(1) AS no_of_albums,
    RANK() OVER (ORDER BY COUNT(1) DESC) AS rnk
    FROM Album alb
    GROUP BY alb.artistid
)
SELECT art.name AS artist_name, t.no_of_albums
FROM temp t
JOIN artist art ON art.artistid = t.artistid
WHERE rnk = 1;

-- 2) Display the name, email id, and country of all listeners who love Jazz, Rock, and Pop music.
SELECT CONCAT(c.firstname, ' ', c.lastname) AS full_name, c.email, c.country
FROM customer c 
JOIN invoice i ON c.customerid = i.customerid
JOIN invoiceline il ON i.invoiceid = il.invoiceid
JOIN track t ON il.trackid = t.trackid
JOIN genre g ON t.genreid = g.genreid
WHERE g.name IN ('Jazz', 'Rock', 'Pop');

-- 3) Find the employee who has supported the most number of customers.
-- Display the employee name and designation.
SELECT TOP 1 CONCAT(e.firstname, ' ', e.lastname) AS full_name, e.title AS designation, COUNT(*) AS no_of_customers
FROM employee e 
JOIN customer c ON e.employeeid = c.supportrepid
GROUP BY CONCAT(e.firstname, ' ', e.lastname), e.title 
ORDER BY no_of_customers DESC;

-- 4) Which city corresponds to the best customers?
SELECT TOP 1 c.city, SUM(i.total) AS total_purchase_amount
FROM customer c 
JOIN invoice i ON c.customerid = i.customerid
GROUP BY c.city
ORDER BY total_purchase_amount DESC;

-- 5) The highest number of invoices belongs to which country?
SELECT TOP 1 billingcountry AS country, COUNT(*) AS no_of_invoices
FROM invoice
GROUP BY billingcountry
ORDER BY no_of_invoices DESC;

-- 6) Name the best customer (customer who spent the most money).
SELECT TOP 1 CONCAT(c.firstname, ' ', c.LastName) AS full_name, SUM(i.total) AS total_amount
FROM customer c 
JOIN invoice i ON c.CustomerId = i.CustomerId
GROUP BY CONCAT(c.firstname, ' ', c.LastName)
ORDER BY total_amount DESC;

-- 7) Identify the location for hosting a rock concert based on the city with the most rock music listeners.
WITH cte AS (
    SELECT c.city, COUNT(*) AS total_customers,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk
    FROM customer c 
    JOIN invoice i ON c.customerid = i.customerid
    JOIN invoiceline il ON il.invoiceid = i.invoiceid
    JOIN track t ON t.trackid = il.trackid
    JOIN genre g ON g.genreid = t.genreid
    WHERE g.name = 'Rock'
    GROUP BY c.city
)
SELECT city, total_customers
FROM cte 
WHERE rnk = 1;

-- 8) Identify albums with less than 5 tracks and display album name, artist name, and the number of tracks.
SELECT ab.Title AS album_name, a.Name AS artist_name, COUNT(*) AS no_of_tracks
FROM track t 
JOIN album ab ON t.AlbumId = ab.AlbumId
JOIN artist a ON a.ArtistId = ab.ArtistId
GROUP BY ab.Title, a.Name
HAVING COUNT(*) < 5
ORDER BY no_of_tracks DESC;

-- 9) Display tracks, albums, artists, and genres for all tracks which are not purchased.
-- Two different solutions provided.
-- Solution 1
SELECT t.Name, ab.Title, a.Name, g.Name
FROM Artist a
JOIN album ab ON a.ArtistId = ab.ArtistId
JOIN track t ON t.AlbumId = ab.AlbumId
JOIN genre g ON g.GenreId = t.GenreId
WHERE t.TrackId NOT IN (SELECT TrackId FROM InvoiceLine);

-- Solution 2
SELECT t.name AS track_name, al.title AS album_title, art.name AS artist_name, g.name AS genre
FROM Track t
JOIN album al ON al.albumid = t.albumid
JOIN artist art ON art.artistid = al.artistid
JOIN genre g ON g.genreid = t.genreid
WHERE NOT EXISTS (
    SELECT 1
    FROM InvoiceLine il
    WHERE il.trackid = t.trackid
);

-- 10) Find artists who have performed in multiple genres. Display the artist name and the genre.
WITH Cte AS (
    SELECT DISTINCT art.name AS artist_name, g.name AS genre
    FROM Track t
    JOIN album al ON al.albumid = t.albumid
    JOIN artist art ON art.artistid = al.artistid
    JOIN genre g ON g.genreid = t.genreid
), final_artist AS (
    SELECT artist_name
    FROM Cte t
    GROUP BY artist_name
    HAVING COUNT(1) > 1
)
SELECT t.*
FROM Cte t
JOIN final_artist fa ON fa.artist_name = t.artist_name
ORDER BY artist_name, genre;

-- 11) Identify the most and least popular genre based on the number of songs.
WITH temp AS (
    SELECT g.name AS genre, COUNT(1) AS no_of_songs,
    RANK() OVER (ORDER BY COUNT(1) DESC) AS rnk
    FROM InvoiceLine il
    JOIN track t ON t.trackid = il.trackid
    JOIN genre g ON g.genreid = t.genreid
    GROUP BY g.name
), max_rank AS (
    SELECT MAX(rnk) AS max_rnk FROM temp
)
SELECT genre, no_of_songs,
CASE WHEN rnk = 1 THEN 'Most Popular' ELSE 'Least Popular' END AS Popular_Flag
FROM temp
INNER JOIN max_rank ON rnk = max_rnk OR rnk = 1;

-- 12) Identify tracks that are more expensive than others. Display track name, album title, and artist name.
SELECT t.name AS track_name, ab.Title AS album_title, a.Name AS artist_name
FROM Artist a 
JOIN album ab ON a.ArtistId = ab.ArtistId
JOIN track t ON t.AlbumId = ab.AlbumId
WHERE t.UnitPrice > (SELECT MIN(UnitPrice) FROM track);

-- 13) Identify the 5 most popular artists for the most popular genre.
-- Popularity is based on the number of songs an artist has performed in for the particular genre.
WITH most_popular_genre AS (
    SELECT name AS genre
    FROM (
        SELECT g.name, COUNT(*) AS no_of_purchases, RANK() OVER (ORDER BY COUNT(1) DESC) AS rnk
        FROM InvoiceLine il
        JOIN track t ON t.trackid = il.trackid
        JOIN genre g ON g.genreid = t.genreid
        GROUP BY g.name
    ) x
    WHERE rnk = 1
), all_data AS (
    SELECT a.name AS artist_name, COUNT(*) AS no_of_songs,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk
    FROM track t
    JOIN album ab ON ab.albumid = t.albumid
    JOIN artist a ON a.artistid = ab.artistid
    JOIN genre g ON g.genreid = t.genreid
    WHERE g.name IN (SELECT genre FROM most_popular_genre)
    GROUP BY a.name
)
SELECT artist_name, no_of_songs
FROM all_data
WHERE rnk <= 5;

-- 14) Find the artist who has contributed the maximum number of songs/tracks.
-- Display the artist name and the number of songs.
-- Two different solutions provided.
-- Solution 1
SELECT TOP 1 a.name, COUNT(*) AS no_of_songs
FROM Artist a 
JOIN album ab ON a.ArtistId = ab.ArtistId
JOIN track t ON t.AlbumId  = ab.AlbumId
GROUP BY a.name
ORDER BY no_of_songs DESC;

-- Solution 2
SELECT Artist_name, no_of_songs
FROM (
    SELECT a.name AS Artist_name, COUNT(*) AS no_of_songs,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk
    FROM Track t
    JOIN album ab ON ab.albumid = t.albumid
    JOIN artist a ON a.artistid = ab.artistid
    GROUP BY a.name
) x
WHERE x.rnk = 1;

-- 15) Identify if there are albums owned by multiple artists.
SELECT albumid, COUNT(*) AS no_of_albums 
FROM Album 
GROUP BY albumid 
HAVING COUNT(*) > 1;

-- 16) Check for any invoice issued to a non-existing customer.
SELECT * FROM Invoice
WHERE InvoiceId NOT IN (SELECT InvoiceId FROM invoice);

-- 17) Check for any invoice line for a non-existing invoice.
SELECT * FROM InvoiceLine IL
WHERE NOT EXISTS (SELECT * FROM Invoice I WHERE I.invoiceid = IL.invoiceid);

-- 18) Check for albums without a title.
SELECT * 
FROM Album
WHERE title IS NULL;

-- 19) Check for invalid tracks in the playlist.
SELECT * 
FROM PlaylistTrack pt
WHERE NOT EXISTS (SELECT * FROM Track t WHERE t.trackid = pt.trackid);
