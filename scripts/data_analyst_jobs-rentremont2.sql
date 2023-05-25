SELECT *
FROM data_analyst_jobs;

--How many rows are in the data_analyst_jobs table?
SELECT COUNT(title)
FROM data_analyst_jobs;
--1793

--Write a query to look at just the first 10 rows. What company is associated 
--with the job posting on the 10th row?
SELECT *
FROM data_analyst_jobs
LIMIT 10;
--ExxonMobil

--How many postings are in Tennessee? How many are there in either Tennessee 
--or Kentucky?
SELECT COUNT(location) AS location_TN
FROM data_analyst_jobs
WHERE location = 'TN';
-- TN: 21
SELECT COUNT(location) AS location_TNKY
FROM data_analyst_jobs
WHERE location IN('TN','KY');
--TN or KY: 27

--How many postings in Tennessee have a star rating above 4?
SELECT star_rating, location
FROM data_analyst_jobs
WHERE star_rating > 4 AND location = 'TN';
-- 3

--How many postings in the dataset have a review count between 500 and 1000?
SELECT COUNT(review_count)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;
--151

--Show the average star rating for companies in each state. The output should 
--show the state as `state` and the average rating for the state as `avg_rating`.
--Which state shows the highest average rating?
SELECT location AS state, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
GROUP BY location
ORDER BY avg_rating DESC NULLS LAST;
-- NE

--Select unique job titles from the data_analyst_jobs table. How many are there?
SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs;
--881

--How many unique job titles are there for California companies?
SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE location = 'CA';
--230

--Find the name of each company and its average star rating for all companies 
--that have more than 5000 reviews across all locations. How many companies are 
--there with more that 5000 reviews across all locations?
SELECT company, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE company IS NOT NULL
GROUP BY company
HAVING SUM(review_count) >5000;
--70

--Add the code to order the query in #9 from highest to lowest average star 
--rating. Which company with more than 5000 reviews across all locations in the 
--dataset has the highest star rating? What is that rating?
SELECT company, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE company IS NOT NULL
GROUP BY company
HAVING SUM(review_count) >5000
ORDER BY avg_rating DESC;
-- Google with a 4.3 average rating

--Find all the job titles that contain the word ‘Analyst’. How many different 
--job titles are there? 
SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%';
--774

--How many different job titles do not contain either the word ‘Analyst’ or 
--the word ‘Analytics’? What word do these positions have in common?
SELECT title
FROM data_analyst_jobs
WHERE title NOT ILIKE '%Analyst%' AND title NOT ILIKE '%Analytics%';
--4
--They all contain the word Tableau

SELECT domain, COUNT(title) AS hard_to_fill_jobs
FROM data_analyst_jobs
WHERE skill ILIKE '%SQL%' AND days_since_posting > 21 AND domain IS NOT NULL
GROUP BY domain
ORDER BY hard_to_fill_jobs DESC;