CREATE DATABASE seven_wonders;
USE seven_wonders;

-- 1️⃣ Wonders Table (7 rows)
	CREATE TABLE wonders (
		wonder_id INT PRIMARY KEY,
		wonder_name VARCHAR(100),
		location VARCHAR(100),
		year_built VARCHAR(20),
		category VARCHAR(50)
	);
	
	INSERT INTO wonders (wonder_id, wonder_name, location, year_built, category) VALUES
	(1, 'Great Wall of China', 'China', '700 BC', 'Ancient'),
	(2, 'Christ the Redeemer', 'Brazil', '1931', 'Modern'),
	(3, 'Machu Picchu', 'Peru', '1450', 'Ancient'),
	(4, 'Chichen Itza', 'Mexico', '600 AD', 'Ancient'),
	(5, 'Roman Colosseum', 'Italy', '80 AD', 'Ancient'),
	(6, 'Taj Mahal', 'India', '1648', 'Medieval'),
	(7, 'Petra', 'Jordan', '312 BC', 'Ancient');
	
	-- 2️⃣ Visitors Table (20 rows)
	CREATE TABLE visitors (
		visit_id INT PRIMARY KEY AUTO_INCREMENT,
		wonder_id INT,
		year INT,
		annual_visitors DECIMAL(5,2),
		FOREIGN KEY (wonder_id) REFERENCES wonders(wonder_id)
	);
	
	INSERT INTO visitors (wonder_id, year, annual_visitors) VALUES
	(1, 2023, 10.0), (1, 2022, 9.5), (1, 2021, 8.7),
	(2, 2023, 2.0), (2, 2022, 1.9), (2, 2021, 1.8),
	(3, 2023, 1.5), (3, 2022, 1.6), (3, 2021, 1.4),
	(4, 2023, 2.6), (4, 2022, 2.4), (4, 2021, 2.3),
	(5, 2023, 7.6), (5, 2022, 7.1), (5, 2021, 6.9),
	(6, 2023, 8.0), (6, 2022, 7.8), (6, 2021, 7.5),
	(7, 2023, 1.0), (7, 2022, 0.9);
	
	-- 3️⃣ Countries Table (7 rows)
	CREATE TABLE countries (
		country_id INT PRIMARY KEY,
		country_name VARCHAR(100),
		continent VARCHAR(50)
	);
	
	INSERT INTO countries (country_id, country_name, continent) VALUES
	(1, 'China', 'Asia'),
	(2, 'Brazil', 'South America'),
	(3, 'Peru', 'South America'),
	(4, 'Mexico', 'North America'),
	(5, 'Italy', 'Europe'),
	(6, 'India', 'Asia'),
	(7, 'Jordan', 'Asia');
	
	-- 4️⃣ Reviews Table (15 rows)
	CREATE TABLE reviews (
		review_id INT PRIMARY KEY AUTO_INCREMENT,
		wonder_id INT,
		rating DECIMAL(2,1),
		review_text TEXT,
		FOREIGN KEY (wonder_id) REFERENCES wonders(wonder_id)
	);
	
	INSERT INTO reviews (wonder_id, rating, review_text) VALUES
	(1, 4.8, 'Breathtaking experience, worth the climb!'),
	(1, 4.5, 'Too crowded but still amazing.'),
	(2, 4.5, 'Iconic statue, great views of Rio.'),
	(2, 4.2, 'Not as big as expected, but beautiful.'),
	(3, 4.7, 'Absolutely stunning views and history.'),
	(3, 4.3, 'Difficult hike, but rewarding.'),
	(4, 4.3, 'A historical masterpiece.'),
	(4, 4.0, 'Great but too touristy.'),
	(5, 4.6, 'Loved the architecture!'),
	(5, 4.5, 'Amazing history behind this monument.'),
	(6, 4.9, 'A must-visit destination!'),
	(6, 4.8, 'Mesmerizing beauty.'),
	(7, 4.2, 'Unique, but less tourist-friendly.'),
	(7, 4.1, 'Could be maintained better.'),
	(7, 3.9, 'Good but not much to do.');
    
    -- Exploratory Data Analysis
    
    SELECT * FROM countries;
    SELECT * FROM reviews;
    SELECT * FROM visitors;
    SELECT * FROM wonders;
    
-- 1) Find all wonders with their location and category ?
SELECT wonder_name, location, category
FROM wonders;
    
-- 2) Find the total visitors for each wonder in 2023, appending 'M' using 'CONCAT' function in annual_visitors column ?
SELECT concat(annual_visitors, "M") AS Total_Visitors
FROM visitors
WHERE year = 2023;

-- 3) Find all visitor records for the Great Wall of China ?
SELECT CONCAT(COUNT(v.visit_id),"M") AS Total_Visitors
FROM visitors v
JOIN wonders w ON v.wonder_id = w.wonder_id
ORDER BY Total_Visitors DESC;

-- 4) Count the total number of reviews in the reviews table ?
SELECT COUNT(review_id) AS Total_Reviews
FROM reviews;

-- 5) Find each wonder along with its continent ?
SELECT w.wonder_name, w.location, c.continent
FROM wonders w
JOIN countries c ON w.location = c.country_name;

-- 6) Find the average annual visitors for each wonder from 2021 to 2023 ?
SELECT w.wonder_name, v.year, CONCAT(ROUND(AVG(v.annual_visitors), 2), 'M') AS avg_annual_visitors
FROM wonders w 
JOIN visitors v ON w.wonder_id = v.wonder_id
WHERE v.year IN (2021, 2022, 2023)
GROUP BY w.wonder_name, v.year
ORDER BY v.year, avg_annual_visitors DESC;

-- 7) List wonders along with their average rating ?
SELECT w.wonder_name, r.rating
FROM wonders w
JOIN reviews r ON w.wonder_id = r.wonder_id
GROUP BY w.wonder_name, r.rating
ORDER BY r.rating DESC;

-- 8) Find wonders with visitor counts between 1 and 3 million in 2023 ?
SELECT w.wonder_name, CONCAT(COUNT(v.visit_id), 'M') AS Total_Visitors
FROM wonders w
JOIN visitors v ON w.wonder_id = v.wonder_id
GROUP BY w.wonder_name
HAVING COUNT(v.visit_id) BETWEEN 1 AND 3
ORDER BY COUNT(v.visit_id) DESC;

-- 9) Find reviews that contain the word ‘beautiful’ ?
SELECT review_text
FROM reviews 
WHERE review_text LIKE "%beautiful%";

-- 10) Find wonders located in either South America or Asia ?
SELECT w.wonder_name, w.location, c.continent
FROM wonders w
JOIN countries c ON w.location = c.country_name
WHERE c.continent IN ('South America', 'Asia');
