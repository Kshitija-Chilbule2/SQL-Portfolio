CREATE DATABASE PANDAS;
USE PANDAS;

-- Table: Endangered_Status
CREATE TABLE Endangered_Status (
    Status_ID INT PRIMARY KEY,
    Status_Name VARCHAR(50),
    Threat_Level VARCHAR(50)
);

INSERT INTO Endangered_Status (Status_ID, Status_Name, Threat_Level) VALUES
(1, 'Endangered', 'High'),
(2, 'Vulnerable', 'Medium'),
(3, 'Least Concern', 'Low');

-- Table: Conservation_Centers
CREATE TABLE Conservation_Centers (
    Center_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Location VARCHAR(100),
    Established_Year INT,
    Number_of_Pandas INT,
    Funding DECIMAL(10,2),
    Research_Focus VARCHAR(255),
    Protected_Area DECIMAL(6,2),
    Contact_Email VARCHAR(100),
    Contact_Number VARCHAR(20)  -- Increased length to prevent truncation errors
);

INSERT INTO Conservation_Centers (Center_ID, Name, Location, Established_Year, Number_of_Pandas, Funding, Research_Focus, Protected_Area, Contact_Email, Contact_Number) VALUES
(1, 'Wolong National Nature Reserve', 'China', 1963, 50, 5000000.00, 'Breeding and Research', 200.5, 'contact@wolong.cn', '+86-10-12345678'),
(2, 'Chengdu Research Base', 'China', 1987, 80, 7000000.00, 'Panda Breeding and Conservation', 100.8, 'info@chengdupanda.org', '+86-28-98765432'),
(3, 'Bifengxia Panda Base', 'China', 2004, 40, 4500000.00, 'Panda Rehabilitation', 50.3, 'support@bifengxia.cn', '+86-20-56781234'),
(4, 'Beijing Zoo Panda House', 'China', 1955, 20, 3000000.00, 'Panda Education and Display', 30.2, 'panda@beijingzoo.cn', '+86-10-11223344'),
(5, 'Smithsonian’s National Zoo', 'USA', 1972, 5, 2000000.00, 'Panda Research Collaboration', 15.0, 'panda@nationalzoo.si.edu', '+1-202-633-4888'),
(6, 'Zoo Atlanta', 'USA', 1999, 4, 1800000.00, 'Panda Conservation Program', 10.5, 'panda@zooatlanta.org', '+1-404-624-5600'),
(7, 'Edinburgh Zoo', 'UK', 2011, 2, 1500000.00, 'Panda Education & Awareness', 8.0, 'panda@edinburghzoo.org.uk', '+44-131-334-9171'),
(8, 'Ocean Park Hong Kong', 'Hong Kong', 1977, 4, 2200000.00, 'Panda Breeding', 12.7, 'panda@oceanpark.com.hk', '+852-3923-2323'),
(9, 'Vienna Zoo', 'Austria', 2003, 3, 1300000.00, 'Panda Breeding and Research', 7.5, 'panda@zoovienna.at', '+43-1-877-9294'),
(10, 'Adelaide Zoo', 'Australia', 2009, 2, 1200000.00, 'Panda Awareness & Tourism', 6.5, 'panda@adelaidezoo.com.au', '+61-8-8267-3255');

-- Table: Panda_Info
CREATE TABLE Panda_Info (
    Panda_ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    Gender VARCHAR(10),
    Weight DECIMAL(5,2),
    Species VARCHAR(50),
    Health_Status VARCHAR(50),
    Conservation_Center_ID INT,
    Endangered_Status_ID INT,
    FOREIGN KEY (Conservation_Center_ID) REFERENCES Conservation_Centers(Center_ID) ON DELETE CASCADE,
    FOREIGN KEY (Endangered_Status_ID) REFERENCES Endangered_Status(Status_ID) ON DELETE CASCADE
);

INSERT INTO Panda_Info (Panda_ID, Name, Age, Gender, Weight, Species, Health_Status, Conservation_Center_ID, Endangered_Status_ID) VALUES
(1, 'Xiao Qi Ji', 3, 'Male', 90.5, 'Giant Panda', 'Healthy', 5, 1),
(2, 'Mei Xiang', 26, 'Female', 105.2, 'Giant Panda', 'Healthy', 5, 1),
(3, 'Tian Tian', 26, 'Male', 110.3, 'Giant Panda', 'Healthy', 5, 1),
(4, 'Ying Ying', 18, 'Female', 98.7, 'Giant Panda', 'Healthy', 8, 2),
(5, 'Le Le', 18, 'Male', 100.0, 'Giant Panda', 'Healthy', 8, 2),
(6, 'Yang Yang', 26, 'Male', 115.5, 'Giant Panda', 'Healthy', 9, 2),
(7, 'Fu Bao', 4, 'Female', 85.3, 'Giant Panda', 'Healthy', 9, 2),
(8, 'Bao Bao', 11, 'Female', 95.8, 'Giant Panda', 'Healthy', 10, 2),
(9, 'Yuan Meng', 6, 'Male', 90.2, 'Giant Panda', 'Healthy', 10, 2),
(10, 'An An', 30, 'Male', 110.0, 'Giant Panda', 'Healthy', 8, 1),
(11, 'Hua Mei', 25, 'Female', 108.4, 'Giant Panda', 'Healthy', 3, 1),
(12, 'Qing Qing', 8, 'Female', 95.0, 'Giant Panda', 'Healthy', 3, 1),
(13, 'Ai Bao', 9, 'Female', 96.0, 'Giant Panda', 'Healthy', 2, 1),
(14, 'Li Li', 10, 'Male', 102.1, 'Giant Panda', 'Healthy', 2, 1),
(15, 'Xing Xing', 7, 'Male', 91.3, 'Giant Panda', 'Healthy', 1, 1),
(16, 'Ping Ping', 6, 'Female', 88.9, 'Giant Panda', 'Healthy', 1, 1),
(17, 'Zhen Zhen', 5, 'Female', 86.7, 'Giant Panda', 'Healthy', 4, 2),
(18, 'Ming Ming', 12, 'Male', 99.5, 'Giant Panda', 'Healthy', 6, 2),
(19, 'Yuan Yuan', 11, 'Female', 97.6, 'Giant Panda', 'Healthy', 7, 2),
(20, 'Gao Gao', 31, 'Male', 120.5, 'Giant Panda', 'Healthy', 3, 1);

-- Exploratory Data Analysis 

SELECT * FROM conservation_centers;
SELECT * FROM endangered_status;
SELECT * FROM panda_info;

-- 1) Find the names and ages of all pandas ?
SELECT Name, Age
FROM panda_info;

-- 2) Find all Conservation Centers ?
SELECT Name, Location
FROM conservation_centers;

-- 3) Find all pandas living at 'Chengdu Research Base' and show their details ?
SELECT pi.Name AS Panda_Name, pi.Age AS Panda_Age, cc.Name AS Conservation_Center
FROM panda_info pi
JOIN conservation_centers cc ON pi.Conservation_Center_ID = cc.Center_ID
WHERE cc.Name = 'Chengdu Research Base'
ORDER BY Panda_Age DESC;

-- 4) Find Pandas That Are Endangered ?
SELECT pi.Name, pi.Age, pi.Gender
FROM panda_info pi
JOIN endangered_status es ON pi.Endangered_Status_ID = es.Status_ID
WHERE es.Status_Name = "Endangered"
ORDER BY pi.Age DESC;

-- 5) Count Number of Pandas in Each Conservation Center ?
SELECT cc.Name, cc.Location, COUNT(DISTINCT pi.Panda_ID) AS Total_Pandas 
FROM conservation_centers cc
JOIN panda_info pi ON cc.Center_ID = pi.Conservation_Center_ID
GROUP BY cc.Name, cc.Location
ORDER BY Total_Pandas DESC;

-- 6) Find the Oldest Panda in the Database ?
SELECT Name, Age
FROM panda_info
WHERE Age = (SELECT MAX(Age) FROM panda_info);

-- 7) Find Conservation Centers Established Before the Year 2000 ?
SELECT Name, Location, Established_Year
FROM conservation_centers
WHERE Established_Year < 2000;

-- 8) Find Pandas with Weight More Than 100kg ?
SELECT Name, Age, Gender, Weight
FROM panda_info
WHERE Weight > 100;

-- 9) Calculate the Average Weight of Pandas in Each Conservation Center ?
SELECT cc.Name AS Conservation_Center, AVG(pi.Weight) AS Avg_Weight
FROM conservation_centers cc
JOIN panda_info pi ON cc.Center_ID = pi.Conservation_Center_ID
GROUP BY Conservation_Center
ORDER BY Avg_Weight DESC;

-- 10) Find the name and location of the conservation center where the panda "Xiao Qi Ji" is located ?
SELECT pi.Name AS Panda_Name, cc.Name AS Conservation_Center, cc.Location AS Conservation_Center_Location
FROM panda_info pi
JOIN Conservation_Centers cc ON pi.Conservation_Center_ID = cc.Center_ID
GROUP BY Panda_Name, Conservation_Center, Conservation_Center_Location
HAVING Panda_Name = "Xiao Qi Ji";
