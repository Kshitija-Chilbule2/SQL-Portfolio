CREATE DATABASE Youtube;
USE youtube;

-- Table: youtube_channels
	CREATE TABLE youtube_channels (
		channel_id INT PRIMARY KEY,
		channel_name VARCHAR(100) NOT NULL,
		category VARCHAR(50) NOT NULL,
		subscribers VARCHAR(10) NOT NULL, -- Using VARCHAR because of 'M' and 'K' suffixes
		avg_views VARCHAR(20) NOT NULL, -- Stored as VARCHAR due to 'M' and 'K'
		nox_score DECIMAL(10,2) NOT NULL
	);
	
	-- Insert sample data for youtube_channels
	INSERT INTO youtube_channels (channel_id, channel_name, category, subscribers, avg_views, nox_score) VALUES
	(1, 'MrBeast', 'Entertainment', '370M', '187.67M', 0.5),
	(2, 'T-Series', 'Music', '288M', '336.88K', 48.2),
	(3, 'Cocomelon - Nursery Rhymes', 'Education', '190M', '2.95M', 0.8),
	(4, 'SET India', 'Entertainment', '182M', '15.61K', 4.3),
	(5, 'Vlad and Niki', 'Entertainment', '135M', '3.44M', 24.3),
	(6, 'Kids Diana Show', 'Entertainment', '131M', '4.2M', 8.5),
	(7, 'Like Nastya', 'Entertainment', '126M', '15.04M', 4.8),
	(8, 'Stokes Twins', 'People & Blogs', '116M', '77.77M', 5.4),
	(9, 'Zee Music Company', 'Music', '115M', '1.37M', 467.1),
	(10, 'PewDiePie', 'Gaming', '110M', '2.98M', 0.9);
	
	-- Table: channel_revenue
	CREATE TABLE channel_revenue (
		revenue_id INT PRIMARY KEY AUTO_INCREMENT,
		channel_id INT NOT NULL,
		monthly_revenue DECIMAL(15,2) NOT NULL, -- Monthly revenue in USD
		yearly_revenue DECIMAL(15,2) NOT NULL, -- Yearly revenue in USD
		FOREIGN KEY (channel_id) REFERENCES youtube_channels(channel_id) ON DELETE CASCADE
	);
	
	-- Insert sample data for channel_revenue
	INSERT INTO channel_revenue (channel_id, monthly_revenue, yearly_revenue) VALUES
	(1, 5000000.00, 60000000.00),
	(2, 4500000.00, 54000000.00),
	(3, 1500000.00, 18000000.00),
	(4, 1200000.00, 14400000.00),
	(5, 900000.00, 10800000.00),
	(6, 850000.00, 10200000.00),
	(7, 800000.00, 9600000.00),
	(8, 780000.00, 9360000.00),
	(9, 750000.00, 9000000.00),
	(10, 700000.00, 8400000.00);
	
	-- Table: channel_videos
	CREATE TABLE channel_videos (
		video_id INT PRIMARY KEY AUTO_INCREMENT,
		channel_id INT NOT NULL,
		video_title VARCHAR(255) NOT NULL,
		upload_date DATE NOT NULL,
		views BIGINT NOT NULL,
		likes BIGINT NOT NULL,
		comments INT NOT NULL,
		FOREIGN KEY (channel_id) REFERENCES youtube_channels(channel_id) ON DELETE CASCADE
	);
	
	-- Insert sample data for channel_videos
	INSERT INTO channel_videos (channel_id, video_title, upload_date, views, likes, comments) VALUES
	(1, 'Epic Challenge Video', '2024-03-01', 15000000, 500000, 10000),
	(2, 'Best Bollywood Songs', '2024-02-15', 3000000, 250000, 5000),
	(3, 'Kids Learning ABC', '2024-01-10', 5000000, 200000, 8000),
	(4, 'Comedy Skit Compilation', '2024-03-05', 2000000, 150000, 3000),
	(5, 'Vlad and Niki Adventure', '2024-02-22', 6000000, 180000, 4000),
	(6, 'Diana’s New Toys', '2024-01-30', 4000000, 175000, 3500),
	(7, 'Fun Family Vlog', '2024-02-18', 3500000, 190000, 4500),
	(8, 'Crazy Stunts Compilation', '2024-03-01', 8000000, 210000, 7000),
	(9, 'Top Music Hits 2024', '2024-02-10', 1000000, 50000, 2000),
	(10, 'Gaming Livestream Highlights', '2024-01-20', 2500000, 120000, 6000);
	
	-- Table: channel_engagement
	CREATE TABLE channel_engagement (
		engagement_id INT PRIMARY KEY AUTO_INCREMENT,
		channel_id INT NOT NULL,
		likes_per_video DECIMAL(10,2) NOT NULL,
		comments_per_video DECIMAL(10,2) NOT NULL,
		shares_per_video DECIMAL(10,2) NOT NULL,
		FOREIGN KEY (channel_id) REFERENCES youtube_channels(channel_id) ON DELETE CASCADE
	);
	
	-- Insert sample data for channel_engagement
	INSERT INTO channel_engagement (channel_id, likes_per_video, comments_per_video, shares_per_video) VALUES
	(1, 450000.50, 12000.75, 30000.25),
	(2, 300000.20, 10000.00, 25000.10),
	(3, 200000.15, 8000.25, 20000.50),
	(4, 150000.75, 5000.60, 18000.80),
	(5, 180000.50, 4000.90, 15000.60),
	(6, 175000.35, 3500.75, 14000.40),
	(7, 190000.45, 4500.85, 17000.20),
	(8, 210000.30, 7000.25, 20000.35),
	(9, 50000.00, 2000.75, 5000.80),
	(10, 120000.90, 6000.35, 9000.50);
    

-- 1) Get the top 5 most subscribed YouTube channels ?
SELECT channel_name, subscribers
FROM youtube_channels
ORDER BY 
  CASE
    WHEN RIGHT(subscribers, 1) = 'M' THEN CAST(LEFT(subscribers, LENGTH(subscribers) - 1) AS DECIMAL(10,2)) * 1000000
    WHEN RIGHT(subscribers, 1) = 'K' THEN CAST(LEFT(subscribers, LENGTH(subscribers) - 1) AS DECIMAL(10,2)) * 1000
    ELSE CAST(subscribers AS DECIMAL(10,2))
  END DESC
LIMIT 5;

-- 2) Find the total yearly revenue of all channels ?
SELECT SUM(yearly_revenue) AS total_yearly_revenue
FROM channel_revenue;

-- 3) Find the video uploaded by 'MrBeast' ?
SELECT cv.video_title, cv.upload_date
FROM channel_videos cv
JOIN youtube_channels yc ON cv.channel_id = yc.channel_id
WHERE yc.channel_name = 'MrBeast';

-- 4) Get the average engagement (likes & comments) per video for each channel ?
SELECT yc.channel_name, ce.likes_per_video, ce.comments_per_video
FROM channel_engagement ce
JOIN youtube_channels yc ON ce.channel_id = yc.channel_id;

-- 5) List channels that have a NOX score higher than 10 ?
SELECT channel_name, nox_score
FROM youtube_channels
WHERE nox_score > 10;

-- 6) Find the most commented video ?
SELECT video_title, comments
FROM channel_videos
ORDER BY comments DESC
LIMIT 1;

-- 7️) Count the total number of channels in each category ?
SELECT category, COUNT(*) AS total_channels
FROM youtube_channels
GROUP BY category;

-- 8️) Search for channel names that start with "M" and end with "t" (using Like function) ?
SELECT channel_name
FROM youtube_channels
WHERE channel_name LIKE 'M%t';

-- 9️) Find videos uploaded between '2024-03-01' AND '2024-08-01' ?
SELECT video_title, upload_date
FROM channel_videos
WHERE upload_date BETWEEN '2024-03-01' AND '2024-08-01';

-- 10) Find the top 3 most liked videos on YouTube ?
SELECT video_title, likes
FROM channel_videos
ORDER BY likes DESC
LIMIT 3;
