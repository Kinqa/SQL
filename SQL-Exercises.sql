-- I present some solutions for the SQL challenges posted on DataLemur.com and Hackerrank.com, among others. --

-- Query for a list of city names that do not start with vowels and do not end with vowels. --
-- The output is cities without duplicates. --
SELECT DISTINCT CITY FROM STATION 
WHERE CITY NOT REGEXP '^[aeiou]' AND CITY NOT REGEXP '[aeiou]$';	

-- Query for a name of students who scored higher than 75. --
-- The output is names ordered by the last three characters of each name and then by ID. --
SELECT Name FROM STUDENTS 
WHERE Marks>75 ORDER BY RIGHT(Name, 3), ID;

-- Query for employee that have a salary greater than 2000 $ per month and who have been employed for less than year. -- 
-- The output is the employee name. --
SELECT name FROM Employee 
WHERE salary>2000 AND months<12;

-- Query for the type of triangle. In table each column a, b, c is the length of a side of the triangle. --
-- The output is the type of triangle. -- 
SELECT CASE 
WHEN (a+b<=c) THEN "Not A Triangle"
WHEN (a=b AND b=c AND c=a) THEN "Equilateral"
WHEN (a=b OR a=c OR b=c) THEN "Isosceles"
WHEN (a!=b AND a!=c AND b!=c) THEN "Scalene"
END 
FROM TRIANGLES;

-- Query for the sum of Northern Latitudes where values are greater than 38.7880 and less than 137.2345. --
-- The output is truncated to 4 decimal places. --
SELECT ROUND(SUM(LAT_N),4) FROM STATION 
WHERE (LAT_N)>38.7880 AND (LAT_N)<137.2345;

-- Query for the names of all the continents and their respective average city populations. --
-- The output is rounded down to the nearest integer. --
SELECT COUNTRY.Continent, FLOOR(AVG(CITY.Population)) FROM CITY
INNER JOIN COUNTRY ON CITY.CountryCode=COUNTRY.Code
GROUP BY COUNTRY.Continent;

-- Query for 2 tables containing completed trade orders and user details to retrieve the top three cities that have the highest number of completed trade orders. --
-- The output is the city name and the number of completed trade orders in descending order. --
SELECT USERS.city, COUNT(*) AS total_orders FROM USERS 
INNER JOIN TRADES ON USERS.user_id=TRADES.user_id 
WHERE TRADES.status='Completed'
GROUP BY USERS.city
ORDER BY total_orders DESC
LIMIT 3;

-- Query for 2 tables containing data about pages and their respective likes, where IDs of the pages have zero likes. --
-- The output is sorted in ascending order based on the page IDs. --
SELECT pages.page_id
FROM pages
LEFT JOIN page_likes ON pages.page_id=page_likes.page_id 
WHERE page_likes.page_id IS NULL;

-- Query for candidates skills, where candidates are proficient in Python, Tableau, and PostgreSQL. --
-- The output is sort by candidate ID in ascending order. --
SELECT candidate_id FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill) = 3
ORDER BY candidate_id ASC;

-- Query to identify the top 2 Power Users who sent the highest number of messages on Microsoft Teams in August 2022. --
-- The outputs are the ID with the total number of messages, in descending order based on the count of the messages. --
SELECT sender_id, COUNT(*) AS message_count FROM messages
WHERE sent_date>'08/01/2022 00:00:00' AND sent_date<'08/31/2022 00:00:00'
GROUP BY sender_id
ORDER BY COUNT(*) DESC
LIMIT 2;

-- Query to find the number of days between each user’s first post of the year 2021 and last post of the year 2021. --
-- The output is the user's id and number of the days between each user's first and last post. --
SELECT user_id, DATE_PART('day', MAX(post_date)-MIN(post_date)) AS days_between FROM posts
WHERE post_date > '01/01/2021 00:00:00' AND post_date < '12/31/2021 23:59:59'
GROUP BY user_id
HAVING COUNT(user_id)>1;

-- Query to find the mean number of items per order. --
-- The output is rounded to 1 decimal place. --
SELECT ROUND(SUM(item_count*order_occurrences)::DECIMAL / SUM(order_occurrences), 1)
FROM items_per_order;

-- Query to find the second largest date difference. --
SELECT *, DATEDIFF(d,[Ending].[Date],[Beginning].[Date]) AS DateDifference 
FROM [Portfolio].[dbo].[Beginning]
JOIN [Portfolio].[dbo].[Ending]
ON [Beginning].[ID] = [Ending].[ID]
ORDER BY DateDifference
OFFSET 1 ROW FETCH NEXT 1 ROWS ONLY;
