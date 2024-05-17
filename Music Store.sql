CREATE DATABASE MUSIC;
USE MUSIC;
CREATE TABLE IF NOT EXISTS CUSTOMER (
CUSTOMER_ID INT (10) NOT NULL,
FIRST_NAME VARCHAR(30) NOT NULL,
LAST_NAME VARCHAR(30) NOT NULL,
COMPANY VARCHAR(100) NOT NULL,
ADDRESS VARCHAR(100) NOT NULL,
CITY VARCHAR(100) NOT NULL,
STATE VARCHAR(30) NOT NULL,
COUNTRY VARCHAR(100) NOT NULL,
POSTAL_CODE VARCHAR(30) NOT NULL,
PHONE VARCHAR(20) NOT NULL,
FAX VARCHAR(20) NOT NULL,
EMAIL VARCHAR(100) NOT NULL,
SUPPORT_REP_ID INT(50));

LOAD DATA INFILE
'E:/customer.csv'
INTO TABLE CUSTOMER
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM CUSTOMER;

CREATE TABLE IF NOT EXISTS EMPLOYEE (
EMPLOYEE_ID INT(20) NOT NULL,
LAST_NAME VARCHAR(50) NOT NULL,
FIRST_NAME VARCHAR(50) NOT NULL,
TITLE VARCHAR(50) NOT NULL,
REPORTS_TO VARCHAR(20) NOT NULL,
LEVELS VARCHAR(30) NOT NULL,
BIRTHDATE VARCHAR(80) NOT NULL,
HIRE_DATE VARCHAR(80) NOT NULL,
ADDRESS VARCHAR(100) NOT NULL,
CITY VARCHAR(50) NOT NULL,
STATE VARCHAR(20) NOT NULL,
COUNTRY VARCHAR(50) NOT NULL,
POSTAL_CODE VARCHAR(50) NOT NULL,
PHONE VARCHAR(50) NOT NULL,
FAX VARCHAR(50) NOT NULL,
EMAIL VARCHAR(100) NOT NULL);

LOAD DATA INFILE
'E:/employee.csv'
INTO TABLE EMPLOYEE
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM EMPLOYEE;

CREATE TABLE IF NOT EXISTS ALBUM (
ALBUM_ID INT(50) NOT NULL,
TITLE VARCHAR(100) NOT NULL,
ARTIST_ID VARCHAR(50) NOT NULL);

LOAD DATA INFILE
'E:/album.csv'
INTO TABLE ALBUM
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM ALBUM;

CREATE TABLE IF NOT EXISTS GENRE (
GENRE_ID INT(50) NOT NULL,
NAME VARCHAR(100) NOT NULL);

LOAD DATA INFILE
'E:/genre.csv'
INTO TABLE GENRE
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM GENRE;

CREATE TABLE IF NOT EXISTS ARTIST ( /* error 1406 - data too long */
ARTIST_ID INT NOT NULL,
NAME VARCHAR(7000));

LOAD DATA INFILE 
'E:/artist.csv'
INTO TABLE ARTIST
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM ARTIST;

CREATE TABLE IF NOT EXISTS PLAYLIST (
PLAYLIST_ID INT(20) NOT NULL,
NAME VARCHAR(50) NOT NULL);

LOAD DATA INFILE 
'E:/playlist.csv'
INTO TABLE PLAYLIST
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM PLAYLIST;

CREATE TABLE IF NOT EXISTS MEDIA_TYPE (
MEDIA_TYPE_ID INT(20) NOT NULL,
NAME VARCHAR(50) NOT NULL);

LOAD DATA INFILE 
'E:/media_type.csv'
INTO TABLE MEDIA_TYPE
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM MEDIA_TYPE;

CREATE TABLE IF NOT EXISTS INVOICE (
INVOICE_ID VARCHAR(1000) NOT NULL,
CUSTOMER_ID VARCHAR(100) NOT NULL,
INVOICE_DATE VARCHAR(500) NOT NULL,
BILLING_ADDRESS VARCHAR(500) NOT NULL,
BILLING_CITY VARCHAR(100) NOT NULL,
BILLING_STATE VARCHAR(100) NOT NULL,
BILLING_COUNTRY VARCHAR(100) NOT NULL,
BILLING_POSTAL_CODE VARCHAR(100) NOT NULL,
TOTAL VARCHAR(100));

LOAD DATA INFILE 
'E:/invoice.csv'
INTO TABLE INVOICE
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM INVOICE;

CREATE TABLE IF NOT EXISTS INVOICE_LINE (
INVOICE_LINE_ID VARCHAR(10000) NOT NULL,
INVOICE_ID VARCHAR(100) NOT NULL,
TRACK_ID VARCHAR(500) NOT NULL,
UNIT_PRICE VARCHAR(50) NOT NULL,
QUANTITY INT(20) NOT NULL);

LOAD DATA INFILE 
'E:/invoice_line.csv'
INTO TABLE INVOICE_LINE
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM INVOICE_LINE;

CREATE TABLE IF NOT EXISTS PLAYLIST_TRACK (
PLAYLIST_ID INT(50) NOT NULL,
TRACK_ID VARCHAR(100) NOT NULL);

LOAD DATA INFILE 
'E:/playlist_track.csv'
INTO TABLE PLAYLIST_TRACK
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM PLAYLIST_TRACK;

CREATE TABLE IF NOT EXISTS TRACK ( 
TRACK_ID VARCHAR(1000) NOT NULL,
NAME VARCHAR(1000) NOT NULL,
ALBUM_ID VARCHAR(1000) NOT NULL,
MEDIA_TYPE_ID VARCHAR(1000) NOT NULL,
GENRE_ID VARCHAR(1000) NOT NULL,
COMPOSER VARCHAR(1000) NOT NULL,
MILLISECONDS VARCHAR(500) NOT NULL,
BYTES VARCHAR(1000) NOT NULL,
UNIT_PRICE VARCHAR(20) NOT NULL);

LOAD DATA INFILE 
'E:/track.csv'
INTO TABLE TRACK
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM TRACK;

/* SQL PROJECT - MUSIC STORE DATA ANALYSIS */
/* Question set 1 - Easy */

/*Q-1. Who is the senior most employee based on Job Title? */
SELECT FIRST_NAME, LAST_NAME, TITLE FROM EMPLOYEE WHERE TITLE = 'SENIOR GENERAL MANAGER';
/* Answer is Mohan Madan who is Senior General Manager - Answer is ok */
SELECT TITLE, LAST_NAME, FIRST_NAME FROM EMPLOYEE ORDER BY LEVELS DESC LIMIT 1;
/* Answer is Mohan Madan who is Senior General Manager - Answer is ok */

/* Extra question - Who is the oldest employee based on Job Title? */
SELECT FIRST_NAME, LAST_NAME, TITLE, BIRTHDATE FROM EMPLOYEE WHERE BIRTHDATE = '19-09-1947 00:00'AND TITLE = 'SALES SUPPORT AGENT';
/* Answer is Margaret Park who is sales support agent with respect to birthdate which is another query - Answer is ok */

/*Q-2. Which countries have the most Invoices? */
SELECT BILLING_COUNTRY, COUNT(INVOICE_ID) FROM INVOICE GROUP BY BILLING_COUNTRY;
/* Answer is countries with respective highest invoices - Answer is ok */
SELECT COUNT(*) AS COUNT, BILLING_COUNTRY FROM INVOICE GROUP BY BILLING_COUNTRY ORDER BY COUNT DESC;
/* Answer is countries with respective highest invoices - Answer is ok */

/* Q-3. What are top 3 values for total invoice? */
SELECT TOTAL FROM INVOICE LIMIT 3;
SELECT MAX(TOTAL) FROM INVOICE GROUP BY TOTAL LIMIT 3;
SELECT * FROM INVOICE LIMIT 3;
/* Answer is 15.84, 9.9 and 1.98 - Answer is ok */
SELECT TOTAL FROM INVOICE ORDER BY TOTAL DESC;
SELECT TOTAL AS TOP_3_VALUES FROM INVOICE ORDER BY TOTAL DESC LIMIT 3;

/* Q-4. Which city has the best customers? We would like to throw a promotional music festival in the city we
made the most money. Write a query that returns one city that has the highest sum of invoice totals.
Return both the city name and sum of all invoices total */
SELECT BILLING_CITY AS CITYNAME, SUM(TOTAL) AS TOTALINVOICESUM FROM INVOICE
GROUP BY BILLING_CITY ORDER BY TOTALINVOICESUM DESC LIMIT 1;
/* Answer is Prague with Invoice total as 273.24****7 - Answer is ok */ 
SELECT SUM(TOTAL) AS INVOICE_TOTAL, BILLING_CITY 
FROM INVOICE 
GROUP BY BILLING_CITY
ORDER BY INVOICE_TOTAL DESC;

/* Q-5. who is the best customer? The customer who has spent the most money will be declared the best customer.
Write a query that returns the person who has spent the most money */

SELECT CUSTOMER.CUSTOMER_ID, FIRST_NAME, LAST_NAME, SUM(TOTAL) AS TOTAL_SPENDING
FROM CUSTOMER
JOIN INVOICE ON CUSTOMER.CUSTOMER_ID = INVOICE.CUSTOMER_ID
GROUP BY CUSTOMER.CUSTOMER_ID, FIRST_NAME, LAST_NAME
ORDER BY TOTAL_SPENDING DESC
LIMIT 1;
/* Answer is ok */

/* Question Set 2 - Moderate */
/* Q-1. Write a query to return the email, first name, last name & Genre of all Rock Music Listeners.
Return your list ordered alphabetically by email starting with A */

SELECT CUSTOMER.EMAIL, CUSTOMER.FIRST_NAME, CUSTOMER.LAST_NAME, GENRE.NAME AS GENRE FROM CUSTOMER
LEFT JOIN INVOICE
ON CUSTOMER.CUSTOMER_ID = INVOICE.CUSTOMER_ID
JOIN INVOICE_LINE
ON INVOICE.INVOICE_ID = INVOICE_LINE.INVOICE_ID
JOIN TRACK ON 
INVOICE_LINE.TRACK_ID = TRACK.TRACK_ID 
JOIN GENRE 
ON TRACK.GENRE_ID = GENRE.GENRE_ID WHERE EMAIL LIKE 'A%';
/* Answer is ok */

SELECT DISTINCT EMAIL, FIRST_NAME, LAST_NAME FROM CUSTOMER
JOIN INVOICE 
ON CUSTOMER.CUSTOMER_ID = INVOICE.CUSTOMER_ID
JOIN INVOICE_LINE 
ON INVOICE.INVOICE_ID = INVOICE_LINE.INVOICE_ID
WHERE TRACK_ID IN(
SELECT TRACK_ID FROM TRACK
JOIN GENRE ON TRACK.GENRE_ID = GENRE.GENRE_ID
WHERE GENRE.NAME LIKE 'Ro%')
ORDER BY EMAIL;
/* Answer is ok */

SELECT DISTINCT EMAIL AS EMAIL, FIRST_NAME AS FIRSTNAME, LAST_NAME AS LASTNAME, GENRE.NAME AS NAME
FROM CUSTOMER
JOIN INVOICE ON INVOICE.CUSTOMER_ID = CUSTOMER.CUSTOMER_ID
JOIN INVOICE_LINE ON INVOICE_LINE.INVOICE_ID = INVOICE.INVOICE_ID
JOIN TRACK ON TRACK.TRACK_ID = INVOICE_LINE.TRACK_ID
JOIN GENRE ON GENRE.GENRE_ID = TRACK.GENRE_ID
WHERE GENRE.NAME LIKE 'Ro%'
ORDER BY EMAIL;
/* Answer is ok */

/*Q-2. Let's invite the artists who have written the most rock music in our dataset. Write a query that
returns the artist name and total track count of the top 10 rock bands */

SELECT ARTIST.ARTIST_ID, ARTIST.NAME, COUNT(ARTIST.ARTIST_ID) AS NUMBER_OF_SONGS
FROM TRACK
JOIN ALBUM ON ALBUM.ALBUM_ID = TRACK.ALBUM_ID
JOIN ARTIST ON ARTIST.ARTIST_ID = ALBUM.ARTIST_ID
JOIN GENRE ON GENRE.GENRE_ID = TRACK.GENRE_ID
WHERE GENRE.NAME LIKE 'Ro%'
GROUP BY ARTIST.ARTIST_ID, ARTIST.NAME
ORDER BY NUMBER_OF_SONGS DESC
LIMIT 10;
/* Answer is not ok */

SELECT NAME, COUNT(NAME) FROM TRACK GROUP BY NAME LIMIT 10;
SELECT COMPOSER, COUNT(NAME) FROM TRACK GROUP BY COMPOSER LIMIT 10;
/* Answer is ok */

/*Q-3. Return all the track names that have a song length longer than the average song length. Return the name
and milliseconds for each track. Order by the song length with the longest songs listed first */

SELECT COMPOSER, BYTES, MILLISECONDS FROM TRACK WHERE BYTES > (SELECT AVG(BYTES) FROM TRACK) ORDER BY BYTES DESC;
SELECT COMPOSER, BYTES, MILLISECONDS FROM TRACK WHERE MILLISECONDS > (SELECT AVG(MILLISECONDS) FROM TRACK) ORDER BY MILLISECONDS DESC;
SELECT COMPOSER AS NAME, BYTES FROM TRACK WHERE BYTES > (SELECT AVG(BYTES) FROM TRACK) ORDER BY BYTES DESC;
SELECT COMPOSER AS NAME, MILLISECONDS FROM TRACK WHERE MILLISECONDS > (SELECT AVG(MILLISECONDS) AS AVG_TRACK_LENGTH FROM TRACK) ORDER BY MILLISECONDS DESC; /* This one is ok */
/* Answer is ok */

/* Question Set 3 - Advance */
/* Q-1. Find how much amount spent by each customer on artists? Write a query to return customer name, artist name
and total spent */

SELECT CUSTOMER.FIRST_NAME, CUSTOMER.LAST_NAME, ARTIST.NAME AS ARTISTNAME, INVOICE.TOTAL AS TOTALSPENT FROM INVOICE
INNER JOIN CUSTOMER ON INVOICE.CUSTOMER_ID = CUSTOMER.CUSTOMER_ID
CROSS JOIN ARTIST ON CUSTOMER.CUSTOMER_ID = ARTIST.ARTIST_ID ORDER BY TOTAL;
  /* Answer is ok */

/* Steps to Solve: First, find which artist has earned the most according to the InvoiceLines. Now use this artist to find 
which customer spent the most on this artist. For this query, you will need to use the Invoice, InvoiceLine, Track, Customer, 
Album, and Artist tables. Note, this one is tricky because the Total spent in the Invoice table might not be on a single product, 
so you need to use the InvoiceLine table to find out how many of each product was purchased, and then multiply this by the price
for each artist. */

WITH BEST_SELLING_ARTIST AS (
	SELECT ARTIST.ARTIST_ID AS ARTIST_ID, ARTIST.NAME AS ARTIST_NAME, SUM((INVOICE_LINE.UNIT_PRICE)*(INVOICE_LINE.QUANTITY)) AS TOTAL_SALES
	FROM INVOICE_LINE
	JOIN TRACK ON TRACK.TRACK_ID = INVOICE_LINE.TRACK_ID
	JOIN ALBUM ON ALBUM.ALBUM_ID = TRACK.ALBUM_ID
	JOIN ARTIST ON ARTIST.ARTIST_ID = ALBUM.ARTIST_ID
	GROUP BY 1,2
	ORDER BY 3 DESC
	LIMIT 1
    )
SELECT C.CUSTOMER_ID, C.FIRST_NAME, C.LAST_NAME, BSA.ARTIST_NAME, ROUND(SUM((IL.UNIT_PRICE)*(IL.QUANTITY)),2) AS AMOUNT_SPENT
FROM INVOICE I
JOIN CUSTOMER C ON C.CUSTOMER_ID = I.CUSTOMER_ID
JOIN INVOICE_LINE IL ON IL.INVOICE_ID = I.INVOICE_ID
JOIN TRACK T ON T.TRACK_ID = IL.TRACK_ID
JOIN ALBUM ALB ON ALB.ALBUM_ID = T.ALBUM_ID
JOIN BEST_SELLING_ARTIST BSA ON BSA.ARTIST_ID = ALB.ARTIST_ID
GROUP BY 1,2,3,4
ORDER BY 5 DESC;
/* Answer is not ok */      
        
/* Q-2. We want to find out the most popular music Genre for each country. We determine the most popular genre
as the genre with the highest amount of purchases. Write a query that returns each country along with the top Genre.
For countries where the maximum number of purchases is shared return all Genres */

/* Steps to Solve:  There are two parts in question- first most popular music genre and second need data at country level. */

/* Method 1: Using CTE */

WITH POPULAR_GENRE AS 
(
    SELECT COUNT(INVOICE_LINE.QUANTITY) AS PURCHASES, CUSTOMER.COUNTRY, GENRE.NAME, GENRE.GENRE_ID, 
	ROW_NUMBER() OVER(PARTITION BY CUSTOMER.COUNTRY ORDER BY COUNT(INVOICE_LINE.QUANTITY) DESC) AS ROWNO 
    FROM INVOICE_LINE 
	JOIN INVOICE ON INVOICE.INVOICE_ID = INVOICE_LINE.INVOICE_ID
	JOIN CUSTOMER ON CUSTOMER.CUSTOMER_ID = INVOICE.CUSTOMER_ID
	JOIN TRACK ON TRACK.TRACK_ID = INVOICE_LINE.TRACK_ID
	JOIN GENRE ON GENRE.GENRE_ID = TRACK.GENRE_ID
	GROUP BY 2,3,4
	ORDER BY 2 ASC, 1 DESC
)
SELECT * FROM POPULAR_GENRE WHERE ROWNO <= 1;
/* Answer is ok */

/* Method 2: : Using Recursive */

WITH RECURSIVE
	SALES_PER_COUNTRY AS(
		SELECT COUNT(*) AS PURCHASES_PER_GENRE, CUSTOMER.COUNTRY, GENRE.NAME, GENRE.GENRE_ID
		FROM INVOICE_LINE
		JOIN INVOICE ON INVOICE.INVOICE_ID = INVOICE_LINE.INVOICE_ID
		JOIN CUSTOMER ON CUSTOMER.CUSTOMER_ID = INVOICE.CUSTOMER_ID
		JOIN TRACK ON TRACK.TRACK_ID = INVOICE_LINE.TRACK_ID
		JOIN GENRE ON GENRE.GENRE_ID = TRACK.GENRE_ID
		GROUP BY 2,3,4
		ORDER BY 2
	),
	MAX_GENRE_PER_COUNTRY AS (SELECT MAX(PURCHASES_PER_GENRE) AS MAX_GENRE_NUMBER, COUNTRY
		FROM SALES_PER_COUNTRY
		GROUP BY 2
		ORDER BY 2)

SELECT SALES_PER_COUNTRY.* 
FROM SALES_PER_COUNTRY
JOIN MAX_GENRE_PER_COUNTRY ON SALES_PER_COUNTRY.COUNTRY = MAX_GENRE_PER_COUNTRY.COUNTRY
WHERE SALES_PER_COUNTRY.PURCHASES_PER_GENRE = MAX_GENRE_PER_COUNTRY.MAX_GENRE_NUMBER;
/* Answer is ok */

/* Q-3. Write a query that determines the customer that has spent the most on music for each country. Write a
query that returns the country along with the top customer and how much they spent. For countries where the
top amount spent is shared, provide all customers who spent this amount */

/* Steps to Solve:  Similar to the above question. There are two parts in question- 
first find the most spent on music for each country and second filter the data for respective customers. */

/* Method 1: using CTE */

WITH CUSTOMER_WITH_COUNTRY AS (
		SELECT CUSTOMER.CUSTOMER_ID, FIRST_NAME, LAST_NAME, BILLING_COUNTRY, ROUND(SUM(TOTAL),2) AS TOTAL_SPENDING,
	    ROW_NUMBER() OVER(PARTITION BY BILLING_COUNTRY ORDER BY SUM(TOTAL) DESC) AS ROWNO 
		FROM INVOICE
		JOIN CUSTOMER ON CUSTOMER.CUSTOMER_ID = INVOICE.CUSTOMER_ID
		GROUP BY 1,2,3,4
		ORDER BY 4 ASC,5 DESC)
SELECT * FROM CUSTOMER_WITH_COUNTRY WHERE ROWNO <= 1;
/* Answer is ok */

/* Method 2: Using Recursive */

WITH RECURSIVE 
	CUSTOMER_WITH_COUNTRY AS (
		SELECT CUSTOMER.CUSTOMER_ID, FIRST_NAME, LAST_NAME, BILLING_COUNTRY, ROUND(SUM(TOTAL),2) AS TOTAL_SPENDING
		FROM INVOICE
		JOIN CUSTOMER ON CUSTOMER.CUSTOMER_ID = INVOICE.CUSTOMER_ID
		GROUP BY 1,2,3,4
		ORDER BY 2,3 DESC),

	COUNTRY_MAX_SPENDING AS(
		SELECT BILLING_COUNTRY, MAX(TOTAL_SPENDING) AS MAX_SPENDING
		FROM CUSTOMER_WITH_COUNTRY
		GROUP BY BILLING_COUNTRY)

SELECT CC.BILLING_COUNTRY, CC.TOTAL_SPENDING, CC.FIRST_NAME, CC.LAST_NAME, CC.CUSTOMER_ID
FROM CUSTOMER_WITH_COUNTRY CC
JOIN COUNTRY_MAX_SPENDING MS
ON CC.BILLING_COUNTRY = MS.BILLING_COUNTRY
WHERE CC.TOTAL_SPENDING = MS.MAX_SPENDING
ORDER BY 1;
/* Answer is ok */
