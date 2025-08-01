CREATE DATABASE Murder;
USE Murder;

-- 1. Cases Table: Stores crime cases
CREATE TABLE Cases (
    case_id INT PRIMARY KEY AUTO_INCREMENT,
    case_name VARCHAR(255) NOT NULL,
    crime_type ENUM('Murder', 'Robbery', 'Assault', 'Fraud') NOT NULL,
    case_status ENUM('Open', 'Closed', 'Under Investigation') DEFAULT 'Open',
    crime_date DATE NOT NULL,
    location VARCHAR(255),
    investigating_officer VARCHAR(255)
);

-- 2. Suspects Table: Stores suspect details
CREATE TABLE Suspects (
    suspect_id INT PRIMARY KEY AUTO_INCREMENT,
    case_id INT,
    suspect_name VARCHAR(255) NOT NULL,
    age INT,
    gender ENUM('Male', 'Female', 'Other'),
    criminal_record BOOLEAN DEFAULT FALSE,
    relationship_with_victim VARCHAR(255),
    status ENUM('Arrested', 'Under Surveillance', 'Cleared') DEFAULT 'Under Surveillance',
    FOREIGN KEY (case_id) REFERENCES Cases(case_id) ON DELETE CASCADE
);

-- 3. Victims Table: Stores victim details
CREATE TABLE Victims (
    victim_id INT PRIMARY KEY AUTO_INCREMENT,
    case_id INT,
    victim_name VARCHAR(255) NOT NULL,
    age INT,
    gender ENUM('Male', 'Female', 'Other'),
    cause_of_death VARCHAR(255),
    time_of_death TIMESTAMP,
    FOREIGN KEY (case_id) REFERENCES Cases(case_id) ON DELETE CASCADE
);

-- 4. Evidence Table: Stores evidence details
CREATE TABLE Evidence (
    evidence_id INT PRIMARY KEY AUTO_INCREMENT,
    case_id INT,
    evidence_type VARCHAR(255) NOT NULL,
    description TEXT,
    collected_from VARCHAR(255),
    forensic_report TEXT,
    date_collected DATE,
    FOREIGN KEY (case_id) REFERENCES Cases(case_id) ON DELETE CASCADE
);

-- Insert Sample Data into Cases Table
INSERT INTO Cases (case_id, case_name, crime_type, case_status, crime_date, location, investigating_officer) VALUES
(1, 'Downtown Apartment Murder', 'Murder', 'Under Investigation', '2025-02-10', 'Downtown, NY', 'Detective John Doe'),
(2, 'Highway Robbery Incident', 'Robbery', 'Closed', '2025-01-15', 'I-95 Highway, NJ', 'Officer Mike Thompson'),
(3, 'Corporate Fraud Case', 'Fraud', 'Open', '2024-12-20', 'Wall Street, NY', 'Detective Sarah Lee'),
(4, 'Park Assault Case', 'Assault', 'Under Investigation', '2025-02-05', 'Central Park, NY', 'Officer David Kim'),
(5, 'Suburban Homicide', 'Murder', 'Closed', '2024-11-30', 'Brooklyn, NY', 'Detective Maria Gonzalez'),
(6, 'Bank Robbery', 'Robbery', 'Under Investigation', '2025-01-25', 'Fifth Avenue, NY', 'Detective Alan Carter'),
(7, 'Domestic Dispute Turned Murder', 'Murder', 'Open', '2024-12-15', 'Queens, NY', 'Detective Chris Johnson'),
(8, 'Hit and Run Assault', 'Assault', 'Closed', '2025-02-18', 'Broadway, NY', 'Officer Emily Brown'),
(9, 'Pension Fund Fraud', 'Fraud', 'Under Investigation', '2024-12-10', 'New Jersey, NJ', 'Detective Mark Rivera'),
(10, 'Warehouse Shooting', 'Murder', 'Under Investigation', '2025-03-01', 'Industrial Zone, NY', 'Detective Laura Scott');

-- Insert Sample Data into Suspects Table
INSERT INTO Suspects (case_id, suspect_name, age, gender, criminal_record, relationship_with_victim, status) VALUES
(1, 'Michael Burns', 34, 'Male', TRUE, 'Neighbor', 'Under Surveillance'),
(1, 'Sara Jones', 29, 'Female', FALSE, 'Business Partner', 'Cleared'),
(2, 'Tom Richardson', 40, 'Male', TRUE, 'Unknown', 'Arrested'),
(3, 'Lisa Carter', 45, 'Female', TRUE, 'Finance Manager', 'Under Surveillance'),
(4, 'James Smith', 30, 'Male', FALSE, 'Acquaintance', 'Cleared'),
(5, 'Oliver King', 38, 'Male', TRUE, 'Family Friend', 'Arrested'),
(6, 'Emma Taylor', 28, 'Female', FALSE, 'Ex-Employee', 'Under Surveillance'),
(7, 'Daniel Foster', 32, 'Male', TRUE, 'Spouse', 'Arrested'),
(8, 'Sophia Martinez', 27, 'Female', FALSE, 'Friend', 'Cleared'),
(9, 'Andrew Cooper', 50, 'Male', TRUE, 'Co-worker', 'Under Surveillance');

-- Insert Sample Data into Victims Table
INSERT INTO Victims (case_id, victim_name, age, gender, cause_of_death, time_of_death) VALUES
(1, 'John Parker', 42, 'Male', 'Gunshot Wound', '2025-02-10 22:30:00'),
(2, 'Unidentified', 50, 'Male', 'Blunt Force Trauma', '2025-01-15 03:45:00'),
(3, 'Rebecca Moore', 38, 'Female', 'Financial Ruin (Suicide)', '2024-12-22 14:00:00'),
(4, 'Daniel Reed', 26, 'Male', 'Head Trauma', '2025-02-05 18:20:00'),
(5, 'Sophia Bennett', 35, 'Female', 'Strangulation', '2024-11-30 23:10:00'),
(6, 'Security Guard', 55, 'Male', 'Gunshot Wound', '2025-01-25 21:50:00'),
(7, 'Laura Wilson', 30, 'Female', 'Stabbing', '2024-12-15 17:40:00'),
(8, 'Jason Clark', 29, 'Male', 'Car Accident', '2025-02-18 20:10:00'),
(9, 'Mark Rogers', 60, 'Male', 'Poisoning', '2024-12-10 09:00:00'),
(10, 'Anthony Wright', 45, 'Male', 'Multiple Gunshot Wounds', '2025-03-01 02:15:00');

-- Insert Sample Data into Evidence Table
INSERT INTO Evidence (case_id, evidence_type, description, collected_from, forensic_report, date_collected) VALUES
(1, 'Weapon', 'Handgun with fingerprints', 'Crime Scene', 'Match found for suspect Michael Burns', '2025-02-11'),
(1, 'CCTV Footage', 'Security camera footage of suspect entering the building', 'Apartment Lobby', 'Confirmed suspect presence', '2025-02-11'),
(2, 'Stolen Wallet', 'Victim’s wallet found near highway', 'Crime Scene', 'Contains fingerprints of Tom Richardson', '2025-01-16'),
(3, 'Financial Documents', 'Fraudulent contracts discovered', 'Victim’s Office', 'Forgery confirmed', '2024-12-21'),
(4, 'Bloody Shirt', 'Shirt found in trash bin', 'Park Dumpster', 'Blood type matches victim', '2025-02-06'),
(5, 'Rope', 'Used to strangle the victim', 'Victim’s House', 'DNA matches suspect', '2024-12-01'),
(6, 'Security Camera Footage', 'Shows masked robbers', 'Bank', 'Identity unclear', '2025-01-26'),
(7, 'Knife', 'Murder weapon', 'Kitchen Sink', 'Fingerprints match suspect', '2024-12-16'),
(8, 'Car Tire Marks', 'Skid marks matching suspect vehicle', 'Crime Scene', 'Matched to suspect vehicle', '2025-02-19'),
(9, 'Poison Bottle', 'Found in victim’s office', 'Desk Drawer', 'Contains arsenic', '2024-12-11');
														
													
-- Exploratory Data Analysis
SELECT * FROM cases;
SELECT * FROM evidence;
SELECT * FROM suspects;
SELECT * FROM victims;

-- 1) Find all criminal cases ?
SELECT * FROM cases;

-- 2) Find all suspects in the database ?
SELECT DISTINCT c.case_name, c.crime_type, c.crime_date, c.location, s.suspect_name, s.age, s.gender, s.criminal_record, s.relationship_with_victim, s.status
FROM cases c
JOIN suspects s ON c.case_id = s.case_id
GROUP BY c.case_name, c.crime_type, c.crime_date, c.location, s.suspect_name, s.age, s.gender, s.criminal_record, s.relationship_with_victim, s.status;

-- 3) Find the names and ages of all victims ?
SELECT c.case_name, v.victim_name, v.age 
FROM cases c
JOIN victims v ON c.case_id = v.case_id
GROUP BY c.case_name, v.victim_name, v.age
ORDER BY v.age DESC;

-- 4) List all pieces of evidence collected along with their descriptions ?
SELECT c.case_name, e.evidence_type, e.description
FROM cases c
JOIN evidence e ON c.case_id = e.case_id
GROUP BY c.case_name, e.evidence_type, e.description;

-- 5) Find all cases that occurred between January 1, 2024, and January 1, 2025 ?
SELECT case_name
FROM cases 
WHERE crime_date BETWEEN '2024-01-01' AND '2025-01-01';

-- 6) List all victims aged above 40 ?
SELECT c.case_name, v.victim_name, v.age
FROM cases c
JOIN victims v ON c.case_id = v.case_id
WHERE v.age > 40
ORDER BY v.age DESC;

-- 7) Find the suspect whose names start with the letter "L" ?
SELECT suspect_name
FROM suspects
WHERE suspect_name LIKE "L%";

-- 8) List suspects along with the case they are associated with ?
SELECT c.case_name, s.suspect_name
FROM cases c
JOIN suspects s ON c.case_id = s.case_id
GROUP BY c.case_name, s.suspect_name;

-- 9) Count the number of victims in each crime type ?
SELECT c.case_name, c.crime_type, COUNT(DISTINCT v.victim_id) AS Total_Victims
FROM cases c
JOIN victims v ON c.case_id = v.case_id
GROUP BY c.case_name, c.crime_type
ORDER BY Total_Victims DESC;

-- 10) Find out how many cases are currently open, closed, or under investigation ?
SELECT case_status, COUNT(*) AS Total_Cases
FROM cases
WHERE case_status IN ("Open", "Closed", "Under Investigation")
GROUP BY case_status
ORDER BY Total_Cases DESC;