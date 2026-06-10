-- ============================================
-- Portfolio Database Schema & Seed Data
-- ============================================

CREATE DATABASE IF NOT EXISTS portfolio_db;
USE portfolio_db;

SET FOREIGN_KEY_CHECKS = 0;

-- Drop Existing Tables
DROP TABLE IF EXISTS contact_messages;
DROP TABLE IF EXISTS documents;
DROP TABLE IF EXISTS certificates;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS login_logs;
DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS skills;
DROP TABLE IF EXISTS achievements;
DROP TABLE IF EXISTS clubs;
DROP TABLE IF EXISTS students;

-- Students Table (Added email and phone)
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    branch VARCHAR(100) NOT NULL,
    role VARCHAR(100) NOT NULL,
    bio TEXT,
    github_url VARCHAR(255),
    linkedin_url VARCHAR(255),
    resume_url VARCHAR(255),
    photo_path VARCHAR(255),
    password VARCHAR(100) DEFAULT 'password123',
    semester INT DEFAULT 4,
    email VARCHAR(150),
    phone VARCHAR(20)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Projects Table
CREATE TABLE projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    tech_stack VARCHAR(300),
    github_url VARCHAR(255),
    live_demo_url VARCHAR(255),
    image_path VARCHAR(255),
    student_id INT,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Skills Table (Added student_id)
CREATE TABLE skills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    category VARCHAR(50) NOT NULL,
    name VARCHAR(100) NOT NULL,
    proficiency_percent INT DEFAULT 0,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Clubs Table (New)
CREATE TABLE clubs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(100) NOT NULL,
    description TEXT,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Achievements Table
CREATE TABLE achievements (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  student_id INT DEFAULT NULL,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  date_achieved DATE DEFAULT NULL,
  icon VARCHAR(50) DEFAULT 'bi-trophy',
  FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Contact Messages Table
CREATE TABLE contact_messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    subject VARCHAR(200),
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Documents Table
CREATE TABLE documents (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    title VARCHAR(200) NOT NULL,
    file_path VARCHAR(255) NOT NULL,
    upload_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Certificates Table
CREATE TABLE certificates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    title VARCHAR(200) NOT NULL,
    file_path VARCHAR(255) NOT NULL,
    issue_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Attendance Table
CREATE TABLE attendance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    subject VARCHAR(200) NOT NULL,
    total_classes INT DEFAULT 0,
    attended INT DEFAULT 0,
    percentage DECIMAL(5,2) DEFAULT 0.00,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Login Logs Table
CREATE TABLE login_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    user_name VARCHAR(100),
    role VARCHAR(100),
    login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================
-- Seed Data
-- ============================================

-- Students
INSERT INTO students (id, name, branch, role, bio, github_url, linkedin_url, resume_url, photo_path, password, semester, email, phone) VALUES
(1, 'Kushagra Tomar', 'B.Tech Computer Science Engineering', 'student', 'Passionate full-stack developer focusing on Java and modern web technologies.', 'https://github.com/kushagratomar', 'https://linkedin.com/in/kushagratomar', '#', 'images/student1.jpg', 'password123', 4, 'kushagra@dashboard.com', '+91 9876543210'),
(2, 'Bhagyesh', 'B.Tech Computer Science Engineering', 'student', 'Frontend enthusiast and UI/UX designer.', 'https://github.com/bhagyesh', 'https://linkedin.com/in/bhagyesh', '#', 'images/student2.jpg', 'password123', 4, 'bhagyesh@dashboard.com', '+91 8765432109'),
(3, 'Harshit', 'B.Tech Computer Science Engineering', 'student', 'Backend engineer and database specialist.', 'https://github.com/harshit', 'https://linkedin.com/in/harshit', '#', 'images/student3.jpg', 'password123', 4, 'harshit@dashboard.com', '+91 7654321098'),
(4, 'System Admin', 'Administration', 'admin', 'System administrator account.', '', '', '', 'images/admin.jpg', 'admin123', 0, 'admin@acropolis.in', '+91 0000000000');

-- Documents (Identical for all 3 students)
INSERT INTO documents (student_id, title, file_path) VALUES
(1, '10th Marksheet', 'documents/10th_marksheet.pdf'), (1, '12th Marksheet', 'documents/12th_marksheet.pdf'), (1, 'Aadhaar Card', 'documents/aadhaar.pdf'), (1, 'Sem-4 Result', 'documents/sem4_result.pdf'),
(2, '10th Marksheet', 'documents/10th_marksheet.pdf'), (2, '12th Marksheet', 'documents/12th_marksheet.pdf'), (2, 'Aadhaar Card', 'documents/aadhaar.pdf'), (2, 'Sem-4 Result', 'documents/sem4_result.pdf'),
(3, '10th Marksheet', 'documents/10th_marksheet.pdf'), (3, '12th Marksheet', 'documents/12th_marksheet.pdf'), (3, 'Aadhaar Card', 'documents/aadhaar.pdf'), (3, 'Sem-4 Result', 'documents/sem4_result.pdf');

-- Clubs
INSERT INTO clubs (student_id, name, role, description) VALUES
(1, 'IEEE Student Branch', 'Core Member', 'A global professional organization dedicated to advancing technology for humanity. Organizing technical workshops and symposiums.'),
(1, 'CodersHigh', 'Competitive Programmer', 'A coding club focused on competitive programming, advanced data structures, algorithms, and hackathons.'),
(2, 'Google Developer Clubs (GDC)', 'Technical Lead', 'University-based community group for students interested in Google developer technologies and modern web dev.'),
(3, 'AWS Cloud Club', 'Cloud Architect', 'Student-led community supported by AWS to learn cloud computing architecture and prepare for AWS certifications.');

-- Skills
INSERT INTO skills (student_id, category, name, proficiency_percent) VALUES
(1, 'Language', 'Java', 95), (1, 'Language', 'Python', 85), (1, 'Language', 'C++', 80), (1, 'Web', 'HTML/CSS', 90), (1, 'Database', 'MySQL', 85),
(2, 'Language', 'JavaScript', 95), (2, 'Web', 'React', 90), (2, 'Web', 'HTML/CSS', 95), (2, 'Design', 'Figma', 85), (2, 'Language', 'TypeScript', 80), (2, 'Format', 'JSON', 90),
(3, 'Language', 'Go', 90), (3, 'Language', 'Rust', 85), (3, 'Language', 'Python', 90), (3, 'Database', 'PostgreSQL', 85), (3, 'DevOps', 'Docker', 80);

-- Projects
-- Kushagra (1)
INSERT INTO projects (title, description, tech_stack, github_url, live_demo_url, image_path, student_id) VALUES
('AI Chat Assistant', 'Intelligent contextual chatbot utilizing NLP models for student queries.', 'Python, React, NLP', 'https://github.com/kushagratomar/ai-chat', '#', 'images/project1.jpg', 1),
('Quantum Encryption Simulator', 'Visual simulation tool demonstrating QKD principles over a network.', 'Java, JavaFX, Cryptography', 'https://github.com/kushagratomar/quantum-sim', '#', 'images/project2.jpg', 1),
('E-Commerce Platform', 'A full-featured online shopping platform with payment gateway integration.', 'Java, Spring Boot, MySQL', 'https://github.com/kushagratomar/ecommerce', '#', 'images/project3.jpg', 1);

-- Bhagyesh (2)
INSERT INTO projects (title, description, tech_stack, github_url, live_demo_url, image_path, student_id) VALUES
('Portfolio Design System', 'Component library built for rapid UI prototyping and consistent design.', 'React, TypeScript, CSS', 'https://github.com/bhagyesh/design', '#', 'images/project3.jpg', 2),
('Smart Campus IoT Network', 'IoT system using ESP32 to monitor library occupancy and environment.', 'C++, Vue.js, MQTT', 'https://github.com/bhagyesh/iot-campus', '#', 'images/project2.jpg', 2),
('Decentralized Voting DApp', 'Secure voting application deployed on Ethereum testnet for student elections.', 'Solidity, React, Web3', 'https://github.com/bhagyesh/voting-dapp', '#', 'images/project1.jpg', 2);

-- Harshit (3)
INSERT INTO projects (title, description, tech_stack, github_url, live_demo_url, image_path, student_id) VALUES
('Cloud Infrastructure Monitor', 'Real-time cloud monitoring dashboard tracking server health.', 'Go, React, Prometheus', 'https://github.com/harshit/cloud', '#', 'images/project1.jpg', 3),
('Autonomous Drone Navigation', 'Flight controller software utilizing computer vision for obstacle avoidance.', 'Python, OpenCV, ROS', 'https://github.com/harshit/drone-nav', '#', 'images/project2.jpg', 3),
('FinTech Budgeting App', 'Mobile app aggregating bank data to provide actionable budgeting insights.', 'Rust, Flutter, PostgreSQL', 'https://github.com/harshit/fintech', '#', 'images/project3.jpg', 3);

-- Achievements
INSERT INTO achievements (student_id, title, description, icon) VALUES
(1, 'Hackathon Winner', '1st place in state hackathon', 'bi-trophy'),
(2, 'UI Design Award', 'Best UI/UX for E-commerce app', 'bi-palette'),
(3, 'Code Optimization', 'Top 5% in Algorithm coding competition', 'bi-code-slash');

-- Contact Messages
INSERT INTO contact_messages (name, email, subject, message) VALUES
('Tech Recruiter', 'recruitment@google.com', 'Software Engineering Role', 'Hi! We loved the projects showcased on your dashboard and would like to schedule an interview.'),
('Startup Founder', 'founder@innovate.co', 'Collaboration Request', 'Your IoT project looks fascinating. Open to collaborating on a commercial version?');

SET FOREIGN_KEY_CHECKS = 1;
