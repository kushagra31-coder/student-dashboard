-- ============================================
-- Student Portfolio Dashboard Database Schema
-- Aligned with Outrun Redesign
-- ============================================

CREATE DATABASE IF NOT EXISTS portfolio_db;
USE portfolio_db;

-- 1. Drop existing tables if they exist
DROP TABLE IF EXISTS documents;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS placements;
DROP TABLE IF EXISTS login_logs;
DROP TABLE IF EXISTS achievements;
DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS skills;
DROP TABLE IF EXISTS contact_messages;
DROP TABLE IF EXISTS students;

-- 2. Students Table
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
    password VARCHAR(100) NOT NULL,
    semester INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Projects Table
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

-- 4. Achievements Table
CREATE TABLE achievements (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    icon VARCHAR(100) DEFAULT 'bi-trophy-fill',
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. Attendance Table
CREATE TABLE attendance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    subject VARCHAR(200) NOT NULL,
    total_classes INT NOT NULL,
    attended INT NOT NULL,
    percentage DECIMAL(5,2) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 6. Documents Table
CREATE TABLE documents (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    title VARCHAR(200) NOT NULL,
    file_path VARCHAR(255) NOT NULL,
    upload_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 7. Login Logs Table
CREATE TABLE login_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    user_name VARCHAR(100) NOT NULL,
    role VARCHAR(50) NOT NULL,
    login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 8. Contact Messages Table
CREATE TABLE contact_messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    subject VARCHAR(200),
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 9. Skills Table
CREATE TABLE skills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category VARCHAR(50) NOT NULL,
    name VARCHAR(100) NOT NULL,
    proficiency_percent INT DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================
-- Seed Data
-- ============================================

-- Seed Students (3 Students + 1 Admin)
INSERT INTO students (id, name, branch, role, bio, github_url, linkedin_url, resume_url, photo_path, password, semester) VALUES
(1, 'Kushagra Singh Tomar', 'B.Tech Computer Science Engineering', 'Full-Stack Developer', 'Passionate full-stack developer with expertise in Java, Spring Boot, and React. Loves building scalable web applications and contributing to open-source projects. Currently exploring cloud-native architectures.', 'https://github.com/kushagra31-coder', 'https://linkedin.com/in/kushagra-singh-tomar-94ba55277/', '#', 'images/student1.jpg', 'kushagra@123', 6),
(2, 'Bhagyesh Jain', 'B.Tech Computer Science Engineering', 'UI/UX Designer', 'Creative UI/UX designer specialized in modern responsive layouts and user research. Experienced in wireframing, interactive prototyping in Figma, and frontend integration with modern CSS variables.', 'https://github.com/bhagyesh-jain', 'https://www.linkedin.com/in/bhagyesh-jain-a1a86a3a2/', '#', 'images/student2.jpg', 'bhagyesh@123', 6),
(3, 'Harshit Singhi', 'B.Tech Computer Science Engineering', 'Backend Engineer', 'Devoted backend engineer focused on distributed systems, databases, and microservices logic. Passionate about system performance, JDBC telemetry logging, and security filters.', 'https://github.com/HarshDuck', '#', '#', 'images/student3.jpg', 'harshit@123', 6),
(4, 'Admin', 'Administration', 'admin', 'System Administrator', '#', '#', '#', 'images/admin.jpg', 'admin@123', 0);

-- Seed Projects (2 per student)
INSERT INTO projects (title, description, tech_stack, github_url, live_demo_url, image_path, student_id) VALUES
('E-Commerce Platform', 'A full-featured online shopping platform with product catalog, cart management, and payment integration. Built with microservices architecture.', 'Java, Spring Boot, React, MySQL, Docker', 'https://github.com/kushagra31-coder/ecommerce', '#', 'images/project1.jpg', 1),
('AI Chat Assistant', 'An intelligent chatbot powered by natural language processing that can assist with code debugging and summarize documents.', 'Python, FastAPI, OpenAI API, React, Redis', 'https://github.com/kushagra31-coder/ai-chat', '#', 'images/project2.jpg', 1),
('Portfolio Design System', 'A comprehensive design system and component library built for rapid prototyping. Includes dark/light themes and storybook docs.', 'React, TypeScript, Figma, CSS Modules', 'https://github.com/bhagyesh-jain/design-system', '#', 'images/project3.jpg', 2),
('Health & Fitness Tracker', 'A mobile-first web app for tracking workouts, nutrition, and health metrics. Designed with accessibility and usability in mind.', 'Vue.js, Node.js, MongoDB, Chart.js', 'https://github.com/bhagyesh-jain/fitness-tracker', '#', 'images/project1.jpg', 2),
('Cloud Infrastructure Monitor', 'Real-time cloud infrastructure monitoring dashboard with cost analytics and alerting. Supports AWS, GCP, and Azure.', 'Python, Django, Grafana, Prometheus', 'https://github.com/HarshDuck/cloud-monitor', '#', 'images/project2.jpg', 3),
('CI/CD Pipeline Builder', 'A visual builder for creating automated CI/CD workflows. Supports visual pipelines and YAML export.', 'Go, React, PostgreSQL, Docker', 'https://github.com/HarshDuck/pipeline-builder', '#', 'images/project3.jpg', 3);

-- Seed Achievements
INSERT INTO achievements (student_id, title, description, icon) VALUES
(1, 'Hackathon Winner', 'Won 1st place in the university annual web development hackathon.', 'bi-trophy-fill'),
(1, 'AWS Certified', 'Successfully passed the AWS Certified Cloud Practitioner exam.', 'bi-award-fill'),
(2, 'Best Design Award', 'Awarded Best UI/UX Design at the regional tech symposium.', 'bi-brush-fill'),
(2, 'Figma Certified', 'Completed professional Advanced UI design cert from Figma.', 'bi-file-code-fill'),
(3, 'ACM ICPC Finalist', 'Qualified for regional ACM ICPC competitive coding contest.', 'bi-cpu-fill'),
(3, 'Oracle Certified Java Dev', 'Completed Oracle Certified Professional Java SE Programmer credential.', 'bi-shield-check');

-- Seed Attendance
INSERT INTO attendance (student_id, subject, total_classes, attended, percentage) VALUES
(1, 'Data Structures', 45, 40, 88.89),
(1, 'Operating Systems', 42, 38, 90.48),
(1, 'DBMS', 40, 35, 87.50),
(1, 'Computer Networks', 38, 34, 89.47),
(2, 'Data Structures', 45, 42, 93.33),
(2, 'Operating Systems', 42, 40, 95.24),
(2, 'DBMS', 40, 37, 92.50),
(2, 'Computer Networks', 38, 36, 94.74),
(3, 'Data Structures', 45, 30, 66.67),
(3, 'Operating Systems', 42, 28, 66.67),
(3, 'DBMS', 40, 32, 80.00),
(3, 'Computer Networks', 38, 25, 65.79);

-- Seed Documents
INSERT INTO documents (student_id, title, file_path, upload_date) VALUES
(1, 'Resume', 'files/resume.pdf', CURRENT_TIMESTAMP),
(1, 'Semester 3 Marksheet', 'docs/sem3_marks.pdf', CURRENT_TIMESTAMP),
(1, 'SIH Certificate', 'docs/sih_cert.pdf', CURRENT_TIMESTAMP),
(1, 'Workshop Certificate', 'docs/workshop_cert.pdf', CURRENT_TIMESTAMP),
(2, 'Resume', 'files/resume.pdf', CURRENT_TIMESTAMP),
(2, 'Semester 3 Marksheet', 'docs/sem3_marks.pdf', CURRENT_TIMESTAMP),
(2, 'SIH Certificate', 'docs/sih_cert.pdf', CURRENT_TIMESTAMP),
(2, 'Workshop Certificate', 'docs/workshop_cert.pdf', CURRENT_TIMESTAMP),
(3, 'Resume', 'files/resume.pdf', CURRENT_TIMESTAMP),
(3, 'Semester 3 Marksheet', 'docs/sem3_marks.pdf', CURRENT_TIMESTAMP),
(3, 'SIH Certificate', 'docs/sih_cert.pdf', CURRENT_TIMESTAMP),
(3, 'Workshop Certificate', 'docs/workshop_cert.pdf', CURRENT_TIMESTAMP);
