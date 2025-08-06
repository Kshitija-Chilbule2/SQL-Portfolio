CREATE DATABASE Snapchat;
USE snapchat;

	-- Creating Users Table
 
    CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    full_name VARCHAR(100),
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15) UNIQUE,
    date_of_birth DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Inserting 15 Sample Users

INSERT INTO Users (username, full_name, email, phone_number, date_of_birth) VALUES
('rahul123', 'Rahul Sharma', 'rahul.sharma@example.com', '9876543210', '1995-06-15'),
('priya_m', 'Priya Mehta', 'priya.mehta@example.com', '9765432109', '1998-02-10'),
('arjun_k', 'Arjun Kapoor', 'arjun.kapoor@example.com', '9654321098', '1993-09-25'),
('aisha_b', 'Aisha Banerjee', 'aisha.banerjee@example.com', '9543210987', '2000-01-30'),
('vivek_r', 'Vivek Reddy', 'vivek.reddy@example.com', '9432109876', '1997-07-12'),
('sneha_g', 'Sneha Gupta', 'sneha.gupta@example.com', '9321098765', '1996-08-22'),
('manish_t', 'Manish Tiwari', 'manish.tiwari@example.com', '9210987654', '1994-11-18'),
('nikita_s', 'Nikita Singh', 'nikita.singh@example.com', '9109876543', '1999-04-05'),
('akash_j', 'Akash Jain', 'akash.jain@example.com', '9008765432', '2001-07-20'),
('meera_k', 'Meera Krishnan', 'meera.krishnan@example.com', '9898989898', '1992-12-02'),
('ravi_p', 'Ravi Patel', 'ravi.patel@example.com', '9787878787', '1991-03-15'),
('pooja_v', 'Pooja Verma', 'pooja.verma@example.com', '9676767676', '2002-06-10'),
('rohit_b', 'Rohit Bansal', 'rohit.bansal@example.com', '9565656565', '1990-09-08'),
('sanya_c', 'Sanya Choudhary', 'sanya.choudhary@example.com', '9454545454', '1995-10-25'),
('gautam_d', 'Gautam Deshmukh', 'gautam.deshmukh@example.com', '9343434343', '1997-01-14');

-- Creating Messages Table 

    CREATE TABLE Messages (
    message_id INT PRIMARY KEY AUTO_INCREMENT,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    message_text TEXT,
    media_url VARCHAR(255),
    media_type ENUM('photo', 'video', 'text') NOT NULL DEFAULT 'text',
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_read BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (sender_id) REFERENCES Users(user_id),
    FOREIGN KEY (receiver_id) REFERENCES Users(user_id)
);

-- Inserting 15 Sample Messages

INSERT INTO Messages (sender_id, receiver_id, message_text, media_type, is_read) VALUES
(1, 2, 'Hey Priya! How are you?', 'text', TRUE),
(3, 4, 'Let’s catch up this weekend!', 'text', TRUE),
(5, 6, 'Happy Birthday Sneha!', 'text', TRUE),
(7, 8, 'Check out this new movie trailer!', 'video', FALSE),
(9, 10, 'Hey Meera, long time no see!', 'text', TRUE),
(11, 12, 'Look at this amazing sunset!', 'photo', FALSE),
(13, 14, 'Did you complete the project?', 'text', TRUE),
(15, 1, 'New year party plans?', 'photo', FALSE),
(2, 3, 'Watch this hilarious meme!', 'video', FALSE),
(4, 5, 'Meeting at 3 PM confirmed.', 'text', TRUE),
(6, 7, 'This song is a vibe!', 'video', FALSE),
(8, 9, 'Birthday celebration pics!', 'photo', TRUE),
(10, 11, 'Want to go trekking?', 'text', FALSE),
(12, 13, 'Check this out!', 'photo', TRUE),
(14, 15, 'Good morning! Have a great day!', 'text', TRUE);

-- Creating Streaks Table
 
    CREATE TABLE Streaks (
    streak_id INT PRIMARY KEY AUTO_INCREMENT,
    user1_id INT NOT NULL,
    user2_id INT NOT NULL,
    streak_count INT DEFAULT 0,
    last_snap_sent TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user1_id) REFERENCES Users(user_id),
    FOREIGN KEY (user2_id) REFERENCES Users(user_id)
);

-- Inserting 15 Sample Streaks

INSERT INTO Streaks (user1_id, user2_id, streak_count, last_snap_sent) VALUES
(1, 2, 15, '2025-03-06 12:30:00'),
(3, 4, 27, '2025-03-06 18:45:00'),
(5, 6, 7, '2025-03-06 09:10:00'),
(7, 8, 32, '2025-03-06 22:15:00'),
(9, 10, 10, '2025-03-06 14:40:00'),
(11, 12, 5, '2025-03-06 08:55:00'),
(13, 14, 42, '2025-03-06 17:20:00'),
(15, 1, 21, '2025-03-06 20:05:00'),
(2, 3, 8, '2025-03-06 11:30:00'),
(4, 5, 19, '2025-03-06 16:25:00'),
(6, 7, 25, '2025-03-06 23:10:00'),
(8, 9, 30, '2025-03-06 10:50:00'),
(10, 11, 6, '2025-03-06 13:15:00'),
(12, 13, 14, '2025-03-06 15:00:00'),
(14, 15, 9, '2025-03-06 19:35:00');

-- Creating Filters Table

    CREATE TABLE Filters (
    filter_id INT PRIMARY KEY AUTO_INCREMENT,
    filter_name VARCHAR(50) NOT NULL,
    filter_type ENUM('AR', 'Geo', 'Bitmoji') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Inserting 6 Sample Filters

INSERT INTO Filters (filter_name, filter_type) VALUES
('Dog Ears', 'AR'),
('Mumbai Skyline', 'Geo'),
('Bitmoji Party', 'Bitmoji'),
('Cat Whiskers', 'AR'),
('Delhi Gate', 'Geo'),
('Dancing Bitmoji', 'Bitmoji');

-- Creating Filter Usage Table 

    CREATE TABLE FilterUsage (
    usage_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    filter_id INT NOT NULL,
    used_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (filter_id) REFERENCES Filters(filter_id)
);

-- Inserting 15 Sample Filter Usage

INSERT INTO FilterUsage (user_id, filter_id, used_at) VALUES
(1, 1, '2025-03-06 14:00:00'),
(2, 2, '2025-03-06 15:30:00'),
(3, 3, '2025-03-06 16:45:00'),
(4, 4, '2025-03-06 12:20:00'),
(5, 5, '2025-03-06 18:00:00'),
(6, 6, '2025-03-06 19:15:00'),
(7, 1, '2025-03-06 10:30:00'),
(8, 2, '2025-03-06 11:45:00'),
(9, 3, '2025-03-06 13:55:00'),
(10, 4, '2025-03-06 17:10:00'),
(11, 5, '2025-03-06 20:25:00'),
(12, 6, '2025-03-06 22:00:00'),
(13, 1, '2025-03-06 21:40:00'),
(14, 2, '2025-03-06 23:55:00'),
(15, 3, '2025-03-06 08:10:00');

-- Exploratory Data Analysis
SELECT * FROM filters;
SELECT * FROM filterusage;
SELECT * FROM messages;
SELECT * FROM streaks;
SELECT * FROM users;

-- 1) Find All Users ?
SELECT * FROM users;

-- 2) Find All Messages ?
SELECT * FROM messages;

-- 3) Find Streaks with Count Greater Than 10 ?
SELECT streak_count
FROM streaks
WHERE streak_count > 10;

-- 4) Find Messages That Contain the Word "Hey" ?
SELECT message_text
FROM messages
WHERE message_text LIKE "%Hey%";

-- 5) Count Total Users ?
SELECT COUNT(user_id) AS Total_Users
FROM users;

-- 6) Find Users Born After the Year 2000 ?
SELECT * 
FROM users
WHERE YEAR(date_of_birth) > 2000;

-- 7) Find All Unread Messages ?
SELECT message_id, message_text, sent_at
FROM messages
WHERE is_read = 0;

-- 8) Find Users Who Used a Specific Filter ('Cat Whiskers') ?
SELECT u.username
FROM users u 
JOIN filters f ON u.created_at = f.created_at
WHERE filter_name = "Cat Whiskers";

-- 9) Find Most Used Filter by Users ?
SELECT f.filter_name, COUNT(fu.usage_id) AS total_usage
FROM filters f
JOIN filterusage fu ON f.filter_id = fu.filter_id
GROUP BY f.filter_name
ORDER BY total_usage DESC;

-- 10)  Find all filters sorted alphabetically in ascending order ?
SELECT filter_name
FROM filters
ORDER BY filter_name;



