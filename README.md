**1.MSSQL SET UP:**

1: **Microsoft SQL Server** installed on the machine.


2:**SQL Server Management Studio** (SSMS) for running queries.



**2.Database Setup**
3:Create a new database for the tweets data.


4:Use the SQL Server import wizard or a script to load the data from your TSV file into this table.


**3.Queries**


1.How many tweets were posted containing the term on each day?


**-- Select the name of the day (e.g., 'Monday', 'Tuesday') and the count of tweets containing 'music'
SELECT DATENAME(WEEKDAY, created_at) AS day_name,  -- Extracts the name of the weekday from the 'created_at' timestamp
       COUNT(*) AS tweets_posted                   -- Counts the total number of tweets containing 'music'
FROM silversync                                    -- The table containing the tweets data
WHERE text LIKE '%music%'                          -- Filters the tweets where the 'text' column contains the word 'music'
GROUP BY DATENAME(WEEKDAY, created_at)             -- Groups the results by the day of the week to aggregate the tweet counts
ORDER BY tweets_posted DESC                        -- Orders the results in descending order based on the number of tweets posted per day
;**


**Explanation**:


**DATENAME(WEEKDAY, created_at)**: This function extracts the name of the day from the created_at timestamp, helping to identify which day the tweets were posted on.
**COUNT(*)**: Counts the number of tweets for each day where the text contains the term 'music.'
**GROUP BY DATENAME(WEEKDAY, created_at)**: Groups the result by the day of the week to ensure that tweet counts are aggregated based on each weekday.
**ORDER BY tweets_posted DESC**: Sorts the results in descending order, so the day with the highest number of tweets appears at the top.


2:How many unique users posted a tweet containing the term?


**-- Selects distinct user IDs and counts the total number of unique users who posted tweets containing the term 'music'
SELECT DISTINCT id AS unique_users,  -- Selects distinct user IDs (assuming 'id' represents the user ID) who posted tweets with 'music'
       COUNT(DISTINCT id) AS number  -- Counts the total number of distinct user IDs
FROM silversync                      -- The table containing the tweets data
WHERE text LIKE '%music%'            -- Filters the tweets where the 'text' column contains the word 'music'**


**Explanation** :


**SELECT DISTINCT id**: This fetches the distinct user IDs, assuming the id column represents the unique user identifier. Each row corresponds to a different user who posted a tweet containing the term "music."
**COUNT(DISTINCT id) AS number**: Counts the total number of unique users who have tweeted about "music."
This query provides both the distinct user list (unique_users) and the count of unique users (number).



**-- Counts the total number of unique users who posted tweets containing the term 'music'
SELECT COUNT(DISTINCT id) AS number  -- Counts the total number of distinct user IDs
FROM silversync                      -- The table containing the tweets data
WHERE text LIKE '%music%'            -- Filters the tweets where the 'text' column contains the word 'music'**

Output:Total **3001 users posted a tweet** containing the term music


**Explanation** :


This query is simpler and focuses only on counting the number of unique users who posted tweets containing "music."
The **COUNT(DISTINCT id)** directly returns the count without listing the distinct users themselves.


3: How many likes did tweets containing the term get, on average?


**-- Calculates the average number of likes for tweets containing the term 'music'
SELECT AVG(like_count) AS avg_likes  -- Calculates the average value of the 'like_count' column
FROM silversync                      -- The table containing the tweets data
WHERE text LIKE '%music%'            -- Filters the tweets where the 'text' column contains the word 'music'**


Ouptut: Total Average likes for the term: **161**


**Explanation** :


**AVG(like_count)**: This function calculates the average number of likes (like_count) for all tweets containing the word "music."
**WHERE text LIKE '%music%'**: Filters the tweets to include only those where the tweet text contains the term "music."
The query returns the average number of likes (avg_likes) for tweets matching the search term, which provides an idea of user engagement for those tweets.


4:Where (in terms of place IDs) did the tweets come from?


**-- Retrieves the place ID where the tweets containing 'music' were posted, and replaces null values with 'unknown'
SELECT COALESCE(place_id, 'unknown') AS place_id  -- Uses COALESCE to replace NULL values in the 'place_id' column with 'unknown'
FROM silversync                                    -- The table containing the tweets data
WHERE text LIKE '%music%'                          -- Filters the tweets where the 'text' column contains the word 'music'
GROUP BY COALESCE(place_id, 'unknown')             -- Groups by the place ID or 'unknown' for tweets without a place ID**


**Explanation**:


**COALESCE(place_id, 'unknown')**: This function replaces any NULL values in the place_id column with the string 'unknown'. It ensures that rows with missing place_id values are still accounted for, without leaving gaps.
**GROUP BY COALESCE(place_id, 'unknown')**: Groups the results based on the place ID or 'unknown' if no place ID exists.
This query retrieves distinct place IDs for tweets containing the term "music" and ensures that any tweet without a place_id is labeled as 'unknown'.



5:What times of day were the tweets posted at? 


**-- Retrieves the number of tweets containing the term 'music' for each hour of the day
SELECT DATEPART(HOUR, created_at) AS hour_,  -- Extracts the hour part from the 'created_at' timestamp for each tweet
       COUNT(*) AS total_tweets              -- Counts the total number of tweets posted during each hour
FROM silversync                              -- The table containing the tweets data
WHERE text LIKE '%music%'                    -- Filters the tweets where the 'text' column contains the word 'music'
GROUP BY DATEPART(HOUR, created_at)          -- Groups the tweets by the hour of the day they were posted
ORDER BY total_tweets DESC;                  -- Orders the results by the total number of tweets in descending order**

**Explanation**:


**DATEPART(HOUR, created_at)**: Extracts the hour from the created_at timestamp, which represents the time of day when each tweet was posted. This will return values between 0 and 23, representing each hour of the day.
**COUNT(*) AS total_tweets**: Counts the total number of tweets posted during each hour of the day that contain the term "music."
**GROUP BY DATEPART(HOUR, created_at)**: Groups the tweets based on the hour they were posted.
**ORDER BY total_tweets DESC**: Sorts the results by the total number of tweets in descending order, showing the hours with the most activity first.


6:Which user posted the most tweets containing the term?


**-- Retrieves the user who posted the most tweets containing the term 'music'
SELECT author_handle,                -- Selects the handle (username) of the tweet author
       COUNT(*) AS most_tweets       -- Counts the total number of tweets each user posted containing the term 'music'
FROM silversync                      -- The table containing the tweets data
WHERE text LIKE '%music%'            -- Filters the tweets where the 'text' column contains the word 'music'
GROUP BY author_handle               -- Groups the results by each user's handle (username)
ORDER BY most_tweets DESC;           -- Orders the results in descending order to show the user with the most tweets first**

Output: The **freqnetwork** user has posted more tweets containing the term


**Explanation**:


**author_handle**: Represents the Twitter handle (username) of the user who posted the tweet.
**COUNT(*) AS most_tweets**: Counts the total number of tweets posted by each user that contain the term "music."
**GROUP BY author_handle**: Groups the results by each user's handle so the count can be aggregated per user.
**ORDER BY most_tweets DESC**: Sorts the results by the number of tweets in descending order, showing the users who posted the most tweets containing the term "music" at the top.









