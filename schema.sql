

CREATE DATABASE IF NOT EXISTS portfolio_db;
USE portfolio_db;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS contact_messages;
DROP TABLE IF EXISTS documents;
DROP TABLE IF EXISTS certificates;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS login_logs;
DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS skills;
DROP TABLE IF EXISTS achievements;
DROP TABLE IF EXISTS students;

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
    password VARCHAR(100) DEFAULT 'password',
    semester INT DEFAULT 4
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    tech_stack VARCHAR(300),
    github_url VARCHAR(255),
    live_demo_url VARCHAR(255),
    image_path VARCHAR(255),
    student_id INT,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE skills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category VARCHAR(50) NOT NULL,
    name VARCHAR(100) NOT NULL,
    proficiency_percent INT DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE achievements (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  student_id INT DEFAULT NULL,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  date_achieved DATE DEFAULT NULL,
  icon VARCHAR(50) DEFAULT 'bi-trophy',
  FOREIGN KEY (student_id) REFERENCES students (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE contact_messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    subject VARCHAR(200),
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE documents (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    title VARCHAR(200) NOT NULL,
    file_path VARCHAR(255) NOT NULL,
    upload_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE certificates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    title VARCHAR(200) NOT NULL,
    file_path VARCHAR(255) NOT NULL,
    issue_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE attendance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    subject VARCHAR(200) NOT NULL,
    total_classes INT DEFAULT 0,
    attended INT DEFAULT 0,
    percentage DECIMAL(5,2) DEFAULT 0.00,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE login_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    user_name VARCHAR(100),
    role VARCHAR(100),
    login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



INSERT INTO students (id, name, branch, role, bio, github_url, linkedin_url, resume_url, photo_path, password, semester) VALUES
(1, 'Kushagra Tomar', 'B.Tech Computer Science Engineering', 'student', 'Passionate full-stack developer focusing on Java and modern web technologies.', 'https://github.com/kushagratomar', 'https://linkedin.com/in/kushagratomar', '#', 'images/student1.jpg', 'password123', 4),
(2, 'Bhagyesh', 'B.Tech Computer Science Engineering', 'student', 'Frontend enthusiast and UI/UX designer.', 'https://github.com/bhagyesh', 'https://linkedin.com/in/bhagyesh', '#', 'images/student2.jpg', 'password123', 4),
(3, 'Harshit', 'B.Tech Computer Science Engineering', 'student', 'Backend engineer and database specialist.', 'https://github.com/harshit', 'https://linkedin.com/in/harshit', '#', 'images/student3.jpg', 'password123', 4),
(4, 'System Admin', 'Administration', 'admin', 'System administrator account.', '', '', '', 'images/admin.jpg', 'admin123', 0);


INSERT INTO projects (title, description, tech_stack, github_url, live_demo_url, image_path, student_id) VALUES
('E-Commerce Platform', 'A full-featured online shopping platform.', 'Java, Spring Boot', 'https://github.com/kushagratomar/ecommerce', '#', 'images/project1.jpg', 1),
('AI Chat Assistant', 'Intelligent chatbot.', 'Python, React', 'https://github.com/kushagratomar/ai-chat', '#', 'images/project2.jpg', 1),
('Portfolio Design System', 'Component library built for rapid prototyping.', 'React, TypeScript', 'https://github.com/bhagyesh/design', '#', 'images/project3.jpg', 2),
('Cloud Infrastructure Monitor', 'Real-time cloud monitoring dashboard.', 'Python, Django', 'https://github.com/harshit/cloud', '#', 'images/project2.jpg', 3);


INSERT INTO documents (student_id, title, file_path) VALUES
(1, '10th Marksheet', 'documents/10th_marksheet.pdf'),
(1, '12th Marksheet', 'documents/12th_marksheet.pdf'),
(1, 'Aadhaar Card', 'documents/aadhaar.pdf'),
(1, 'Sem-4 Result', 'documents/sem4_result.pdf'),
(2, '10th Marksheet', 'documents/10th_marksheet.pdf'),
(2, '12th Marksheet', 'documents/12th_marksheet.pdf'),
(2, 'Aadhaar Card', 'documents/aadhaar.pdf'),
(2, 'Sem-4 Result', 'documents/sem4_result.pdf'),
(3, '10th Marksheet', 'documents/10th_marksheet.pdf'),
(3, '12th Marksheet', 'documents/12th_marksheet.pdf'),
(3, 'Aadhaar Card', 'documents/aadhaar.pdf'),
(3, 'Sem-4 Result', 'documents/sem4_result.pdf');


INSERT INTO attendance (student_id, subject, total_classes, attended, percentage) VALUES
(1, 'Data Structures', 40, 36, 90.00),
(1, 'Computer Networks', 35, 30, 85.71),
(2, 'Data Structures', 40, 38, 95.00),
(2, 'Computer Networks', 35, 28, 80.00),
(3, 'Data Structures', 40, 32, 80.00),
(3, 'Computer Networks', 35, 34, 97.14);


INSERT INTO achievements (student_id, title, description, icon) VALUES
(1, 'Hackathon Winner', '1st place in state hackathon', 'bi-trophy'),
(2, 'UI Design Award', 'Best UI/UX for E-commerce app', 'bi-palette'),
(3, 'Code Optimization', 'Top 5% in Algorithm coding competition', 'bi-code-slash');

SET FOREIGN_KEY_CHECKS = 1;
