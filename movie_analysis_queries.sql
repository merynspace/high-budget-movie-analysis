CREATE DATABASE movie_analysis;

CREATE TABLE movies (
movie_id INT auto_increment PRIMARY KEY,
release_date DATE,
title VARCHAR (250),
production_cost BIGINT,
worldwide_revenue BIGINT,
opening_weekend BIGINT,
genre VARCHAR (100),
runtime INT,
release_year INT
);

SELECT *
FROM movie_analysis.movies
LIMIT 10;

ALTER TABLE movies
ADD COLUMN profit BIGINT;

UPDATE movies
SET profit =
CASE
    WHEN worldwide_revenue IS NULL
         OR production_cost IS NULL
    THEN NULL
    ELSE worldwide_revenue - production_cost
END;

ALTER TABLE movies
ADD COLUMN release_season VARCHAR(20);

UPDATE movies
SET release_season =
CASE
    WHEN MONTH(release_date) IN (12, 1, 2) THEN 'Winter'
    WHEN MONTH(release_date) IN (3, 4, 5) THEN 'Spring'
    WHEN MONTH(release_date) IN (6, 7, 8) THEN 'Summer'
    ELSE 'Autumn'
END;

SELECT title, profit
FROM movies
ORDER BY profit DESC
LIMIT 10;

SELECT title, worldwide_revenue
FROM movies
ORDER BY worldwide_revenue DESC
LIMIT 10;

SELECT genre,
		ROUND(AVG(profit), 0) AS avg_profit
FROM movies
GROUP BY genre
ORDER BY avg_profit DESC;

SELECT release_season,
		ROUND(AVG(profit), 0) AS avg_profit
FROM movies
GROUP BY release_season
ORDER BY avg_profit DESC;

SELECT genre,
       ROUND(AVG(runtime), 1) AS avg_runtime
FROM movies
GROUP BY genre
ORDER BY avg_runtime DESC;

SELECT release_year,
       SUM(worldwide_revenue) AS total_revenue
FROM movies
GROUP BY release_year
ORDER BY total_revenue DESC;

ALTER TABLE movies
ADD COLUMN roi DECIMAL(10,2);

UPDATE movies
SET roi = (profit / production_cost) * 100;

SELECT * FROM movies LIMIT 10;

SELECT title, roi
FROM movies
ORDER BY roi DESC
LIMIT 10;

SELECT *
FROM movies
LIMIT 10;

SELECT *
FROM movies;