use potato;

SELECT * FROM silversync;

SELECT COUNT(DISTINCT lang),lang
FROM silversync
GROUP BY lang
HAVING COUNT(lang)>2
  


-- filling missing values for the columns likes and retweet_count by 0 which means in these cases likely mean there are no likes 
SELECT *
FROM silversync
WHERE text LIKE '%music%';

-- How many tweets were posted containing the term on each day?

SELECT DATENAME(WEEKDAY,created_at) AS day_name,COUNT(*) AS tweets_posted
FROM silversync
WHERE text LIKE '%music%'
GROUP BY DATENAME(WEEKDAY,created_at)
ORDER BY tweets_posted DESC;


-- How many unique users posted a tweet containing the term?
SELECT DISTINCT id AS unique_users,COUNT(DISTINCT id) AS number
FROM silversync
WHERE text LIKE '%music%'

SELECT COUNT(DISTINCT id) AS number
FROM silversync
WHERE text LIKE '%music%'


-- How many likes did tweets containing the term get, on average?
SELECT AVG(like_count) AS avg_likes
FROM silversync
WHERE text LIKE '%music%'


-- Where (in terms of place IDs) did the tweets come from?
SELECT COALESCE(place_id,'unknown')  AS place_id
FROM silversync
WHERE text LIKE '%music%'
GROUP BY COALESCE(place_id,'unknown')  ;


-- What times of day were the tweets posted at? 
SELECT DATEPART(HOUR, created_at) AS hour_,COUNT(*) AS total_tweets
FROM silversync
WHERE text LIKE '%music%'
GROUP BY  DATEPART(HOUR, created_at)
ORDER BY total_tweets DESC;

-- Which user posted the most tweets containing the term?
SELECT author_handle,COUNT(*) AS most_tweets
FROM silversync
WHERE text LIKE '%music%'
GROUP BY author_handle
ORDER BY most_tweets DESC;