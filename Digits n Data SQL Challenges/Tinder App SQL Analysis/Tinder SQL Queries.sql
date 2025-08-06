CREATE DATABASE Tinder;
USE Tinder;

-- Creating Users Table
	CREATE TABLE Users (
		user_id INT PRIMARY KEY AUTO_INCREMENT,
		name VARCHAR(100),
		age INT,
		gender ENUM('Male', 'Female', 'Other'),
		location VARCHAR(255),
		created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
	);
	
	-- Inserting 15 rows into Users Table
	INSERT INTO Users (name, age, gender, location) VALUES
	('Alice', 25, 'Female', 'New York'),
	('Bob', 28, 'Male', 'Los Angeles'),
	('Charlie', 30, 'Male', 'Chicago'),
	('David', 22, 'Male', 'Houston'),
	('Emma', 26, 'Female', 'San Francisco'),
	('Fiona', 27, 'Female', 'Los Angeles'),
	('George', 29, 'Male', 'Boston'),
	('Hannah', 24, 'Female', 'Miami'),
	('Isaac', 31, 'Male', 'Dallas'),
	('Julia', 23, 'Female', 'Austin'),
	('Kevin', 28, 'Male', 'Denver'),
	('Laura', 26, 'Female', 'Las Vegas'),
	('Mike', 32, 'Male', 'Phoenix'),
	('Nina', 29, 'Female', 'Philadelphia'),
	('Oscar', 27, 'Male', 'Atlanta');
	
	-- Creating Swipes Table
	CREATE TABLE Swipes (
		swipe_id INT PRIMARY KEY AUTO_INCREMENT,
		swiper_id INT,
		swiped_id INT,
		swipe_type ENUM('Like', 'Dislike'),
		swipe_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
		FOREIGN KEY (swiper_id) REFERENCES Users(user_id),
		FOREIGN KEY (swiped_id) REFERENCES Users(user_id)
	);
	
	-- Inserting 15 rows into Swipes Table
	INSERT INTO Swipes (swiper_id, swiped_id, swipe_type) VALUES
	(1, 2, 'Like'),
	(2, 3, 'Like'),
	(3, 4, 'Dislike'),
	(4, 5, 'Like'),
	(5, 6, 'Like'),
	(6, 7, 'Dislike'),
	(7, 8, 'Like'),
	(8, 9, 'Dislike'),
	(9, 10, 'Like'),
	(10, 11, 'Like'),
	(11, 12, 'Dislike'),
	(12, 13, 'Like'),
	(13, 14, 'Dislike'),
	(14, 15, 'Like'),
	(15, 1, 'Like');
	
	-- Creating Matches Table
	CREATE TABLE Matches (
		match_id INT PRIMARY KEY AUTO_INCREMENT,
		user1_id INT,
		user2_id INT,
		match_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
		FOREIGN KEY (user1_id) REFERENCES Users(user_id),
		FOREIGN KEY (user2_id) REFERENCES Users(user_id)
	);
	
	-- Inserting 15 rows into Matches Table
	INSERT INTO Matches (user1_id, user2_id) VALUES
	(1, 2),
	(3, 5),
	(4, 6),
	(7, 8),
	(9, 10),
	(11, 12),
	(13, 15),
	(2, 6),
	(5, 7),
	(8, 9),
	(10, 14),
	(12, 15),
	(3, 11),
	(4, 9),
	(1, 13);
	
	-- Creating Messages Table
	CREATE TABLE Messages (
		message_id INT PRIMARY KEY AUTO_INCREMENT,
		match_id INT,
		sender_id INT,
		receiver_id INT,
		message_text TEXT,
		sent_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
		FOREIGN KEY (match_id) REFERENCES Matches(match_id),
		FOREIGN KEY (sender_id) REFERENCES Users(user_id),
		FOREIGN KEY (receiver_id) REFERENCES Users(user_id)
	);
	
	-- Inserting 10 rows into Messages Table
	INSERT INTO Messages (match_id, sender_id, receiver_id, message_text) VALUES
	(1, 1, 2, 'Hey! How are you?'),
	(2, 3, 5, 'Hello there!'),
	(3, 4, 6, 'What’s up?'),
	(4, 7, 8, 'Nice to meet you!'),
	(5, 9, 10, 'Hey!'),
	(6, 11, 12, 'What’s your favorite movie?'),
	(7, 13, 15, 'Tell me something fun!'),
	(8, 2, 6, 'You have a great smile!'),
	(9, 5, 7, 'Want to grab coffee?'),
	(10, 8, 9, 'Cool profile!');
	
	-- Creating Subscriptions Table
	CREATE TABLE Subscriptions (
		subscription_id INT PRIMARY KEY AUTO_INCREMENT,
		user_id INT,
		plan_type ENUM('Free', 'Plus', 'Gold', 'Platinum'),
		start_date DATE,
		end_date DATE,
		FOREIGN KEY (user_id) REFERENCES Users(user_id)
	);
	
	-- Inserting 5 rows into Subscriptions Table
	INSERT INTO Subscriptions (user_id, plan_type, start_date, end_date) VALUES
	(1, 'Gold', '2025-01-01', '2025-03-01'),
	(5, 'Plus', '2025-02-10', '2025-04-10'),
	(10, 'Platinum', '2025-01-20', '2025-07-20'),
	(13, 'Gold', '2025-03-05', '2025-05-05'),
	(15, 'Free', NULL, NULL),
	(2, 'Plus', '2025-02-15', '2025-04-15'),
	(6, 'Gold', '2025-03-01', '2025-06-01'),
	(8, 'Platinum', '2025-01-10', '2025-07-10'),
	(11, 'Plus', '2025-02-20', '2025-04-20'),
	(14, 'Gold', '2025-03-10', '2025-05-10');
    

-- Exploratory Data Analysis
SELECT * FROM matches;
SELECT * FROM messages;
SELECT * FROM subscriptions;
SELECT * FROM swipes;
SELECT * FROM users;

-- 1) Find all users info ?
SELECT user_id, name, age, gender, location
FROM users;

-- 2) Count total users ?
SELECT COUNT(user_id) AS Total_Users
FROM users;

-- 3) Find all likes from the Swipes table ?
SELECT *
FROM swipes
WHERE swipe_type = "Like";

-- 4) Find users who subscribed to Gold plan ?
SELECT u.name
FROM users u
JOIN subscriptions s ON u.user_id = s.user_id
WHERE s.plan_type = "Gold";

-- 5) Find all user matches with their names ?
SELECT u1.name AS user1_name, u2.name AS user2_name, m.match_time
FROM matches m
JOIN users u1 ON m.user1_id = u1.user_id
JOIN users u2 ON m.user2_id = u2.user_id;

-- 6) Find the number of users in each subscription plan ?
SELECT plan_type, COUNT(user_id) AS total_users
FROM subscriptions
GROUP BY plan_type;

-- 7) Find users above 25 years old ?
SELECT user_id, name, age
FROM users
WHERE age > 25;

-- 8) Find matches where both users are in the same city ?
SELECT u1.name AS user1_name, u2.name AS user2_name, u1.location AS common_location
FROM matches m
JOIN users u1 ON m.user1_id = u1.user_id
JOIN users u2 ON m.user2_id = u2.user_id
WHERE u1.location = u2.location;

-- 9) Find the percentage of users subscribed to a paid plan ?
SELECT ROUND((COUNT(DISTINCT CASE WHEN s.plan_type IN ('Plus', 'Gold', 'Platinum') THEN u.user_id END) * 100.0) / COUNT(DISTINCT u.user_id), 2) AS paid_subscription_percentage
FROM users u
LEFT JOIN subscriptions s ON u.user_id = s.user_id;

-- 10) Find the interaction type for each swipe using a CASE statement, classifying 'Like' as 'Positive' and 'Dislike' as 'Negative' ?
SELECT swipe_id, swiper_id, swiped_id, swipe_type,
CASE WHEN swipe_type = 'Like' THEN 'Positive'
	 WHEN swipe_type = 'Dislike' THEN 'Negative'
	 ELSE 'Unknown'
     END AS interaction_type
FROM swipes;



